provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "example" {
  name               = var.iam
  assume_role_policy = data.aws_iam_policy_document.example.json
}

data "aws_iam_policy_document" "example" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "example-AWSGlueServiceRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  role       = aws_iam_role.example.name
}

resource "aws_s3_bucket" "exam" {
  bucket = var.bname

  tags = {
    Name        = var.name
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "exam" {
  bucket = aws_s3_bucket.exam.id
  acl    = "private"
}

resource "aws_glue_catalog_database" "glue_catalog_database1" {
  name = var.name
}

resource "aws_glue_catalog_table" "source" {
  name          = var.catalogtable
  database_name = aws_glue_catalog_database.glue_catalog_database1.name
}

resource "aws_glue_crawler" "example" {
  database_name = aws_glue_catalog_database.glue_catalog_database1.name
  name          = var.crawlername
  role          = aws_iam_role.example.arn
  classifiers = [aws_glue_classifier.example.id]

  schedule     = "${var.schedule}"
  table_prefix = "${var.table_prefix}"
  description  = "${var.description}"

  s3_target {
    path = "s3://${aws_s3_bucket.exam.bucket}"
  }
}


resource "aws_glue_job" "example" {
  name     = var.gluename
  role_arn = aws_iam_role.example.arn

  command {
    script_location = var.gluejobscript
  }
}

resource "aws_glue_classifier" "example" {
  name = var.classifier

  csv_classifier {
    allow_single_column    = false
    contains_header        = "PRESENT"
    delimiter              = ","
    disable_value_trimming = false
    header                 = ["example1", "example2"]
    quote_symbol           = "'"
  }
}

resource "aws_glue_dev_endpoint" "example" {
  name     = var.endpoint_name
  role_arn = aws_iam_role.example.arn
}


resource "aws_glue_registry" "test" {
  registry_name = var.glueregistry
}

resource "aws_glue_schema" "example" {
  schema_name       = var.schema_name
  registry_arn      = aws_glue_registry.test.arn
  data_format       = var.data_format
  compatibility     = var.compatibility
  schema_definition = var.schema_type
}



