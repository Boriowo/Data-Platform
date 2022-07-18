output "s3_bucket_id" {
   description = "The The Bucket for storing the raw data"
   value = aws_s3_bucket.exam
}

output "glue_catalog_database" {
   description = "The Glue Catalog database"
   value = aws_glue_catalog_database.glue_catalog_database1
}

output "glue_catalog_table_id" {
   description = "The Glue Catalog Table"
   value = aws_glue_catalog_table.source
}

output "glue_crawler_id" {
    description = "Your Glue crawler"
    value = aws_glue_crawler.example
}
