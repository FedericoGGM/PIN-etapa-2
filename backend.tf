terraform {
  backend "s3"{
    bucket                 = "mundose-terraform-state-2025"
    region                 = "us-east-1"
    key                    = "backend.tfstate"
    dynamodb_table         = "terraformstatelock"
  }
}

