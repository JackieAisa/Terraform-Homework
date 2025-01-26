provider aws {
    region = var.region
  
}

variable region {
    default = ""
}

 terraform {
  backend "s3" {
    bucket = "kaizen-jackie"
    key    = "terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "lock-state"
  }
}
