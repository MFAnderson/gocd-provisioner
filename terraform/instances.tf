resource "aws_instance" "jumpbox" {
    ami = "ami-7172b611"
    instance_type = "t2.micro"
    key_name = "${var.vpc_name}-provision-key"

    subnet_id = "${aws_subnet.public.id}"
    vpc_security_group_ids = [
        "${aws_security_group.jumpbox-ingress.id}",
        "${aws_security_group.outbound.id}"
    ]
}

resource "aws_instance" "go_server" {
    ami = "ami-7172b611"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.private.id}"
    vpc_security_group_ids = [
        "${aws_security_group.outbound.id}",
        "${aws_security_group.elb_backed_internal.id}"
    ]
}

resource "aws_instance" "go-agent" {
    count = "${var.agent_count}"
    ami = "ami-7172b611"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.private.id}"
    vpc_security_group_ids = ["${aws_security_group.outbound.id}"]
}

resource "aws_instance" "artifactory" {
    ami = "ami-7172b611"
    instance_type = "t2.micro"
    subnet_id = "${aws_subnet.private.id}"
    vpc_security_group_ids = [
        "${aws_security_group.outbound.id}",
        "${aws_security_group.elb_backed_internal.id}"
    ]
}

