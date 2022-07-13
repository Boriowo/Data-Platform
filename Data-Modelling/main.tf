provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "exam" {
  bucket = var.bucket
  #key = "output/"
}
# resource "aws_s3_bucket_acl" "example" {
#   bucket = aws_s3_bucket.exam.id
#   acl    = "private"
# }
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.exam.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["431617346510"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]

    resources = [
      aws_s3_bucket.exam.arn,
      "${aws_s3_bucket.exam.arn}/*",
    ]
  }
}
resource "aws_athena_data_catalog" "example" {
  name        = var.catalogname
  description = var.description
  type        = "GLUE"

  parameters = {
    "catalog-id" = var.identity
  }
}


data "aws_iam_policy_document" "example" {
   statement {
    principals {
      type        = "AWS"

      identifiers = ["431617346510"]
    }

    actions = ["kms:*"]
    resources = ["*"]
   }
}


resource "aws_athena_workgroup" "test" {
  name = "example"

  configuration {
    result_configuration {
      output_location = "s3://${aws_s3_bucket.exam.bucket}/output2"
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


resource "aws_iam_role" "unknown" {
  name = var.rolename

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    
    Statement = [
      {
        Effect = "Allow"
        Sid    = ""
        #Resource = "*"
        #Resource = "arn:aws:quicksight::431617346510:user/moses"
        Principal = {
          Service = "quicksight.amazonaws.com"
        },
        Action= "sts:AssumeRole"
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_quicksight_user" "example" {
  session_name  = var.session_name
  email         = var.user_email
  namespace     = var.namespace
  identity_type = "IAM"
  iam_arn       = aws_iam_role.unknown.arn
  user_role     = "AUTHOR"
}

resource "aws_kms_key" "test" {
  deletion_window_in_days = 7
  description             = "Athena KMS Key"
  policy = data.aws_iam_policy_document.example.json
}

resource "aws_quicksight_data_source" "default" {
  data_source_id = var.datasource
  name           = var.datasource_name

  parameters {
    athena {
              work_group = aws_athena_workgroup.test.name
    }
  }
  type = "ATHENA"
  }