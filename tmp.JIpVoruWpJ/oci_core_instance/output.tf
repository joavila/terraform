#Module      : oci_core_instance
#Description : This resource provides the Instance resource in Oracle Cloud Infrastructure Core service.

output "private_ip" {
  value       = oci_core_instance.test_instance.private_ip
  description = "This is the VNIC's primary private IP address"
}
