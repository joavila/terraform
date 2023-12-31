variable "listener_name" {
	description = "A friendly name for the listener."
	default = null
}

variable "listener_port" {
	description = "The communication port for the listener."
}

variable "listener_protocol" {
	description = "The protocol on which the listener accepts connection requests."
}

variable "listener_connection_configuration_idle_timeout_in_seconds" {
	description = "The maximum idle time, in seconds, allowed between two successive receive or two successive send operations between the client and backend servers."
}

variable "listener_connection_configuration_backend_tcp_proxy_protocol_version" {
	description = "The backend TCP Proxy Protocol version."
	default = 0
}

variable "listener_ssl_configuration_cipher_suite_name" {
	description = "The name of the cipher suite to use for HTTPS or SSL connections."
}

variable "listener_ssl_configuration_protocols" {
	description = "A list of SSL protocols the load balancer must support for HTTPS or SSL connections."
}

variable "listener_ssl_configuration_server_order_preference" {
	description = "When this attribute is set to ENABLED, the system gives preference to the server ciphers over the client ciphers."
}

variable "listener_ssl_configuration_verify_depth" {
	description = "The maximum depth for peer certificate chain verification."
        default = 3
}

variable "listener_ssl_configuration_verify_peer_certificate" {
	description = "Whether the load balancer listener should verify peer certificates."
	default = false
}
