variable "name" {
    type = string
    description = "Enter your catalog database name"
}

variable "catalogtable" {
    type = string
    description = "Enter the name of your catalog table"
}

variable "crawlername" {
    type = string
    description = "Enter the name of your crawler"
}

variable "role" {}

variable "description" {
  default = ""
}

variable "schedule" {
  default = ""
}

variable "table_prefix" {}

variable "s3_path" {
    type = string
    description = "Enter the path for bucket"
}

variable "classifier" {
  type = string
  description = "Enter your classifier name"
}

variable "gluename" {
  type = string
  description = "Enter your glue job name"
}

variable "gluejobscript" {
  type = string
  description = "Enter the script for your glue job"
}

variable "bname" {
  type = string
  description = "Enter your bucket name"
}

variable "csvcrawl" {
  type = string
  description = "Enter your csv crawler details"
}

variable "iam" {
  type = string
  description = "Enter your iam name"
}