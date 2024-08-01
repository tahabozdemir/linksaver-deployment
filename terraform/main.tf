module "VPC" {
  source = "./modules/vpc"
}

module "SecurityGroup" {
  source           = "./modules/sec-group"
  linksaver_vpc_id = module.VPC.linksaver_vpc_id
}

module "S3" {
  source = "./modules/s3"
}

resource "aws_key_pair" "deployer" {
  key_name   = var.ec2_key_name
  public_key = file("./ssh-key/linksaver-ec2.pub")
}

resource "aws_instance" "linksaver_web_server" {
  ami                         = data.aws_ami.AmazonLinux.id
  key_name                    = aws_key_pair.deployer.key_name
  instance_type               = var.ec2_type
  associate_public_ip_address = true
  subnet_id                   = module.VPC.vpc_subnet_public_id
  vpc_security_group_ids      = [module.SecurityGroup.sg_id]
  tags = {
    Name = "Linksaver Web Server"
  }
}