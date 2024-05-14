variable "cascade" {
  type        = bool
  default     = null
  description = " (Optional) Enables you to quickly delete an IPAM, private scopes, pools in private scopes, and any allocations in the pools in private scopes."
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider `default_tags` configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = {}
}

variable "description" {
  type        = string
  default     = "My IPAM"
  description = "(Optional) A description for the IPAM."
}

variable "region" {
  type        = string
  description = "AWS Region used for picking up the ARNs for the securityhub standards subscriptions."
}

variable "pools" {
  description = "The pools to create in the IPAM."
  type = map(object({
    address_family = string
    description    = optional(string)
    auto_import    = optional(bool)
    cidr_block     = string
    resource_share = optional(string)
  }))
}

variable "parent_pool" {
  description = "The parent pool to create in the IPAM."
  type = object({
    address_family = string
    cidr_block     = string
  })
}
