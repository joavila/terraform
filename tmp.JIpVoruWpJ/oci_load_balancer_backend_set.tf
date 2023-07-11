variable "backend_set_health_checker_protocol" {
	description = "The protocol the health check must use; either HTTP or TCP."
}

variable "backend_set_health_checker_is_force_plain_text" {
	description = "Specifies if health checks should always be done using plain text instead of depending on whether or not the associated backend set is using SSL."
}

variable "backend_set_health_checker_port" {
	description = "The backend server port against which to run the health check."
        default     = 4443
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
	default = null
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
