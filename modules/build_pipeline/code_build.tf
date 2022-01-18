resource "aws_codebuild_project" "build" {
  name          = "${var.role_ref_id}-${var.cp_resources_name}-${var.stage}"
  description   = "The build pipeline to convert from zip to docker"
  build_timeout = "5"
  service_role  = "${var.role_arn}"

  artifacts {
    type = "NO_ARTIFACTS"
  }

  cache {
    type     = "S3"
    location = aws_s3_bucket.codepipeline_bucket.bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:1.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = true

    environment_variable {
      name  = "ARTIFACT_PATH"
      value = "${aws_s3_bucket.codepipeline_bucket.bucket}/artifact.zip"
    }
    environment_variable {
      name  = "STAGE"
      value = var.stage
    }
    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.aws_info.region
    }
    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.account_id
    }
    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.image_repo
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "${var.role_ref_id}-${var.cp_resources_name}-${var.stage}-log"
      stream_name = "${var.role_ref_id}-${var.cp_resources_name}-${var.stage}-log-stream"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/${var.github_repo}.git"
    git_clone_depth = 1
  }

  source_version = "master"

  tags = {
    Environment = var.stage
  }
}
