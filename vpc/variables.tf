variable "environment" {
  type        = string
  description = "Environment where the resources are deployed."
  nullable    = false
  default     = ""
}

variable "region" {
  type        = string
  description = "Region where the resources are deployed."
}

variable "name" {
  type        = string
  description = "Name of the VPC"

  # validation {
  #   condition     = length(var.name) > 0
  #   error_message = "Name must be set"
  # }
}

variable "cidr_block" {
  type        = string
  description = "The IPv4 CIDR block for the VPC. CIDR"
  default     = "10.0.0.0/16"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]

  validation {
    condition     = length(var.azs) > 0
    error_message = "At least one AZ must be set"
  }
}

variable "public_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource"
}
