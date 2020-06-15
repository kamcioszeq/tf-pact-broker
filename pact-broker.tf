provider "aws" {
  #access_key = "${var.aws_access_key}"
  #secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

resource "aws_security_group" "pact-broker" {
  name = "pact-broker"
  description = "pact broker ui and ssh"
  /*vpc_id = "${var.aws_vpc}"*/

  // These are for internal traffic
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // These are for maintenance
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}

resource "aws_instance" "server" {

  ami = var.aws_ami
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.pact-broker.id]
  #associate_public_ip_address = "true"
  user_data = data.template_file.bootstrap.rendered
}

data "template_file" "bootstrap" {
  template = file("install.tpl")
  vars = {
    nginx = "${file("templates/nginx.conf")}"
    #DB_HOST=var.db_host
    #DB_NAME=var.db_name
    #DB_PASSWORD=var.db_password
    #DB_USERNAME=var.db_username
  }    
}

resource "aws_eip" "lb" {
    instance = "${aws_instance.server.id}"
    vpc = true
}

