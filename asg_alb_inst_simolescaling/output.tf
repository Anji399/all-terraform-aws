output "ELB" {
	value = "${aws_lb.my-elb.dns_name}"
}
