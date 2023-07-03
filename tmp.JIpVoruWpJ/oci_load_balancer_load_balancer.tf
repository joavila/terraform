variable "compartment_id" {
	description = "The OCID of the compartment in which to create the load balancer."
}

variable "load_balancer_display_name" {
	description = "A user-friendly name. It does not have to be unique, and it is changeable."
}

variable "load_balancer_shape" {
	description = "A template that determines the total pre-provisioned bandwidth (ingress plus egress)."
	default = "flexible"
}

variable "load_balancer_subnet_ids" {
	description = "An array of subnet OCIDs."
}

variable "load_balancer_is_private" {
	description = "Whether the load balancer has a VCN-local (private) IP address."
}

variable "load_balancer_shape_details_maximum_bandwidth_in_mbps" {
	description = "Bandwidth in Mbps that determines the maximum bandwidth (ingress plus egress) that the load balancer can achieve."
}

variable "load_balancer_shape_details_minimum_bandwidth_in_mbps" {
	description = "Bandwidth in Mbps that determines the total pre-provisioned bandwidth (ingress plus egress)."
}
