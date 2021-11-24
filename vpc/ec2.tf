### EC2 ###
# SG - allow SSH and ICMP to EC2 
resource "aws_security_group" "vpc-a-sg-ec2" {
  name = "vpc-a-sg-ec2"
  description = "Allow incoming HTTP connections"
  vpc_id = aws_vpc.apr-vpc-01.id
  ingress {
    from_port = 22 #ssh 접속을 위한 Inbound
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8 #ping test를 위한 Inbound
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
    # resource "aws_security_group" "vpc-b-sg-ec2" {
    #   name = "vpc-b-sg-ec2"
    #   description = "Allow incoming HTTP connections"
    #   vpc_id = aws_vpc.vpc-b.id
    #   ingress {
    #     from_port = 22 #ssh 접속을 위한 Inbound
    #     to_port = 22
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    #   }
    #   ingress {
    #     from_port = 8 #ping test를 위한 Inbound
    #     to_port = 0
    #     protocol = "icmp"
    #     cidr_blocks = ["0.0.0.0/0"]
    #   } 
    #   egress {
    #     from_port = 0
    #     to_port = 0
    #     protocol = "-1"
    #     cidr_blocks = ["0.0.0.0/0"]
    #   }
    #   tags = {
    #     Name = "vpc-b-sg-ec2"
    #     Environment = var.app_environment
    #   }
    # }
#########################################################################################
#Create Elastic IP for web server
resource "aws_eip" "vpc-a-eip-ec2" {
  vpc = true
  tags = {
    Name = "elastic-ip"
  }
}
    # resource "aws_eip" "vpc-b-eip-ec2" {
    #   vpc = true
    #   tags = {
    #     Name = "elastic-ip"
    #     Environment = var.app_environment
    #   }
    # }
#########################################################################################

#Create EC2 Instances for Web Server
resource "aws_instance" "vpc-a-ec2-test" {
  ami = "ami-097fc5cd098dd20d5"
  instance_type = "t3.small"
  subnet_id = aws_subnet.apr-subnet-private-vpc01-prd-a01.id
  vpc_security_group_ids = [aws_security_group.vpc-a-sg-ec2.id]
  associate_public_ip_address = true
  source_dest_check = false
  key_name = "keykey"
  tags = {
    Name = "vpc-a-ec2-test"
  }
  user_data = file("userdata_suse.sh")
}
    # resource "aws_instance" "vpc-b-ec2-test" {
    #   ami = "ami-09282971cf2faa4c9"
    #   instance_type = "t3.micro"
    #   subnet_id = aws_subnet.vpc-b-subnet-a.id
    #   vpc_security_group_ids = [aws_security_group.vpc-b-sg-ec2.id]
    #   associate_public_ip_address = true
    #   source_dest_check = false
    #   key_name = "keykey"
    #   tags = {
    #     Name = "vpc-b-ec2-test"
    #     Environment = var.app_environment
    #   }
    # }

########################################################################################
#Associate Elastic IP to Web Server
resource "aws_eip_association" "vpc-a-eip-association" {
  instance_id = aws_instance.vpc-a-ec2-test.id
  allocation_id = aws_eip.vpc-a-eip-ec2.id
}
    # resource "aws_eip_association" "vpc-b-eip-association" {
    #   instance_id = aws_instance.vpc-b-ec2-test.id
    #   allocation_id = aws_eip.vpc-b-eip-ec2.id
    # }


###  EBS  ###
resource "aws_ebs_volume" "ebs11" {
  availability_zone = "ap-northeast-2a"
  size              = 11
}
resource "aws_ebs_volume" "ebs22" {
  availability_zone = "ap-northeast-2a"
  size              = 22
}
resource "aws_ebs_volume" "ebs33" {
  availability_zone = "ap-northeast-2a"
  size              = 33
}
resource "aws_ebs_volume" "ebs44" {
  availability_zone = "ap-northeast-2a"
  size              = 44
}

resource "aws_volume_attachment" "ebs11_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebs11.id
  instance_id = aws_instance.vpc-a-ec2-test.id
}
resource "aws_volume_attachment" "ebs22_att" {
  device_name = "/dev/sdi"
  volume_id   = aws_ebs_volume.ebs22.id
  instance_id = aws_instance.vpc-a-ec2-test.id
}
resource "aws_volume_attachment" "ebs33_att" {
  device_name = "/dev/sdj"
  volume_id   = aws_ebs_volume.ebs33.id
  instance_id = aws_instance.vpc-a-ec2-test.id
}
resource "aws_volume_attachment" "ebs44_att" {
  device_name = "/dev/sdk"
  volume_id   = aws_ebs_volume.ebs44.id
  instance_id = aws_instance.vpc-a-ec2-test.id
}
