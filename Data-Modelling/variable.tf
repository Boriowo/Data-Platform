variable "region" {
  type = string
  description = "Enter your preferred region"
}

variable "bucket" {
  type = string
  description = "Enter the bucket name"
}

variable "catalogname" {
  type = string
  description = "Enter the catalog name"
}

variable "description" {
  type = string
  description = "Enter your catalog description"
}

variable "identity" {
  type = string
  description = "Enter your preferred catalog id"
}

variable "database_name" {
  type = string
  description = "Enter your database name"
}

variable "query_name" {
  type = string
  description = "Enetr your query name"
}

variable "rolename" {
    type = string
    description = "Enter your role name"
}

variable "session_name" {
    type = string
    description = "Enter the session name"
}

variable "user_email" {
    type = string
    description = "Enter the user email address"
}

variable "namespace" {
    type = string
    description = "Enter a namespace"
}

variable "datasource" {
    type = string
    description = "Enter your datasource identity"
}

variable "datasource_name" {
    type = string
    description = "Enter your data source name"
}

#variable "workgroup" {}