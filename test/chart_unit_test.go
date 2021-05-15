package test

import (
	"path/filepath"
	"testing"

	corev1 "k8s.io/api/core/v1"

	"github.com/gruntwork-io/terratest/modules/helm"
)

func TestIconUnit(t *testing.T) {
	helmChartPath := "../charts/icon-node"

	options := &helm.Options{
		ValuesFiles: []string{
			filepath.Join("..", "examples", "prep-node", "values.yaml"),
		},
	}
	
	// Run RenderTemplate to render the template and capture the output.
	output := helm.RenderTemplate(t, options, helmChartPath, "service-grpc", []string{"templates/service-grpc.yaml"})

	// Now we use kubernetes/client-go library to render the template output into the Pod struct.
	var pod corev1.Pod
	helm.UnmarshalK8SYaml(t, output, &pod)

	if pod.TypeMeta.Kind != "Service" {
		t.Fatalf("Failed to render service.")
	}
}
