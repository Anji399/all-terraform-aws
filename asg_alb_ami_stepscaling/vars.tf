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
    ap-south-1 = "ami-0ffd0c49d372aaf07"
  }
}
