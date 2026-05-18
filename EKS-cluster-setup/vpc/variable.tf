variable "public_subnet" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet" {
  default = ["10.0.22.0/24", "10.0.24.0/24"]
}

variable "project" {
  default = "Roboshop"
}

variable "environment" {
  default = "env"
}