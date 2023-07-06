terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
    }
  }
}

locals {
    current_timestamp  = timestamp()
    current_date       = formatdate("YYYYMMDD", local.current_timestamp)
    current_time       = formatdate("hhmm", local.current_timestamp)
}

resource "oci_core_subnet" "test_subnet" {
    #Required
    cidr_block = var.subnet_cidr_block
    compartment_id = var.compartment_id
    vcn_id = var.vcn_id

    #Optional
    display_name = var.subnet_display_name == null ? join("-", ["subnet", local.current_date, local.current_time]) : var.subnet_display_name 
    dns_label = var.subnet_dns_label == null ? format("subnet%s", local.current_date) : var.subnet_dns_label 
    prohibit_internet_ingress = var.subnet_prohibit_internet_ingress
    prohibit_public_ip_on_vnic = var.subnet_prohibit_public_ip_on_vnic
    security_list_ids = var.subnet_security_list_ids
}
