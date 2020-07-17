resource "aws_instance" "Ichihara_instance" {
  ami           = "ami-00e58f8044c7f8ad1"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    "${aws_security_group.ichihara_security_group.id}"
  ]
  subnet_id                   = "${aws_subnet.ichihara_Subnet.id}"
  associate_public_ip_address = "true"
  key_name                    = "${aws_key_pair.ichihara.id}"

}
