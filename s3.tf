resource "aws_s3_bucket" "codepipeline_bucket" {
  bucket = "${var.role_ref_id}-${var.cp_resources_name}"
  acl    = "private"
}
