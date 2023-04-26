terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

provider "google" {
  #credentials = "${file("CREDENTIALS_FILE.json")}"
  project     = "dtc-de-nyctlc-susha"
  region      = var.google_region
}