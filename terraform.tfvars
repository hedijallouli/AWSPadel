aws_region           = "us-west-2"
vpc_cidr             = "10.0.0.0/16"
azs                  = ["us-west-2a", "us-west-2b"]
public_subnet_cidrs  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidrs = ["10.0.2.0/24", "10.0.3.0/24"]

ami_id                = "ami-05572e392e80aee89"
instance_type         = "t2.micro"
key_name              = "vockey"

ssh_access_cidr   = "197.22.69.68/32"

db_name = "wordpress"
user_data_base64 = "IyEvYmluL2Jhc2gKeXVtIHVwZGF0ZSAteQoKIyBJbnN0YWxsIHJlcXVpcmVkIHBhY2thZ2VzCnl1bSBpbnN0YWxsIC15IGh0dHBkIHBocCBwaHAtbXlzcWxuZCBwaHAtZnBtIHdnZXQgdW56aXAKCiMgQ3JlYXRlIC92YXIvd3d3L2h0bWwgaWYgbm90IGV4aXN0cwpta2RpciAtcCAvdmFyL3d3dy9odG1sCgojIEVuYWJsZSBhbmQgc3RhcnQgQXBhY2hlIGFuZCBQSFAtRlBNCnN5c3RlbWN0bCBlbmFibGUgaHR0cGQKc3lzdGVtY3RsIHN0YXJ0IGh0dHBkCnN5c3RlbWN0bCBlbmFibGUgcGhwLWZwbQpzeXN0ZW1jdGwgc3RhcnQgcGhwLWZwbQoKIyBEb3dubG9hZCBhbmQgc2V0IHVwIFdvcmRQcmVzcwpjZCAvdmFyL3d3dy9odG1sCndnZXQgaHR0cHM6Ly93b3JkcHJlc3Mub3JnL2xhdGVzdC50YXIuZ3oKdGFyIC14emYgbGF0ZXN0LnRhci5negpjcCAtciB3b3JkcHJlc3MvKiAuCnJtIC1yZiB3b3JkcHJlc3MgbGF0ZXN0LnRhci5negpjaG93biAtUiBhcGFjaGU6YXBhY2hlIC92YXIvd3d3L2h0bWwKY2htb2QgLVIgNzU1IC92YXIvd3d3L2h0bWwKCiMgQ29uZmlndXJlIEFwYWNoZSBmb3IgV29yZFByZXNzCmNhdCA8PE9PVCBbIC9ldGMvaHR0cGQvY29uZi5kL3dvcmRwcmVzcy5jb25mClxERXJlY3RvcnkgL3Zhci93d3cvaHRtbApJbmRleERpcmVjdG9yeSBpbmRleC5waHAgaW5kZXguaHRtbApBbGxvd092ZXJyaWRlIEFsbAogUmVxdWlyZSBhbGwgZ3JhbnRlZAovL0RFRgoKT1OgdCAtZWkgL3Zhci93d3cvaHRtbC93cC1jb25maWcucGhwIC1lICdzL2RhdGFiYXNlX25hbWVfaGVyZS8ke2RiX25hbWV9LycKc2VkIC1pICJzL3VzZXJuYW1lX2hlcmUvJHtkYl91c2VybmFtZX0vIiAvdmFyL3d3dy9odG1sL3dwLWNvbmZpZy5waHAKc2VkIC1pICJzL3Bhc3N3b3JkX2hlcmUvJHtkYl9wYXNzd29yZH0vIiAvdmFyL3d3dy9odG1sL3dwLWNvbmZpZy5waHAKc2VkIC1pICJzL2xvY2FsaG9zdC8ke2RiX2hvc3R9LyIgL3Zhci93d3cvaHRtbC93cC1jb25maWcucGhwCgpzeXN0ZW1jdGwgcmVzdGFydCBodHRwZA=="