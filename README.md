# AWS IPAM Terraform module
A Terraform module which configures your AWS IPAM.  
[![blackbird-logo](https://raw.githubusercontent.com/blackbird-cloud/terraform-module-template/main/.config/logo_simple.png)](https://www.blackbird.cloud)

## Example
```hcl
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
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5 |

## Resources

| Name | Type |
|------|------|
| [aws_ram_principal_association.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_vpc_ipam.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam) | resource |
| [aws_vpc_ipam_pool.child](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool.parent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool) | resource |
| [aws_vpc_ipam_pool_cidr.child](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |
| [aws_vpc_ipam_pool_cidr.parent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipam_pool_cidr) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cascade"></a> [cascade](#input\_cascade) | (Optional) Enables you to quickly delete an IPAM, private scopes, pools in private scopes, and any allocations in the pools in private scopes. | `bool` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) A description for the IPAM. | `string` | `"My IPAM"` | no |
| <a name="input_parent_pool"></a> [parent\_pool](#input\_parent\_pool) | The parent pool to create in the IPAM. | <pre>object({<br>    address_family = string<br>    cidr_block     = string<br>  })</pre> | n/a | yes |
| <a name="input_pools"></a> [pools](#input\_pools) | The pools to create in the IPAM. | <pre>map(object({<br>    address_family = string<br>    description    = optional(string)<br>    auto_import    = optional(bool)<br>    cidr_block     = string<br>    resource_share = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region used for picking up the ARNs for the securityhub standards subscriptions. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to assign to the resource. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_parent_pool"></a> [parent\_pool](#output\_parent\_pool) | The parent pool created by the module. |
| <a name="output_pools"></a> [pools](#output\_pools) | The pools created by the module. |

## About

We are [Blackbird Cloud](https://blackbird.cloud), Amsterdam based cloud consultancy, and cloud management service provider. We help companies build secure, cost efficient, and scale-able solutions.

Checkout our other :point\_right: [terraform modules](https://registry.terraform.io/namespaces/blackbird-cloud)

## Copyright

Copyright © 2017-2023 [Blackbird Cloud](https://www.blackbird.cloud)
