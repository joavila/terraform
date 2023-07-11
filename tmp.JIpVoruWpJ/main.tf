provider "oci" {
}

terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
    }
  }
}

locals {
    current_timestamp  = timestamp()
    current_date       = formatdate("YYYY_MMDD_hhmm", local.current_timestamp)
    security_list = {
      private = [oci_core_security_list.private.id]
      public = [oci_core_security_list.public.id]
    }
}

resource "oci_load_balancer_load_balancer" "test_load_balancer" {
    #Required
    compartment_id = var.compartment_id
    display_name = var.load_balancer_display_name == null ? format("lb_%s", local.current_date) : var.load_balancer_display_name 
    shape = var.load_balancer_shape
    subnet_ids = module.subnet["public"].id

    #Optional
    is_private = var.load_balancer_is_private
    #network_security_group_ids = var.load_balancer_network_security_group_ids
    #reserved_ips {
    #    #Optional
    #    id = var.load_balancer_reserved_ips_id
    #}
    shape_details {
        #Required
        maximum_bandwidth_in_mbps = var.load_balancer_shape_details_maximum_bandwidth_in_mbps
        minimum_bandwidth_in_mbps = var.load_balancer_shape_details_minimum_bandwidth_in_mbps
    }
}

resource "oci_load_balancer_backend_set" "test_backend_set" {
    #Required
    health_checker {
        #Required
        protocol = var.backend_set_health_checker_protocol

        #Optional
        #interval_ms = var.backend_set_health_checker_interval_ms
        is_force_plain_text = var.backend_set_health_checker_is_force_plain_text
        port = var.backend_set_health_checker_port
        #response_body_regex = var.backend_set_health_checker_response_body_regex
        retries = var.backend_set_health_checker_retries
        return_code = var.backend_set_health_checker_return_code
        timeout_in_millis = var.backend_set_health_checker_timeout_in_millis
        url_path = var.backend_set_health_checker_url_path
    }
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
    name = var.backend_set_name == null ? format("bes_%s", local.current_date) : var.backend_set_name 
    policy = var.backend_set_policy

    ssl_configuration {

        #Optional
	certificate_name = oci_load_balancer_certificate.bes_certificate.certificate_name
    }
}

module "backend" {
  source = "./oci_load_balancer_backend"
  load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
  backend_ip_address = module.compute.private_ip
  backend_port = var.backend_port 
  backendset_name = oci_load_balancer_backend_set.test_backend_set.name
}

data "oci_secrets_secretbundle" "private_key" {
    #Required
    secret_id = var.certificate_private_key
}

data "oci_secrets_secretbundle" "passphrase" {
    #Required
    secret_id = var.certificate_passphrase
}

resource "oci_load_balancer_certificate" "load_balancer_certificate" {
    #Required
    certificate_name = "lbaas_certificate"
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id

    #Optional
    ca_certificate = var.certificate_ca_certificate
    passphrase = base64decode(data.oci_secrets_secretbundle.passphrase.secret_bundle_content[0].content)
    private_key = base64decode(data.oci_secrets_secretbundle.private_key.secret_bundle_content[0].content)
    public_certificate = var.certificate_public_certificate

    #lifecycle {
    #    create_before_destroy = true
    #}
}

resource "oci_load_balancer_certificate" "bes_certificate" {
    #Required
    certificate_name = "bes_certificate"
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id

    #Optional
    ca_certificate = var.certificate_ca_certificate
    passphrase = base64decode(data.oci_secrets_secretbundle.passphrase.secret_bundle_content[0].content)
    private_key = base64decode(data.oci_secrets_secretbundle.private_key.secret_bundle_content[0].content)
    public_certificate = var.certificate_public_certificate

    #lifecycle {
    #    create_before_destroy = true
    #}
}

resource "oci_load_balancer_listener" "test_listener" {
    #Required
    default_backend_set_name = oci_load_balancer_backend_set.test_backend_set.name
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
    name = var.listener_name == null ? format("listener_%s", local.current_date) : var.listener_name 
    port = var.listener_port
    protocol = var.listener_protocol
    #Optional
    connection_configuration {
        #Required
        idle_timeout_in_seconds = var.listener_connection_configuration_idle_timeout_in_seconds
    }
    hostname_names = [oci_load_balancer_hostname.test_hostname.name]
    routing_policy_name = oci_load_balancer_load_balancer_routing_policy.test_load_balancer_routing_policy.name
    ssl_configuration {
        #Optional
        certificate_name = oci_load_balancer_certificate.load_balancer_certificate.certificate_name
        #certificate_ids = var.listener_ssl_configuration_certificate_ids
        cipher_suite_name = var.listener_ssl_configuration_cipher_suite_name
        protocols = var.listener_ssl_configuration_protocols
        #server_order_preference = var.listener_ssl_configuration_server_order_preference
        #trusted_certificate_authority_ids = var.listener_ssl_configuration_trusted_certificate_authority_ids
        verify_depth = var.listener_ssl_configuration_verify_depth
        verify_peer_certificate = var.listener_ssl_configuration_verify_peer_certificate
    }
}

resource "oci_load_balancer_load_balancer_routing_policy" "test_load_balancer_routing_policy" {
    #Required
    condition_language_version = var.load_balancer_routing_policy_condition_language_version
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
    name = var.load_balancer_routing_policy_name == null ? format("rp_%s", local.current_date) : var.load_balancer_routing_policy_name 
    rules {
        #Required
        actions {
            #Required
            backend_set_name = oci_load_balancer_backend_set.test_backend_set.name
            name = var.load_balancer_routing_policy_rules_actions_name
        }
        condition = var.load_balancer_routing_policy_rules_condition
        name = var.load_balancer_routing_policy_rules_name == null ? format("rule_%s", local.current_date) : var.load_balancer_routing_policy_rules_name 
    }
}

resource "oci_load_balancer_hostname" "test_hostname" {
    #Required
    hostname = var.hostname_hostname
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
    name = var.hostname_name == null ? format("hostname_%s", local.current_date) : var.hostname_name

    #Optional
    lifecycle {
        create_before_destroy = true
    }
}

#resource "oci_load_balancer_ssl_cipher_suite" "test_ssl_cipher_suite" {
#    #Required
#    ciphers = var.ssl_cipher_suite_ciphers
#    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
#    name = var.ssl_cipher_suite_name
#}

module "compute" {
  source = "./oci_core_instance"
  instance_availability_domain = var.instance_availability_domain
  subnet_id = module.subnet["private"].id[0]
  source_id = var.source_id 
  compartment_id = var.compartment_id 
  instance_shape = var.instance_shape 
  instance_availability_config_recovery_action = var.instance_availability_config_recovery_action 
  instance_metadata = var.instance_metadata
  instance_create_vnic_details_assign_public_ip = var.instance_create_vnic_details_assign_public_ip 
}

module "subnet" {
  source = "./oci_core_subnet"
  compartment_id = var.compartment_id
  vcn_id = var.vcn_id
  for_each = var.subnet_map
  subnet_dns_label = each.key
  subnet_cidr_block = each.value.cidr 
  subnet_prohibit_internet_ingress = each.value.subnet_prohibit_internet_ingress 
  subnet_prohibit_public_ip_on_vnic = each.value.subnet_prohibit_public_ip_on_vnic 
  subnet_security_list_ids = local.security_list[each.key]
}

resource "oci_core_security_list" "public" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = var.vcn_id

    #Optional
    display_name = "HTTP(S) Access Security List"

    egress_security_rules {
        #Required
        destination = var.subnet_map.private.cidr
        protocol = 6

        #Optional
        description = "Backend egress traffic"
        destination_type = "CIDR_BLOCK"
        stateless = true
        tcp_options {

            #Optional
            max = var.backend_port
            min = var.backend_port
        }
    }

    egress_security_rules {
        #Required
        destination = var.subnet_map.private.cidr
        protocol = 6

        #Optional
        description = "Backend healthcheck egress traffic"
        destination_type = "CIDR_BLOCK"
        stateless = true
        tcp_options {

            #Optional
            max = var.backend_set_health_checker_port
            min = var.backend_set_health_checker_port
        }
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = var.subnet_map.private.cidr

        #Optional
        description = "Backend ingress traffic"
        source_type = "CIDR_BLOCK"
        stateless = true
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = var.subnet_map.private.cidr

        #Optional
        description = "Backend healthcheck ingress traffic"
        source_type = "CIDR_BLOCK"
        stateless = true
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = "0.0.0.0/0"

        #Optional
        description = "Backend healthcheck ingress traffic"
        source_type = "CIDR_BLOCK"
        stateless = false
        tcp_options {
            #Optional
            max = 443
            min = 443
        }
    }
}

resource "oci_core_security_list" "private" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = var.vcn_id

    #Optional
    display_name = "HTTP(S) Access Security List"

    egress_security_rules {
        #Required
        destination = var.subnet_map.public.cidr
        protocol = 6

        #Optional
        description = "Backend egress traffic"
        destination_type = "CIDR_BLOCK"
        stateless = true
    }

    egress_security_rules {
        #Required
        destination = var.subnet_map.public.cidr
        protocol = 6

        #Optional
        description = "Backend healthcheck egress traffic"
        destination_type = "CIDR_BLOCK"
        stateless = true
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = var.subnet_map.public.cidr

        #Optional
        description = "Backend ingress traffic"
        source_type = "CIDR_BLOCK"
        stateless = true
        tcp_options {

            #Optional
            max = var.backend_port
            min = var.backend_port
        }
    }

    ingress_security_rules {
        #Required
        protocol = 6
        source = var.subnet_map.public.cidr

        #Optional
        description = "Backend healthcheck ingress traffic"
        source_type = "CIDR_BLOCK"
        stateless = true
        tcp_options {

            #Optional
            max = var.backend_set_health_checker_port
            min = var.backend_set_health_checker_port
        }
    }
}
