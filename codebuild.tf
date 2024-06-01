resource "aws_codebuild_project" "default" {
  name         = "default"
  service_role = module.codebuild_role.iam_role_arn
  source {
    type = "CODEPIPELINE"
  }
  artifacts {
    type = "CODEPIPELINE"
  }
  environment {
    type            = "LINUXCONTAINER"
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/standard:2.0"
    privileged_mode = true
  }
}
