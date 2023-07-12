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
