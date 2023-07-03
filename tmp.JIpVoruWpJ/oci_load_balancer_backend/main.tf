terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
    }
  }
}

locals {
  name = var.backendset_name  == null ? format("%s:%s", var.backend_ip_address, var.backend_port): var.backendset_name 
}

resource "oci_load_balancer_backend" "test_backend" {
    #Required
    backendset_name = local.name
    ip_address = var.backend_ip_address
    load_balancer_id = var.load_balancer_id 
    port = var.backend_port

    #Optional
    backup = var.backend_backup
    drain = var.backend_drain
    offline = var.backend_offline
    weight = var.backend_weight
}
