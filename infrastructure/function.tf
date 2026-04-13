terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.60.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11.0"
    }
  }
}

provider "huaweicloud" {
  region     = "tr-west-1"
  access_key = "MOCK_AK"
  secret_key = "MOCK_SK"
}

# Terraform'un K8s kümemizle (CCE) konuşabilmesi için kimlik ayarları
provider "kubernetes" {
  host                   = "https://MOCK_CCE_IP:5443"
  client_certificate     = "MOCK_CERT"
  client_key             = "MOCK_KEY"
  cluster_ca_certificate = "MOCK_CA"
}

provider "helm" {
  kubernetes {
    host                   = "https://MOCK_CCE_IP:5443"
    client_certificate     = "MOCK_CERT"
    client_key             = "MOCK_KEY"
    cluster_ca_certificate = "MOCK_CA"
  }
}