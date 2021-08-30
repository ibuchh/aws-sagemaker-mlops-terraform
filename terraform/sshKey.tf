# ---------------------------------------------------------------------------------------------------------------------
# SSH key for EC2
# ---------------------------------------------------------------------------------------------------------------------


resource "tls_private_key" "dev_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.generated_key_name
  public_key = tls_private_key.dev_key.public_key_openssh
  # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDQUK1AiGh/+2gKtk3y6c/LGLg+xpUW09IwYPhiEXslcrCKPBZEAweD7z6tj1j0yFGLmQIghMB4NZ8hU2meW+CwVoXKhCOa7rYl0xbFlel3Nokeq6FxUTtR+kPUJgmrgHBPQmdpvYnWAVG8jRXcBfblV60lebXI4rjky2ruoLKSHsa1/g9lEAP/Wvojv8eTJWAZ0BfsNxpmdVCtR8s0UVWtMQ58n3tR72wz1kiwjPhFil+elQWvU96LheVmntZz5Qf1bUL09pJUbqdC+CnMur0l9KawXv7VTiPTE6J+rxOr5H8shHRNSreANPblSdRc9uY6V+xVk2l2jsscc4FwcCV ec2-user@ip-172-31-45-54.ec2.internal"

  provisioner "local-exec" {    # Generate "terraform-key-pair.pem" in current directory
    command = "echo '${tls_private_key.dev_key.private_key_pem}' > ./'${var.generated_key_name}'.pem"
  }

  provisioner "local-exec" {
    command = "chmod 400 ./'${var.generated_key_name}'.pem"
  }
}