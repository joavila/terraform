terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
    }
  }
}

resource "oci_load_balancer_backend" "test_backend" {
    #Required
    backendset_name = var.backendset_name 
    ip_address = var.backend_ip_address
    load_balancer_id = var.load_balancer_id 
    port = var.backend_port

    #Optional
    backup = var.backend_backup
    drain = var.backend_drain
    offline = var.backend_offline
    weight = var.backend_weight
}
