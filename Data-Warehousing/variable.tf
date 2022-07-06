variable "region"{
    type = string
    description = "Enter your preferred region"
}

variable "clusterid" {
    type = string
    description = "Enter your cluster identifier"
}

variable "dbname"{
    type = string
    description = "Enter your database name"
}

variable "master_username" {
    type = string
    description = "Enter your master username"
}

variable "master_password" {
    type = string
    description = "Enter your desired master password"
}

variable "rolename" {
    type = string
    description = "Enter your role name"
}