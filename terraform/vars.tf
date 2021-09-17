variable REGION-ID {
    default = "ap-south-1"
}

variable INSTANCE-TYPE{
    default = "t2.micro"
}

variable TAGNAME {
    default = "demo-develop"
}

variable VPC-CIDR-BLOCK {
    default = "30.0.0.0/16"
}    

variable SUBNET-CIDR-BLOCK {
    default = ["30.0.1.0/24","30.0.2.0/24"]
}

variable AVAIL-ZONE-1 {
    default = "ap-south-1a"
}

variable AVAIL-ZONE-2 {
    default = "ap-south-1b"
}

variable CIDR-BLOCK{
    default ="10.0.0.0/16"
}

variable AMIS{
    type= map
    default = {
       ap-south-1 = "ami-04bde106886a53080"
    }
}