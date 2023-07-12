variable "subnet_cidr_block" {
	description = "The CIDR IP address range of the subnet."
}

variable "compartment_id" {
	description = "The OCID of the compartment to contain the subnet."
}

variable "vcn_id" {
	description = "The OCID of the VCN to contain the subnet."
}

variable "subnet_display_name" {
	description = "A user-friendly name."
	default = null
}

variable "subnet_prohibit_internet_ingress" {
	description = "Whether to disallow ingress internet traffic to VNICs within this subnet."
	default = true
}

variable "subnet_prohibit_public_ip_on_vnic" {
	description = "Whether VNICs within this subnet can have public IP addresses."
	default = true
}

variable "subnet_security_list_ids" {
	description = "The OCIDs of the security list or lists the subnet will use."
	default = []
}

variable "subnet_dns_label" {
	description = "A DNS label for the subnet."
	default = null
}
