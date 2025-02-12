variable "region" {
  default = "us-west-1"
}

variable "source_ami" {
  default = "ami-010c0d7fc6d401cc5"
}

variable "buildId" {
  default = ""
}

variable "jenkinsBuildId" {
  default = ""
}

variable "artifactId" {
  default = ""
}

variable "fallback_artifact" {
  default = "petclinic"
}

variable "fallback_build_id" {
  default = "default-build"
}

source "amazon-ebs" "example" {
  profile        = "default"
  region         = var.region
  instance_type  = "t2.micro"
  source_ami     = var.source_ami
  ssh_username   = "ubuntu"
  ami_name       = "${var.artifactId}-${var.jenkinsBuildId}-${timestamp()}"
  ami_description = "PetClinic Amazon Ubuntu Image"
  run_tags = {
    Name = "${var.artifactId}-${var.jenkinsBuildId}"
  }
  tags = {
    Tool    = "Packer"
    Name    = "${var.artifactId}-${var.jenkinsBuildId}"
    build_id = "${var.artifactId}-${var.jenkinsBuildId}"
    Author  = "ochoa"
  }
}

build {
  sources = ["source.amazon-ebs.example"]

  provisioner "file" {
    source      = "./${var.buildId}"
    destination = "/tmp/${var.buildId}"
  }

  provisioner "file" {
    source      = "./petclinic.sh"
    destination = "/tmp/petclinic.sh"
  }

  provisioner "file" {
    source      = "./petclinic.service"
    destination = "/tmp/petclinic.service"
  }

  provisioner "shell" {
    script = "./install_app.sh"
    execute_command = "sudo -E -S sh '{{ .Path }}' {{ var.buildId }}"
  }
}
