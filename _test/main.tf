module "vpc" {
  source = "../vpc"

  environment   = "Testing"
  region        = "us-west-1"
  name          = "vpc-test"
  cidr_block    = "10.0.0.0/16"
  azs           = ["us-west-1b", "us-west-1c"]
  public_cidrs  = ["10.0.10.0/24"]
  private_cidrs = ["10.0.20.0/24"]
  tags = {
    #Terraform   = "True"
    Environment = "Testing"
    Name        = "vpc-test"
  }

}
