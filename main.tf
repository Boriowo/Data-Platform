provider "aws" {
  region = "us-east-1"
}

module "ETL-Job" {
  source       = "./Data-Ingestion"
  region       = "us-east-1"
  name         = "catalogdatabase"
  catalogtable = "mycatalogtable"
  crawlername  = "example"
  #role = "aws_iam_role.example.arn"
  schedule     = ""
  table_prefix = ""
  description  = ""
  #s3_path = "s3://${aws_s3_bucket.exam.bucket}"
  classifier    = "example"
  gluename      = "example"
  gluejobscript = "s3://aws-glue-assets-431617346510-us-east-1/scripts/Untitled job.py"
  bname         = "dami-bucket"
  csvcrawl      = "custom-csv-crawler"
  iam           = "AWSGlueServiceRole-foo"
  endpoint_name = "ise_oluwa1"
  glueregistry  = "example"
  schema_name   = "example"
  schema_type   = "{\"type\": \"record\", \"name\": \"r1\", \"fields\": [ {\"name\": \"f1\", \"type\": \"int\"}, {\"name\": \"f2\", \"type\": \"string\"} ]}"
}

#calling the data warehouse module
module "Warehouse" {
  source          = "./Data-Warehousing"
  region          = "us-east-1"
  clusterid       = "oluwa-redshift-cluster"
  dbname          = "mydb"
  master_username = "exampleuser"
  master_password = "Mustbe8characters"
  rolename        = "moses_role"
}

#calling the data query module
module "Query" {
  source          = "./Data-Modelling"
  region          = "us-east-1"
  rolename        = "our_role"
  bucket          = "dami-bucket"
  catalogname     = "glue-data-catalog"
  description     = "Glue based Data Catalog"
  identity        = "123456789012"
  database_name   = "users"
  query_name      = "users"
  session_name    = "an-author"
  user_email      = "boriowo@ismiletechnologies.com"
  namespace       = "default"
  datasource      = "example-id"
  datasource_name = "My Cool Data in S3"

}