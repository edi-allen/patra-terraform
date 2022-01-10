variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 80
}

variable "alb_port" {
  description = "The port the application load balancer will use for HTTP requests"
  type        = number
  default     = 80
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}
