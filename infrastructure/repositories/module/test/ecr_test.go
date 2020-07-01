package test

import (
	"fmt"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestECRModule(t *testing.T) {
	workingDir := "../"
	awsAccount := "268229342313"
	awsRegion := os.Getenv("AWS_DEFAULT_REGION")
	uniqueID := random.UniqueId()
	ecrName := fmt.Sprintf("ecr-%s", strings.ToLower(uniqueID))

	// Build resources
	test_structure.RunTestStage(t, "deploy_terraform", func() {
		terraformOptions := &terraform.Options{
			TerraformDir: workingDir,
			EnvVars: map[string]string{
				"AWS_DEFAULT_REGION": awsRegion,
			},
			Vars: map[string]interface{}{
				"name": ecrName,
			},
		}
		test_structure.SaveTerraformOptions(t, workingDir, terraformOptions)
		resourcesAdded := terraform.GetResourceCount(t, terraform.InitAndApply(t, terraformOptions))
		assert.Equal(t, resourcesAdded.Add, 1)
	})

	// Test values
	test_structure.RunTestStage(t, "check_ecr_url", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, workingDir)
		url := terraform.Output(t, terraformOptions, "url")
		assert.Equal(t, fmt.Sprintf("%s.dkr.ecr.%s.amazonaws.com/%s", awsAccount, awsRegion, ecrName), url)
	})

	// Cleaning up
	test_structure.RunTestStage(t, "cleanup_terraform", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, workingDir)
		terraform.Destroy(t, terraformOptions)
	})
}
