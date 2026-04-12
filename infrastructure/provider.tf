terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.60.0"
    }
    archive = {
      source  = "hashicorp/archive" # Python kodumuzu zip'lemek için
      version = "~> 2.4.0"
    }
  }
}

provider "huaweicloud" {
  region     = "tr-west-1"
  access_key = "MOCK_AK"
  secret_key = "MOCK_SK"
}