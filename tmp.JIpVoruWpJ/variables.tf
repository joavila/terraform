locals {
    current_timestamp  = timestamp()
    current_date       = formatdate("YYYYMMDD_hhmm", local.current_timestamp)
}

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

variable "certificate_certificate_name" {
	description = "A friendly name for the certificate bundle. It must be unique and it cannot be changed."
}

variable "certificate_ca_certificate" {
	description = "The Certificate Authority certificate, or any interim certificate, that you received from your SSL certificate provider."
}

variable "certificate_passphrase" {
	description = "A passphrase for encrypted private keys."
}

variable "certificate_private_key" {
	description = "The SSL private key for your certificate, in PEM format."
}

variable "certificate_public_certificate" {
	description = "The public certificate, in PEM format, that you received from your SSL certificate provider."
}

variable "backend_set_health_checker_protocol" {
	description = "The protocol the health check must use; either HTTP or TCP."
}

variable "backend_set_health_checker_is_force_plain_text" {
	description = "Specifies if health checks should always be done using plain text instead of depending on whether or not the associated backend set is using SSL."
}

variable "backend_set_health_checker_port" {
	description = "The backend server port against which to run the health check."
}

variable "backend_set_health_checker_retries" {
	description = "The number of retries to attempt before a backend server is considered 'unhealthy'"
}

variable "backend_set_health_checker_return_code" {
	description = "The status code a healthy backend server should return."
}

variable "backend_set_health_checker_timeout_in_millis" {
	description = "The maximum time, in milliseconds, to wait for a reply to a health check."
}

variable "backend_set_health_checker_url_path" {
	description = "The path against which to run the health check."
}

variable "backend_set_name" {
	description = "A friendly name for the backend set. It must be unique and it cannot be changed"
}

variable "backend_set_policy" {
	description = "The load balancer policy for the backend set."
}

variable "backend_set_ssl_configuration_cipher_suite_name" {
	description = "The name of the cipher suite to use for HTTPS or SSL connections."
}

variable "backend_set_ssl_configuration_protocols" {
	description = "A list of SSL protocols the load balancer must support for HTTPS or SSL connections."
}

variable "hostname_hostname" {
	description = "A virtual hostname."
}

variable "hostname_name" {
	description = "A friendly name for the hostname resource."
}
