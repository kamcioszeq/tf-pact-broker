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
  key_name = "kamiltest"
  #associate_public_ip_address = "true"

  connection {
    user = "ubuntu"
    type = "ssh"
    private_key = file("kamiltest.pem")
    host = self.public_ip
  }

  provisioner "file" {
    source = "templates/nginx.conf"
    destination = "/tmp/nginx.conf"
  }

  provisioner "file" {
    source = "templates/pact-broker.sh"
    destination = "/tmp/pact-broker.sh"
  }

  provisioner "file" {
    source = "templates/rack.conf"
    destination = "/tmp/rack.conf"
  }

  provisioner "file" {
    source = "templates/Gemfile"
    destination = "/tmp/Gemfile"
  }

  provisioner "file" {
    source = "templates/upstart.conf"
    destination = "/tmp/upstart.conf"
  }

  provisioner "file" {
    source = "templates/nginx-upstart.conf"
    destination = "/tmp/nginx-upstart.conf"
  }

  # use this until files can be templated
  provisioner "remote-exec" {
    inline = [
      "echo 'export DB_HOST=${var.db_host}' >> /tmp/postgres_vars",
      "echo 'export DB_NAME=${var.db_name}' >> /tmp/postgres_vars",
      "echo 'export DB_USERNAME=${var.db_username}' >> /tmp/postgres_vars",
      "echo 'export DB_PASSWORD=${var.db_password}' >> /tmp/postgres_vars",
      "echo 'export DB_URL=postgres://$DB_USERNAME:$DB_PASSWORD@$DB_HOST/$DB_NAME' >> /tmp/postgres_vars"
    ]
  }

  provisioner "remote-exec" {
    scripts = [
      "scripts/install.sh",
      "scripts/server.sh",
      "scripts/service.sh",
    ]
  }
}

resource "aws_eip" "lb" {
    instance = "${aws_instance.server.id}"
    vpc = true
}

