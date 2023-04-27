terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

provider "google" {
  project = "nyc-fhvhv"
  region  = var.google_region
}

provider "tls" {
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "local_file" "ssh-private_key_pem" {
  content = tls_private_key.ssh.private_key_pem
  filename = ".ssh/google_compute_engine"
  file_permission = "0600"
}