variable "aws_info" {
  type = object({
    region    = string
  })

  sensitive = true

  default = {
      region = "us-east-1"
  }
}

variable "role_ref_id" {
    type = string
    description = "The id of the role been used"
    default = "a204044"
}

variable "role_arn" {
    type = string
    description = "The arn for the role to use"
    default = "arn:aws:iam::367379483300:role/204548-codepipelinenetcoretest"
}

variable "cp_resources_name" {
    type = string
    description = "The suffix to name all resources"
    default = "otp-ng-codepipeline"
}

variable "github_repo" {
    type = string
    description = "The GitHub repository to listen release"
    default = "tr/tax-provision_otp-ui"
}

variable "release_suffix" {
    type = string
    description = "Suffix on the repo release to trigger the events"
    default = ""
}

variable "stage" {
    type = string
    description = "Environment"
    default = "sandbox"
}

variable "image_repo" {
    type = string
    description = "Ecr repository url"
    default = "a204044-otp-ui-sandbox"
}
