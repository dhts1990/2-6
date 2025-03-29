variable "name_prefix" {
 description = "Name prefix for application"
 type        = string
 default     = "huang-tf-2-6"
}


variable "instance_type" {
 description = "Instance type of ec2"
 type        = string
 default     = "t2.micro"
}


variable "instance_count" {
 description = "Count of ec2 instance"
 type        = number
 default     = 1
}


variable "public_subnet" {
 description = "Choice of deploying to public or private subnet"
 type        = bool
 default     = true
}

variable "key_name" {
  description = "Name of EC2 Key Pair"
  type        = string
  default     = "huang-keypair-2025"
}

variable "alb_listener_arn" {
 description = "ALB listener Arn"
 type        = string
 default     = ""
}