resource "aws_vpc_ipam" "main" {
  description = var.description

  operating_regions {
    region_name = var.region
  }

  tags    = var.tags
  cascade = var.cascade
}

resource "aws_vpc_ipam_pool" "parent" {
  address_family = var.parent_pool.address_family
  ipam_scope_id  = aws_vpc_ipam.main.private_default_scope_id

  depends_on = [aws_vpc_ipam.main]
}

resource "aws_vpc_ipam_pool_cidr" "parent" {
  ipam_pool_id = aws_vpc_ipam_pool.parent.id
  cidr         = var.parent_pool.cidr_block

  depends_on = [aws_vpc_ipam_pool.parent]
}

resource "aws_vpc_ipam_pool" "child" {
  for_each = var.pools

  address_family      = each.value.address_family
  ipam_scope_id       = aws_vpc_ipam.main.private_default_scope_id
  locale              = var.region
  source_ipam_pool_id = aws_vpc_ipam_pool.parent.id
  auto_import         = each.value.auto_import
  description         = each.key

  depends_on = [aws_vpc_ipam.main, aws_vpc_ipam_pool.parent]
}

resource "aws_vpc_ipam_pool_cidr" "child" {
  for_each = var.pools

  ipam_pool_id = aws_vpc_ipam_pool.child[each.key].id
  cidr         = each.value.cidr_block

  depends_on = [aws_vpc_ipam_pool.child]
}

# Resource Sharing

resource "aws_ram_resource_share" "default" {
  name                      = "ipam"
  allow_external_principals = false
  tags                      = var.tags
}

resource "aws_ram_resource_association" "default" {
  for_each = {
    for key, pool in var.pools : key => pool if pool.resource_share != null
  }

  resource_arn       = aws_vpc_ipam_pool.child[each.key].arn
  resource_share_arn = aws_ram_resource_share.default.arn

  depends_on = [aws_ram_resource_share.default, aws_vpc_ipam_pool.child]
}

resource "aws_ram_principal_association" "default" {
  for_each = {
    for key, pool in var.pools : key => pool if pool.resource_share != null
  }

  principal          = each.value.resource_share
  resource_share_arn = aws_ram_resource_share.default.arn

  depends_on = [aws_ram_resource_share.default]
}
