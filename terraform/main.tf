provider "aws" {
    region = "${var.aws_region}"
}

resource "aws_elb" "go_server" {
    subnets = ["${aws_subnet.public.id}"]
    instances = ["${aws_instance.go_server.id}"]
    security_groups = ["${aws_security_group.elb_ingress.id}"]
    listener {
        instance_port = 8153
        instance_protocol = "HTTP"
        lb_port = 443
        lb_protocol = "HTTPS"
    }
    
}

resource "aws_elb" "artifactory" {
    subnets = ["${aws_subnet.public.id}"]
    instances = ["${aws_instance.artifactory.id}"]
    security_groups = ["${aws_security_group.elb_ingress.id}"]
    listener {
        instance_port = 8081
        instance_protocol = "HTTP"
        lb_port = 443
        lb_protocol = "HTTPS"
    }
}
