locals {
  networking_account_id = "123456789012"
  staging_account_id    = "123456789013"
  production_account_id = "123456789014"
}

module "ipam" {
  # source  = "github.com/blackbird-cloud/terraform-aws-ipam"
  source = "../"

  region = "eu-central-1"

  parent_pool = {
    address_family = "ipv4"
    cidr_block     = "10.0.0.0/8"
  }

  pools = {
    shared = {
      address_family = "ipv4"
      cidr_block     = "10.0.0.0/16"
      description    = "shared pool"
      resource_share = local.networking_account_id
    }
    staging = {
      address_family = "ipv4"
      cidr_block     = "10.1.0.0/16"
      description    = "Staging workload pool"
      resource_share = local.staging_account_id
    }
    production = {
      address_family = "ipv4"
      cidr_block     = "10.2.0.0/16"
      description    = "Production workload pool"
      resource_share = local.production_account_id
    }
  }
}
