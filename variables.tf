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
