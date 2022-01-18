resource "aws_codepipeline" "codepipeline" {
  name     = "${var.role_ref_id}-${var.cp_resources_name}-${var.stage}"
  role_arn = "${var.role_arn}"

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "Custom"
      provider         = "GitHubReleases"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        Repo = "${var.github_repo}"
        # Suffix = "${var.release_suffix}"
      }
    }
  }


  stage {
    name = "Save_to_S3"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "S3"
      input_artifacts  = ["SourceArtifact"]
      version          = "1"

      configuration = {
        BucketName = "${var.role_ref_id}-${var.cp_resources_name}-${var.stage}"
        Extract = false
        ObjectKey = "artifact.zip"
      }
    }
  }


  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "${var.role_ref_id}-${var.cp_resources_name}-${var.stage}"
      }
    }
  }

}
