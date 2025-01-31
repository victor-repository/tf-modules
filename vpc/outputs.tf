output "arn" {
  value       = ""
  sensitive   = true
  description = "Amazon Resource Name (ARN) of VPC"
  depends_on  = []
}

output "id" {
  value       = ""
  sensitive   = true
  description = "The ID of the VPC"
  depends_on  = []
}

output "tag_all" {
  value       = ""
  sensitive   = true
  description = "A map of tags assigned to the resource"
  depends_on  = []
}
