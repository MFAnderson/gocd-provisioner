resource "aws_security_group" "jumpbox-ingress" {
    name = "${var.vpc_name}-jumpbox-ingress"
    description = "allow remote access to jumpbox"
    vpc_id = "${aws_vpc.vpc.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "outbound" {
    name = "${var.vpc_name}-outbound"
    description = "allow all outbound traffic"
    vpc_id = "${aws_vpc.vpc.id}"
    egress {
        from_port = 0
        to_port = 65535
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "elb_ingress" {
    vpc_id = "${aws_vpc.vpc.id}"
    ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "elb_backed_internal" {
    vpc_id = "${aws_vpc.vpc.id}"
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "TCP"
        security_groups = ["${aws_security_group.elb_ingress.id}"]
    }
}
