resource "aws_instance" "webserver_instance" {
  ami                         = "ami-0376ec8eacdf70aae"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = "webserver-ssh-key-pair"
  subnet_id                   = aws_subnet.webserver_subnet.id
  vpc_security_group_ids      = [aws_security_group.webserver_security_group.id]
  user_data                   = file("./launch-instance.sh")
  tags = {
    Name    = "webserver"
    project = "web server"
  }
}