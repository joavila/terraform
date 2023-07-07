variable "instance_availability_domain" {
	description = "The availability domain of the instance."
}

variable "source_id" {
	description = "The OCID of an image or a boot volume to use, depending on the value of source_type."
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
}

variable "instance_metadata" {
	description = "Custom metadata key/value pairs that you provide."
}

variable "instance_create_vnic_details_assign_public_ip" {
	description = "Whether the VNIC should be assigned a public IP address."
}
