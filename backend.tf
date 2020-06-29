terraform {
  backend "s3" {
    bucket = "lamiyabucket"
    key    = "path/terraform.tfstate"
    region = "ap-south-1"
    access_key = "AKIAYB4OG5S74ZBOWLOW"
    secret_key = "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"
  }
}