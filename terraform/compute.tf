# ---------------------------------------------------------------------------------------------------------------------
# Jenkins EC2 instance
# ---------------------------------------------------------------------------------------------------------------------

data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*-x86_64-gp2",
    ]
  }
  filter {
    name = "owner-alias"
    values = [
      "amazon",
    ]
  }
}

resource "aws_instance" "jenkins-instance" {
  ami             = "${data.aws_ami.amazon-linux-2.id}"
  instance_type   = var.instance_type
  key_name        = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = ["${aws_security_group.sg_jenkins.id}"]
  subnet_id          = "${aws_subnet.public.0.id}"
  user_data = "${file("install-jenkins.sh")}"

  associate_public_ip_address = true
  tags = {
    Name = "jenkins-instance"
  }
}

output "jenkins_ip_address" {
  value = aws_instance.jenkins-instance.public_ip
}