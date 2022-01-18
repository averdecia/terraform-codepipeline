terraform {
  required_providers {
      aws = {
          source = "hashicorp/aws"
          version = "~> 3.0"
      }
  }
}

provider "aws" {
    region = var.aws_info.region
}

provider "template" {

}

module "build_pipeline_sandbox" {
  source = "./modules/build_pipeline"

  role_ref_id = var.role_ref_id
  role_arn = var.role_arn
  cp_resources_name = var.cp_resources_name
  github_repo = var.github_repo
  release_suffix = var.release_suffix
  image_repo = var.image_repo
  account_id = data.aws_caller_identity.current.account_id

  stage = "sandbox"
}

module "build_pipeline_dev" {
  source = "./modules/build_pipeline"

  role_ref_id = var.role_ref_id
  role_arn = var.role_arn
  cp_resources_name = var.cp_resources_name
  github_repo = var.github_repo
  release_suffix = var.release_suffix
  image_repo = var.image_repo
  account_id = data.aws_caller_identity.current.account_id

  stage = "dev"
}

