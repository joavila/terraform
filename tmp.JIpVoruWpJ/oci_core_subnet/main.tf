terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
    }
  }
}

resource "random_pet" "subnet" {
  keepers = {
    # Generate a new pet name each time we switch to a new CIDR block
    cidr_block = var.subnet_cidr_block
  }
}

resource "oci_core_subnet" "test_subnet" {
    #Required
    cidr_block = random_pet.subnet.keepers.cidr_block
    compartment_id = var.compartment_id
    vcn_id = var.vcn_id

    #Optional
    display_name = var.subnet_display_name == null ? join("-", ["subnet", random_pet.subnet.id]) : var.subnet_display_name 
    dns_label = var.subnet_dns_label == null ? random_pet.subnet.id : var.subnet_dns_label 
    prohibit_internet_ingress = var.subnet_prohibit_internet_ingress
    prohibit_public_ip_on_vnic = var.subnet_prohibit_public_ip_on_vnic
    security_list_ids = var.subnet_security_list_ids
}
