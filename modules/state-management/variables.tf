
variable "env" {
  description = "Environment prefix for all resources."
  type        = string
}

variable "region" {
  description = "Region of deployment."
  type        = string
  default     = "us-west-2"
}