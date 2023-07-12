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
    name               = join("-", ["instance", local.current_date, local.current_time])
}

resource "oci_core_instance" "test_instance" {
    #Required
    availability_domain = var.instance_availability_domain
    compartment_id = var.compartment_id
    shape = var.instance_shape

    #Optional
    agent_config {

	#Optional
	are_all_plugins_disabled = var.instance_agent_config_are_all_plugins_disabled
	is_management_disabled = var.instance_agent_config_is_management_disabled
	is_monitoring_disabled = var.instance_agent_config_is_monitoring_disabled
    }
    availability_config {

	#Optional
	recovery_action = var.instance_availability_config_recovery_action
    }
    create_vnic_details {

	#Optional
        assign_public_ip = var.instance_create_vnic_details_assign_public_ip
	display_name = var.instance_create_vnic_details_display_name == null ? local.name : var.instance_create_vnic_details_display_name 
	hostname_label = var.instance_create_vnic_details_hostname_label == null ? local.name : var.instance_create_vnic_details_hostname_label 
	subnet_id = var.subnet_id 
    }
    display_name = var.instance_display_name == null ? join("-", ["instance", local.current_date, local.current_time]) : var.instance_display_name
    instance_options {

        #Optional
        are_legacy_imds_endpoints_disabled = var.instance_instance_options_are_legacy_imds_endpoints_disabled
    }
    is_pv_encryption_in_transit_enabled = var.instance_is_pv_encryption_in_transit_enabled
    launch_options {

        #Optional
        boot_volume_type = var.instance_launch_options_boot_volume_type
        network_type = var.instance_launch_options_network_type
        remote_data_volume_type = var.instance_launch_options_remote_data_volume_type
    }
    metadata = var.instance_metadata
    shape_config {

        #Optional
        memory_in_gbs = var.instance_shape_config_memory_in_gbs
        ocpus = var.instance_shape_config_ocpus
    }
    source_details {
        #Required
        source_id = var.source_id 
        source_type = "image"

        #Optional
        #boot_volume_size_in_gbs = var.instance_source_details_boot_volume_size_in_gbs
        #boot_volume_vpus_per_gb = var.instance_source_details_boot_volume_vpus_per_gb
    }
    preserve_boot_volume = false
}
