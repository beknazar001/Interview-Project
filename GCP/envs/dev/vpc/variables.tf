variable "project_id" {
  description = "Project name where the resource will be created."
  type        = string
}

variable "region" {
  description = "Region where by default your resource will be created."
  type        = string
}
variable "main_zone" {
  description = "Zone where by default your resource will be created."
  type        = string
}

#============================= SUBNETWORKS VARIABLES ===================================
variable "subnets" {
  type = list(map(string))
}

#============================ FIREWALL RULES VARIABLES =================================
variable "firewall_rules" {
  description = "List of custom rule definitions (refer to variables file for syntax)."
  default     = []
  type = list(object({
    name        = string
    direction   = string
    ranges      = list(string)
    source_tags = list(string)
    target_tags = list(string)
    allow = list(object({
      protocol = string
      ports    = list(string)
    }))
    deny = list(object({
      protocol = string
      ports    = list(string)
    }))
  }))
}
#========================== ROUTERS ==================================
variable "routes" {

}
