variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

variable "tenancy" {
  default = "dedicated"
}

variable "ami_id" {
  default = "ami-068d43a544160b7ef"
}


variable "Instance_type" {
  default = "t2.micro"
}

variable "region" {
  default = "ap-south-1"
}

variable "web_amis" {
  type = map(string)
  default = {
    ap-south-1     = "ami-068d43a544160b7ef"
    ap-southeast-1 = "ami-068d43a544160b7ef"
  }
}

variable "web_ins_count" {
  default = "2"
}

variable "web_tags" {
  type = map(string)
  default = {
    Name = "Webserver"
  }
}

variable "s3_bucket_name" {
  default = "my--test-cts-bucket"
}
