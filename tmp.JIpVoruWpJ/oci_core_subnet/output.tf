#Module      : oci_core_subnet
#Description : This resource provides the Subnet resource in Oracle Cloud Infrastructure Core service.

output "id" {
  value       = oci_core_subnet.test_subnet.*.id
  description = "The subnet's Oracle ID"
}
