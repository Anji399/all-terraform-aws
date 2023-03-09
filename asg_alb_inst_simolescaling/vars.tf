variable "AWS_REGION" {
  default = "ap-south-1"
}
variable "PATH_TO_PRIVATE_KEY" {
  default = "febo"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "febo.pub"
}
variable "AMIS" {
  type = map
  default = {
    ap-south-1 = "ami-0f8ca728008ff5af4"
  }
}
