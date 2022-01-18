resource "aws_cloudformation_stack" "github" {
  name = "${var.role_ref_id}-${var.cp_resources_name}-${var.stage}"

  parameters = {
    repository = var.github_repo
    pipeline = aws_codepipeline.codepipeline.name
    suffix = var.stage
  }

  template_body = <<STACK
{
  "Parameters" : {
    "repository" : {
      "Type" : "String",
      "Description" : "The repository name to receive events."
    },
    "pipeline" : {
      "Type" : "String",
      "Description" : "The pipeline that will be triggered once and event is received."
    },
    "suffix" : {
      "Type" : "String",
      "Default": "",
      "Description" : "Suffix for release tags to filter and trigger the pipeline."
    }
  },
  "Resources" : {
    "Webhook": {
      "Type" : "Custom::GitHubReleasesWebhook",
      "Properties" : {
        "ServiceToken" : {
          "Fn::ImportValue" : "GitHubReleasesWebhookServiceToken"
        },
        "Repo": {
          "Ref": "repository"
        },
        "Suffix": {
          "Ref": "suffix"
        },
        "Pipeline": {
          "Ref": "pipeline"
        }
      }
    }
  }
}
STACK
}
