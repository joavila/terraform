variable "instance_availability_domain" {
	description = "The availability domain of the instance."
}

variable "subnet_id" {
	description = "The OCID of the subnet to create the VNIC in."
} 

variable "source_id" {
	description = "The OCID of an image or a boot volume to use, depending on the value of source_type."
}

variable "compartment_id" {
	description = "The OCID of the compartment."
}

variable "instance_shape" {
	description = "The shape of an instance."
}

variable "instance_agent_config_is_monitoring_disabled" {
	description = "Whether Oracle Cloud Agent can gather performance metrics and monitor the instance using the monitoring plugins."
	default = false
}

variable "instance_agent_config_is_management_disabled" {
	description = "Whether Oracle Cloud Agent can run all the available management plugins."
	default = false
}

variable "instance_agent_config_are_all_plugins_disabled" {
	description = "Whether Oracle Cloud Agent can run all of the available plugins."
	default = false
}

variable "instance_availability_config_recovery_action" {
	description = "The lifecycle state for an instance when it is recovered after infrastructure maintenance."
	default = "RESTORE_INSTANCE"
}

variable "instance_create_vnic_details_display_name" {
	description = "A user-friendly name."
	default = null
}

variable "instance_display_name" {
	description = "A user-friendly name."
	default = null
}

variable "instance_create_vnic_details_hostname_label" {
	description = "The hostname for the VNIC's primary private IP."
	default = null
}

variable "instance_instance_options_are_legacy_imds_endpoints_disabled" {
	description = "Whether to disable the legacy (/v1) instance metadata service endpoints."
	default = true
}

variable "instance_is_pv_encryption_in_transit_enabled" {
	description = "Whether to enable in-transit encryption for the data volume's paravirtualized attachment."
	default = true
}

variable "instance_launch_options_boot_volume_type" {
	description = "Emulation type for the boot volume."
	default = "PARAVIRTUALIZED"
}

variable "instance_launch_options_network_type" {
	description = "Emulation type for the physical network interface card (NIC)."
	default = "PARAVIRTUALIZED"
}

variable "instance_launch_options_remote_data_volume_type" {
	description = "Emulation type for volume."
	default = "PARAVIRTUALIZED"
}

variable "instance_metadata" {
	description = "Custom metadata key/value pairs that you provide."
}

variable "instance_shape_config_memory_in_gbs" {
	description = "The total amount of memory available to the instance, in gigabytes."
	default = 1
}

variable "instance_shape_config_ocpus" {
	description = "The total number of OCPUs available to the instance."
	default = 1
}

variable "instance_create_vnic_details_assign_public_ip" {
	description = "Whether the VNIC should be assigned a public IP address."
}
