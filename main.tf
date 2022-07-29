terraform {
    backend "s3" {
        encrypt = true
        bucket = "network-logfiles"
        key = "Data-Platform/terraform.tfstate"
        region = "us-east-1"
    }
}

provider "aws" {
  region = "us-east-1"
}


module "ETL-Job" {
  source       = "./Data-Ingestion"
  #region       = "us-east-1"
  name         = "catalogdatabase1"
  catalogtable = "mycatalogtable1"
  crawlername  = "example1"
  #role = "aws_iam_role.example.arn"
  schedule     = ""
  table_prefix = ""
  description  = ""
  #s3_path = "s3://${aws_s3_bucket.exam.bucket}"
  classifier    = "example1"
  gluename      = "example1"
  gluejobscript = "s3://aws-glue-assets-431617346510-us-east-1/scripts/Untitled job.py"
  bname         = "dami-bucket1"
  csvcrawl      = "custom-csv-crawler1"
  iam           = "AWSGlueServiceRole-foo1"
  endpoint_name = "ise_oluwa12
  schema_name   = "example1"
  schema_type   = "{\"type\": \"record\", \"name\": \"r1\", \"fields\": [ {\"name\": \"f1\", \"type\": \"int\"}, {\"name\": \"f2\", \"type\": \"string\"} ]}"
}

#calling the data warehouse module
module "Warehouse" {
  source          = "./Data-Warehousing"
  region          = "us-east-1"
  clusterid       = "oluwa-redshift-cluster1"
  dbname          = "mydb1"
  master_username = "exampleuser1"
  master_password = "Mustbe8characters1"
  rolename        = "moses_role1"
}

#calling the data query module
module "Query" {
  source          = "./Data-Modelling"
  region          = "us-east-1"
  rolename        = "our_role1"
  bucket          = "dami-bucket1"
  catalogname     = "glue-data-catalog1"
  description     = "Glue based Data Catalog1"
  identity        = "123456789012"
  database_name   = "users1"
  query_name      = "users1"
  session_name    = "an-author1"
  user_email      = "boriowo@ismiletechnologies.com"
  namespace       = "default1"
  datasource      = "example-id"
  datasource_name = "My Cool Data in S3"

}