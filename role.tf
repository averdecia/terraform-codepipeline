resource "aws_iam_role" "code_pipeline_role" {
  name = "${var.role_ref_id}-${var.cp_resources_name}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
    ]
  })
}

data "template_file" "cp_policy" {
  template = file("policies/code_pipeline.json")

  vars = {
    bucket_arn   = aws_s3_bucket.codepipeline_bucket.arn
  }
}

resource "aws_iam_policy" "cp_policy" {
  name = "${var.role_ref_id}-${var.cp_resources_name}"

  policy = data.template_file.cp_policy.rendered
}

resource "aws_iam_role_policy_attachment" "cp_role_policy" {
  role       = aws_iam_role.code_pipeline_role.name
  policy_arn = aws_iam_policy.cp_policy.arn
}
