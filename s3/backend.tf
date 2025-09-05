terraform {
  backend "s3" {
    bucket = "dummy05092025"
    region = "us-east-1"
    key = "raam/terraformstate"
    dynamodb_table = "TfLock"
  }
}