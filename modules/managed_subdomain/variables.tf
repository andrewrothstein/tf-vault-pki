variable "tld" {
    description = "top level domain, e.g. drewfus.org"
    type = string
}

variable "domain" {
    description = "domain within the top level domain to manage"
    type = string
}

variable "subdomain" {
    type = string
}

variable "pki_intermediate_path" {
    type = string
}

