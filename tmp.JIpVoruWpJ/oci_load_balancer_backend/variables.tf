variable "backendset_name" {
	description = "The name of the backend set to add the backend server to."
	default = null
}

variable "backend_ip_address" {
	description = "The IP address of the backend server."
}

variable "load_balancer_id" {
	description = "The OCID of the load balancer associated with the backend set and servers."
}

variable "backend_port" {
	description = "The communication port for the backend server."
	default = 8888
}

variable "backend_backup" {
	description = "Whether the load balancer should treat this server as a backup unit."
	default = false
}

variable "backend_drain" {
	description = "Whether the load balancer should drain this server."
	default = false
}

variable "backend_offline" {
	description = "Whether the load balancer should treat this server as offline. "
	default = false
}

variable "backend_weight" {
	description = "The load balancing policy weight assigned to the server."
	default = 1
}
