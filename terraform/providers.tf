terraform{
    backend "s3"{
        bucket = "demo-develop-bucket"
        key = "demo-develop/state.tfstate"
    }
}

provider "aws" {
    region = var.REGION-ID
}
