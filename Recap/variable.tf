variable "instance_type" {
  default = "t2.micro"
}

variable "port" {
    type = list(objects({
        from = number
        to = number 
    }))
}