data "template_file" "user_data" {
	template = file("user_data.sh")

	vars = {
	  device_name = var.ebs_device_name
          nginx = data.local_file.nginx.content
          pact_broker = data.local_file.pact_broker.content
	  rack = data.local_file.rack.content
	  gemfile = data.local_file.gemfile.content
	  upstart = data.local_file.upstart.content
	  nginx_upstart = data.local_file.nginx_upstart.content
	  install = data.local_file.install.content
	  server_install = data.local_file.server_install.content
	  service_install = data.local_file.service_install.content
	  DB_HOST = var.db_host
	  DB_NAME = var.db_name
	  DB_USERNAME = var.db_username
	  DB_PASSWORD = var.db_password
	  
        }
}

data "local_file" "nginx" {
  filename = "templates/nginx.conf"
}

data "local_file" "pact_broker" {
  filename = "templates/pact-broker.conf"
}

data "local_file" "rack" {
  filename = "templates/rack.conf"
}

data "local_file" "gemfile" {
  filename = "templates/Gemfile"
}

data "local_file" "upstart" {
  filename = "templates/upstart.conf"
}

data "local_file" "nginx_upstart" {
  filename = "templates/nginx-upstart.conf"
}

data "local_file" "install" {
  filename = "scripts/install.sh"
}

data "local_file" "server_install" {
  filename = "scripts/server.sh"
}

data "local_file" "service_install" {
  filename = "scripts/service.sh"
}

