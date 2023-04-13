resource "aws_instance" "my_test_ec2_instance" {
  ami                         = "ami-0376ec8eacdf70aae"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "my-test-ssh-key-pair"
  subnet_id                   = aws_subnet.my_subnet_test.id
  vpc_security_group_ids      = [aws_security_group.my_sg_ssh.id]
  user_data                   = file("./launch-instance.sh")
  tags = {
    Name    = "my-test-ec2-ssh"
    project = "web server"
  }
}