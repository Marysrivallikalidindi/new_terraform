variable "vpc_name" {
    type = string
    default ="myterraformvpc"
  
}
variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
  
}
variable "subnet1_cidr" {
    type = string
    default ="10.0.0.0/24"
  
}
