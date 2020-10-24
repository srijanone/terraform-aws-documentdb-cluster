provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
  region                  = "us-east-1"
}


module "document_db_cluster" {
  source          = "../"
  enabled         = true
  name            = "test-doc-db"
  master_username = "testuser"
  master_password = var.master_password
  vpc_id          = "vpc-xxxx"
  subnet_ids      = ["subnet-xxxx", "subnet-xxxx", "subnet-xxxx", ]

  storage_encrypted      = false
  vpc_security_group_ids = ["sg-xxx"]
  skip_final_snapshot    = true
  ## These will apply if you are not passing any
  ingress = [
    {
      cidr_blocks = ["20.10.0.0/16"]
      from_port   = "27017"
      to_port     = "27017"
      protocol    = "tcp"
      description = "Allow docdb to connect with in VPC"
    },
  ]
  tags = {
    Environment  = "terraform-test"
    "created by" = "DevOps"
  }
}