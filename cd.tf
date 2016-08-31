provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "go_server" {
    ami = "ami-7172b611"
    instance_type = "t2.micro"
}

resource "aws_instance" "go-agent" {
    count = "${var.agent_count}"
    ami = "ami-7172b611"
    instance_type = "t2.micro"
}

resource "aws_instance" "artifactory_server" {
    ami = "ami-7172b611"
    instance_type = "t2.micro"
}

