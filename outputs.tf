output "parent_pool" {
  description = "The parent pool created by the module."
  value = {
    address_family = aws_vpc_ipam_pool.parent.address_family
    cidr           = aws_vpc_ipam_pool_cidr.parent.cidr
  }
}

output "pools" {
  description = "The pools created by the module."
  value       = var.pools
}
