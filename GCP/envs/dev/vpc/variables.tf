variable "project_id" {
  description = "Project name where the resource will be created."
  type        = string
}
variable "credentials_file_path" {
  description = "Path to your credentials file."
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

#--------------------------------- PRESENTATION ----------------------------------------
variable "presentation_ip_range" {
  description = "IP range of Presentation subnetwork"
  type        = string
  default     = "10.100.0.0/16"
}

#--------------------------------- APPLICATION -----------------------------------------
variable "application_ip_range" {
  description = "IP range of Application subnetwork"
  type        = string
  default     = "10.101.0.0/16"
}
#----------------------------------- DATABASE ------------------------------------------
variable "database_ip_range" {
  description = "IP range of Database subnetwork"
  type        = string
  default     = "10.102.0.0/16"
}


#================================== ROUTES VARIABLE ====================================
variable "igw_destination" {
  description = "The destination range of outgoing packets that this route applies to. Only IPv4 is supported"
  type        = string
  default     = "0.0.0.0/0"
}




#============================ FIREWALL RULES VARIABLES =================================

#------------------------------ PRESENTATION FIREWALL ----------------------------------
variable "presentation_firewall_ranges" {
  description = "If direction <INGRESS> are specified, the firewall will apply only to traffic that has source IP address in these ranges. If direction <EGRESS>  are specified, the firewall will apply only to traffic that has destination IP address in these ranges."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

#------------------------------ APPLICATION FIREWALL -----------------------------------
variable "application_firewall_ranges" {
  description = "If direction <INGRESS> are specified, the firewall will apply only to traffic that has source IP address in these ranges. If direction <EGRESS>  are specified, the firewall will apply only to traffic that has destination IP address in these ranges."
  type        = list(string)
  default     = ["10.100.0.0/16"]
}


#------------------------------ DATABASE FIREWALL --------------------------------------
variable "database_firewall_ranges" {
  description = "If direction <INGRESS> are specified, the firewall will apply only to traffic that has source IP address in these ranges. If direction <EGRESS>  are specified, the firewall will apply only to traffic that has destination IP address in these ranges."
  type        = list(string)
  default     = ["10.101.0.0/16"]
}