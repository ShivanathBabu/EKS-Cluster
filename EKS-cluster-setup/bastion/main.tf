resource "aws_instance" "name" {
  ami = local.ami
  instance_type = "t3.micro"
  subnet_id = local.subnet
  vpc_security_group_ids = [local.sg]
  user_data = file("data.sh")
  iam_instance_profile = "AWS_EC2_Admin"

  root_block_device {
    volume_size = 50
    volume_type = "gp3"
  }

  tags = merge(
    local.common_tags,
    {
        Name = "${var.project}-${var.environment}-bastion"
    }
  )

}

