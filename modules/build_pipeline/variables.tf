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
}

variable "role_arn" {
    type = string
    description = "The arn for the role to use"
}

variable "cp_resources_name" {
    type = string
    description = "The suffix to name all resources"
}

variable "github_repo" {
    type = string
    description = "The GitHub repository to listen release"
}

variable "release_suffix" {
    type = string
    description = "Suffix on the repo release to trigger the events"
}

variable "stage" {
    type = string
    description = "Environment"
}

variable "image_repo" {
    type = string
    description = "Ecr repository url"
}

variable "account_id" {
    type = string
    description = "The user account id"
}
