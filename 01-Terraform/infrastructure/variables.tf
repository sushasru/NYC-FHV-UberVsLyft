variable "aws_region" {
  default = "us-east-1"
}

variable "google_region" {
  default = "us-east4"
}

variable "google_zone" {
  default = "us-east4-c"
}

variable "gcp-creds" {
  default = ""
}

variable "instance_name" {
  description = "Instance Name"
  type        = string
  default     = "nyc-fhvhv-vm"
}