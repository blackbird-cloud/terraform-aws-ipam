module "ipam" {
  source  = "blackbird-cloud/ipam/aws"
  version = "~> 1"

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
      resource_share = "12345678910"
    }
    staging = {
      address_family = "ipv4"
      cidr_block     = "10.1.0.0/16"
      description    = "Staging workload pool"
      resource_share = "12345678910"
    }
    production = {
      address_family = "ipv4"
      cidr_block     = "10.2.0.0/16"
      description    = "Production workload pool"
      resource_share = "12345678910"
    }
  }
}
