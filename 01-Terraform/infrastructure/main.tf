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
  project     = "dtc-de-NYCTLC-Susha"
  region      = var.google_region
  credentials = var.gcp_creds
}