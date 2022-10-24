variable region {
  default     = "eu-west-1"
}


variable ami {
  default     = "ami-0fd8802f94ed1c969"
}


variable pub_key_path {
  default     = "devops.pub"
}

variable priv_key_path {
  default     = "devops"
}

variable username {
  default     = "ubuntu"
}


variable rmq_user {
  default     = "rabbit"
}

variable rmq_pass {
  default     = "devops123456"
}

variable db_name {
  default     = "accounts"
}

variable db_pass {
  default     = "admin123"
}

variable db_user {
  default     = "admin"
}

variable instance_count {
  default     = 1
}

variable vpc_name {
  default     = "devops-vpc"
}


variable zone1 {
  default     = "eu-west-1a"
}

variable zone2 {
  default     = "eu-west-1b"
}

variable zone3 {
  default     = "eu-west-1c"
}

variable vpc_cidr {
  default     = "172.21.0.0/16"
}

variable pub_sub1_cidr {
  default     = "172.21.1.0/24"
}

variable pub_sub2_cidr {
  default     = "172.21.2.0/24"
}

variable pub_sub3_cidr {
  default     = "172.21.3.0/24"
}

variable priv_sub1_cidr {
  default     = "172.21.4.0/24"
}

variable priv_sub2_cidr {
  default     = "172.21.5.0/24"
}

variable priv_sub3_cidr {
  default     = "172.21.6.0/24"
}