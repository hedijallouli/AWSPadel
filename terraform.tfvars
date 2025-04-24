aws_region           = "us-west-2"
vpc_cidr             = "10.0.0.0/16"
azs                  = ["us-west-2a", "us-west-2b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]

ami_id                = "ami-05572e392e80aee89"
instance_type         = "t2.micro"
key_name              = "vockey"