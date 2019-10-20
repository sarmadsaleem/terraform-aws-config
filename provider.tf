provider "aws" {
  version = "~> 2.0"
  region  = "${var.primary_region}"
}

provider "aws" {
  alias  = "selected"
  region = "${var.region}"
}
