package test

import (
	"fmt"
	"github.com/gruntwork-io/terratest/modules/helm"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/k8s"
	"github.com/gruntwork-io/terratest/modules/random"
	"path/filepath"
	"strings"
	"testing"
	"time"
)

func TestPodDeploysContainerImage(t *testing.T) {
	helmChartPath := "../charts/icon-node"
	kubectlOptions := k8s.NewKubectlOptions("", "", "default")
	options := &helm.Options{
		ValuesFiles: []string{
			filepath.Join("..", "examples", "prep-node", "values.yaml"),
		},
	}
	releaseName := fmt.Sprintf("prep-node-%s", strings.ToLower(random.UniqueId()))
	defer helm.Delete(t, options, releaseName, true)
	// Just test that it deploys - Takes to long to test endpoints
	// TODO Find env vars to skip fast sync
	helm.Install(t, options, helmChartPath, releaseName)

	podName := fmt.Sprintf("%s-0", releaseName)
	verifyBlockSync(t, kubectlOptions, podName)
}

// verifyBlockSync will open a tunnel to the Pod and hit the endpoint to verify the node is in BlockSync state
func verifyBlockSync(t *testing.T, kubectlOptions *k8s.KubectlOptions, podName string) {
	// Wait for the pod to come up. It takes some time for the Pod to start, so retry a few times.
	retries := 15
	sleep := 5 * time.Second
	k8s.WaitUntilPodAvailable(t, kubectlOptions, podName, retries, sleep)

	// Open a tunnel to the pod, making sure to close it at the end of the test.
	tunnel := k8s.NewTunnel(kubectlOptions, k8s.ResourceTypePod, podName, 0, 9000)
	defer tunnel.Close()
	tunnel.ForwardPort(t)

	endpoint := fmt.Sprintf("http://%s/api/v1/status/peer", tunnel.Endpoint())
	http_helper.HttpGetWithRetryWithCustomValidation(
		t,
		endpoint,
		nil,
		retries,
		sleep,
		func(statusCode int, body string) bool {
			return statusCode == 200 && strings.Contains(body, "BlockSync")
		},
	)
}
