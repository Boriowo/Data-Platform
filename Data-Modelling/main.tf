provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "exam" {
  bucket = var.bucket
}
resource "aws_athena_data_catalog" "example" {
  name        = var.catalogname
  description = var.description
  type        = "GLUE"

  parameters = {
    "catalog-id" = var.identity
  }
}

resource "aws_kms_key" "test" {
  deletion_window_in_days = 7
  description             = "Athena KMS Key"
}

resource "aws_athena_workgroup" "test" {
  name = "example"

  configuration {
    result_configuration {
      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = aws_kms_key.test.arn
      }
    }
  }
}

resource "aws_athena_database" "hoge" {
  name   = var.database_name
  bucket = aws_s3_bucket.exam.id
}

resource "aws_athena_named_query" "foo" {
  name      = var.query_name
  workgroup = aws_athena_workgroup.test.id
  database  = aws_athena_database.hoge.name
  query     = "SELECT * FROM ${aws_athena_database.hoge.name} limit 10;"
}

