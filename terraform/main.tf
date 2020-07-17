variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {}
variable "aws_db_username" {}
variable "aws_db_password" {}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"

}

resource "aws_key_pair" "ichihara" {
  key_name   = "ichihara"
  public_key = file("./ichihara.pub")
}

output "public_ip" {
  value = "${aws_instance.Ichihara_instance.public_ip}"
}
