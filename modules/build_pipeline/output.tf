output "bucket_url" {
  description = "ARN of the bucket"
  value       = aws_s3_bucket.codepipeline_bucket.bucket
}

output "pipeline_name" {
  description = "The pipeline that will be executed"
  value       = aws_codepipeline.codepipeline.name
}

output "codebuild_name" {
  description = "The code build that will be executed"
  value       = aws_codebuild_project.build.name
}
