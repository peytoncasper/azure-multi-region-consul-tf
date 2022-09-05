variable "resource_group" {
    type = string
}

variable "virtual_network_name" {
    type = string
    default = ""
}


variable "datacenter" {
    type = string
}

variable "primary_datacenter" {
    type = string
}

variable "bootstrap_ip" {
    default = ""
}
