variable "load_balancer_routing_policy_condition_language_version" {
	description = "The version of the language in which condition of rules are composed."
}

variable "load_balancer_routing_policy_name" {
	description = "The name for this list of routing rules. It must be unique and it cannot be changed."
	default = null
}

variable "load_balancer_routing_policy_rules_actions_name" {
	description = "The name can be one of these values: FORWARD_TO_BACKENDSET"
}

variable "load_balancer_routing_policy_rules_condition" {
	description = "A routing rule to evaluate defined conditions against the incoming HTTP request and perform an action."
}

variable "load_balancer_routing_policy_rules_name" {
	description = "A unique name for the routing policy rule. Avoid entering confidential information."
	default = null
}
