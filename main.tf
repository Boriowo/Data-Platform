provider "aws" {
  region = "us-east-1"
}

module "ETL-Job" {
    source = "./Data-Ingestion"
    name = "catalogdatabase"
    catalogtable = "mycatalogtable"
    crawlername = "example"
    role = "aws_iam_role.example.arn"
    schedule = ""
    table_prefix = ""
    description = ""
    s3_path = "s3://${aws_s3_bucket.exam.bucket}"
    classifier = "example"
    gluename = "example"
    gluejobscript = "s3://aws-glue-assets-431617346510-us-east-1/scripts/Untitled job.py"
    bname = "dami-bucket"
    csvcrawl = "custom-csv-crawler"
    iam = "AWSGlueServiceRole-foo"
}

#calling the data warehouse module
module "Warehouse" {
  source = "./Data-Warehouse"
  region = "us-east-1"
  clusterid = "tf-redshift-cluster"
  dbname = "mydb" 
  master_username= "exampleuser"
  master_password = "Mustbe8characters"
  rolename = "moses_role"
}

#calling the data query module
module "Query" {
  source = "./Data-Modelling"
  region = "us-east-1"
  bucket = "dami-bucket"
  catalogname = "glue-data-catalog"
  description = "Glue based Data Catalog"
  identity = "123456789012"
  database_name = "users"
  query_name = "users"
}