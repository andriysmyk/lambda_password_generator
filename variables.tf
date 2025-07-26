variable "aws_access_key" {
  type    = string
  default = "<CHANGE_ME>"
}

variable "aws_secret_key" {
  type    = string
  default = "<CHANGE_ME>"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "lambda_runtime" {
  type    = string
  default = "python3.13"
}
