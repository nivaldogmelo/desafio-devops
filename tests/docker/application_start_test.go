package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/docker"
	"github.com/gruntwork-io/terratest/modules/random"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestDockerStartApplication(t *testing.T) {
	image := "comment-api:develop"
	containerName := strings.ToLower(random.UniqueId())

	runOptions := &docker.RunOptions{
		Detach: true,
		Name:   containerName,
		Remove: true,
	}

	stopOptions := &docker.StopOptions{}

	test_structure.RunTestStage(t, "Run docker image", func() {
		docker.Run(t, image, runOptions)

		output := docker.Inspect(t, containerName)

		assert.Equal(t, "running", output.Status)
	})

	test_structure.RunTestStage(t, "Stop Container", func() {
		docker.Stop(t, []string{containerName}, stopOptions)
	})
}
