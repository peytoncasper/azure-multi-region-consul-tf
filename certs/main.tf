resource "null_resource" "consul_ca" {
  provisioner "local-exec" {
    working_dir = "${path.module}"
    command = <<-EOD
    consul tls ca create
    EOD
  }

  provisioner "local-exec" {
    when    = destroy
    working_dir = "${path.module}"
    command = <<-EOD
    rm consul-agent-ca.pem
    rm consul-agent-ca-key.pem
    EOD
  }
}

/// Generate Azure East DC Consul Certs

resource "null_resource" "consul_azure_east_server_0" {
  provisioner "local-exec" {
    working_dir = "${path.module}"
    command = <<-EOD
    consul tls cert create -dc=azure-east -node="server-0" -server
    EOD
  }

  provisioner "local-exec" {
    when    = destroy
    working_dir = "${path.module}"
    command = <<-EOD
    rm azure-east-server-consul-0.pem
    rm azure-east-server-consul-0-key.pem
    EOD
  }
  depends_on = [
    null_resource.consul_ca
  ]
}

resource "null_resource" "consul_azure_east_client_1" {
  provisioner "local-exec" {
    working_dir = "${path.module}"
    command = <<-EOD
    consul tls cert create -dc=azure-east -client
    EOD
  }

  provisioner "local-exec" {
    when    = destroy
    working_dir = "${path.module}"
    command = <<-EOD
    rm azure-east-client-consul-0.pem
    rm azure-east-client-consul-0-key.pem
    EOD
  }
  depends_on = [
    null_resource.consul_ca

  ]
}


resource "null_resource" "consul_azure_east_client_2" {
  provisioner "local-exec" {
    working_dir = "${path.module}"
    command = <<-EOD
    consul tls cert create -dc=azure-east -client
    EOD
  }

  provisioner "local-exec" {
    when    = destroy
    working_dir = "${path.module}"
    command = <<-EOD
    rm azure-east-client-consul-1.pem
    rm azure-east-client-consul-1-key.pem
    EOD
  }
  depends_on = [
    null_resource.consul_ca,
    null_resource.consul_azure_east_client_1
  ]
}

/// Generate Azure West DC Consul Certs

resource "null_resource" "consul_azure_west_server_0" {
  provisioner "local-exec" {
    working_dir = "${path.module}"
    command = <<-EOD
    consul tls cert create -dc=azure-west -node="server-0" -server
    EOD
  }

  provisioner "local-exec" {
    when    = destroy
    working_dir = "${path.module}"
    command = <<-EOD
    rm azure-west-server-consul-0.pem
    rm azure-west-server-consul-0-key.pem
    EOD
  }
  depends_on = [
    null_resource.consul_ca
  ]
}

resource "null_resource" "consul_azure_west_client_1" {
  provisioner "local-exec" {
    working_dir = "${path.module}"
    command = <<-EOD
    consul tls cert create -dc=azure-west -client
    EOD
  }

  provisioner "local-exec" {
    when    = destroy
    working_dir = "${path.module}"
    command = <<-EOD
    rm azure-west-client-consul-0.pem
    rm azure-west-client-consul-0-key.pem
    EOD
  }
  depends_on = [
    null_resource.consul_ca

  ]
}


resource "null_resource" "consul_azure_west_client_2" {
  provisioner "local-exec" {
    working_dir = "${path.module}"
    command = <<-EOD
    consul tls cert create -dc=azure-west -client
    EOD
  }

  provisioner "local-exec" {
    when    = destroy
    working_dir = "${path.module}"
    command = <<-EOD
    rm azure-west-client-consul-1.pem
    rm azure-west-client-consul-1-key.pem
    EOD
  }
  depends_on = [
    null_resource.consul_ca,
    null_resource.consul_azure_west_client_1
  ]
}
