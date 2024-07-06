# providers.tf
provider "aws" {
  alias  = "region1"
  region = var.aws_region_1
}

provider "aws" {
  alias  = "region2"
  region = var.aws_region_2
}
