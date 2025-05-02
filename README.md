# AWSPadel

This project sets up a WordPress website using Terraform and AWS services. It was developed during the AWS re/Start program and is structured to follow best practices for modular infrastructure as code.

## Project Overview

**Tech Stack:**  
- AWS (EC2, RDS, VPC, ALB, Security Groups)
- Terraform (modular structure)
- WordPress (as a CMS)
  
**Features:**  
- Public EC2 instance hosting WordPress (temporarily without NAT Gateway and Bastion for cost-saving during dev/testing)
- RDS MySQL database in private subnets
- Application Load Balancer routing traffic to EC2
- Security groups with temporary wide-open rules (HTTP/SSH for testing)

## Repository Structure

```
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── modules
│   ├── ec2
│   ├── vpc
│   ├── alb
│   ├── rds
│   └── security
└── user_data.sh
```

## Deployment Instructions

1. Clone the repo and navigate to the root directory.
2. Make sure your AWS credentials are correctly set (via Terraform Cloud workspace or `.aws/credentials`).
3. Adjust `terraform.tfvars` if needed (like `db_name`, `key_name`, etc.).
4. Run `terraform init`, `terraform plan`, and `terraform apply`.

## WordPress Setup

Once deployed, open the ALB DNS in your browser. Fill in the WordPress setup with the following:
- **DB Name:** `wordpress`
- **Username:** `adminwpuser`
- **Password:** `T******`
- **DB Host:** `<copied from RDS output or Terraform Cloud variable>`

## Notes

- NAT Gateway and Bastion host are commented out during testing to save credits.
- All security groups should be reviewed and restricted before production deployment.
- Secrets and sensitive credentials are managed via Terraform Cloud variables.

## License

This project is part of a learning program and is intended for educational purposes.
