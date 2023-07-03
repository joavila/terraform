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
    current_date       = formatdate("YYYYMMDD_hhmm", local.current_timestamp)
}

resource "oci_load_balancer_load_balancer" "test_load_balancer" {
    #Required
    compartment_id = var.compartment_id
    display_name = var.load_balancer_display_name
    shape = var.load_balancer_shape
    subnet_ids = var.load_balancer_subnet_ids

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
    name = var.backend_set_name
    policy = var.backend_set_policy

    #Optional
    ssl_configuration {

        #Optional
        #certificate_ids = var.backend_set_ssl_configuration_certificate_ids
        #certificate_name = oci_load_balancer_certificate.test_certificate.certificate_name
        cipher_suite_name = var.backend_set_ssl_configuration_cipher_suite_name
        protocols = var.backend_set_ssl_configuration_protocols
        #server_order_preference = var.backend_set_ssl_configuration_server_order_preference
        #trusted_certificate_authority_ids = var.backend_set_ssl_configuration_trusted_certificate_authority_ids
        #verify_depth = var.backend_set_ssl_configuration_verify_depth
        #verify_peer_certificate = var.backend_set_ssl_configuration_verify_peer_certificate
    }
}

module "backend" {
  source = "./oci_load_balancer_backend"
  load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
  for_each = var.backend_map
  backend_ip_address = each.key
  backend_port = each.value
}

resource "oci_load_balancer_certificate" "test_certificate" {
    #Required
    certificate_name = var.certificate_certificate_name
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id

    #Optional
    ca_certificate = var.certificate_ca_certificate
    passphrase = var.certificate_passphrase
    private_key = var.certificate_private_key
    public_certificate = var.certificate_public_certificate

    #lifecycle {
    #    create_before_destroy = true
    #}
}

resource "oci_load_balancer_listener" "test_listener" {
    #Required
    default_backend_set_name = oci_load_balancer_backend_set.test_backend_set.name
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
    name = var.listener_name
    port = var.listener_port
    protocol = var.listener_protocol

    #Optional
    connection_configuration {
        #Required
        idle_timeout_in_seconds = var.listener_connection_configuration_idle_timeout_in_seconds

        #Optional
        backend_tcp_proxy_protocol_version = var.listener_connection_configuration_backend_tcp_proxy_protocol_version
    }
    hostname_names = [oci_load_balancer_hostname.test_hostname.name]
    routing_policy_name = oci_load_balancer_load_balancer_routing_policy.test_load_balancer_routing_policy.name
    ssl_configuration {
        #Optional
        certificate_name = oci_load_balancer_certificate.test_certificate.certificate_name
        #certificate_ids = var.listener_ssl_configuration_certificate_ids
        cipher_suite_name = var.listener_ssl_configuration_cipher_suite_name
        protocols = var.listener_ssl_configuration_protocols
        server_order_preference = var.listener_ssl_configuration_server_order_preference
        #trusted_certificate_authority_ids = var.listener_ssl_configuration_trusted_certificate_authority_ids
        #verify_depth = var.listener_ssl_configuration_verify_depth
        #verify_peer_certificate = var.listener_ssl_configuration_verify_peer_certificate
    }
}

resource "oci_load_balancer_load_balancer_routing_policy" "test_load_balancer_routing_policy" {
    #Required
    condition_language_version = var.load_balancer_routing_policy_condition_language_version
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
    name = var.load_balancer_routing_policy_name
    rules {
        #Required
        actions {
            #Required
            backend_set_name = oci_load_balancer_backend_set.test_backend_set.name
            name = var.load_balancer_routing_policy_rules_actions_name
        }
        condition = var.load_balancer_routing_policy_rules_condition
        name = var.load_balancer_routing_policy_rules_name
    }
}

resource "oci_load_balancer_hostname" "test_hostname" {
    #Required
    hostname = var.hostname_hostname
    load_balancer_id = oci_load_balancer_load_balancer.test_load_balancer.id
    name = var.hostname_name

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
