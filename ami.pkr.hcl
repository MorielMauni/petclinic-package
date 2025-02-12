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
  profile         = "default"
  region          = var.region
  instance_type   = "t2.micro"
  source_ami      = var.source_ami
  ssh_username    = "ubuntu"
  ami_name        = "${coalesce(var.artifactId, var.fallback_artifact)}-${coalesce(var.jenkinsBuildId, var.fallback_build_id)}-${timestamp()}"
  ami_description = "PetClinic Amazon Ubuntu Image"
  run_tags = {
    Name = "${coalesce(var.artifactId, var.fallback_artifact)}-${coalesce(var.jenkinsBuildId, var.fallback_build_id)}"
  }
  tags = {
    Tool     = "Packer"
    Name     = "${coalesce(var.artifactId, var.fallback_artifact)}-${coalesce(var.jenkinsBuildId, var.fallback_build_id)}"
    build_id = "${coalesce(var.artifactId, var.fallback_artifact)}-${coalesce(var.jenkinsBuildId, var.fallback_build_id)}"
    Author   = "ochoa"
  }
}

build {
  sources = [
    "source.amazon-ebs.example"
  ]
}
