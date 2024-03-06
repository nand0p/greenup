variable "bucket" {
  type    = string
  default = "greenup.hex7.com"
}

variable "tags" {
  type    = map
  default = {   
    Name  = "green.hex7.com"
  }
}

# greenup.hex7.com
variable "acm_certificate_arn" {
  type    = string
  default = "arn:aws:acm:us-east-1:082847268983:certificate/14d665d2-8b8e-4e7d-bbe3-926a00ac429f"
}
  
