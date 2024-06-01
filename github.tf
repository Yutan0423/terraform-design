resource "aws_codestarconnections_connection" "example" {
  name          = "my-connection"
  provider_type = "GitHub"
}

resource "github_repository_webhook" "default" {
  repository = "terraform-design"
  configuration {
    url          = aws_codepipeline_webhook.default.url
    secret       = "VeryRandomStringMoreThan20Byte!"
    content_type = "json"
    insecure_ssl = false
  }
  events = ["push"]
}
