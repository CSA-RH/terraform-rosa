data "aws_route53_zone" "private_rosa_dns_zone" {
  name         = "${ocm_cluster_rosa_classic.rosa.domain}"
  private_zone = true

  depends_on = [ocm_cluster_wait.rosa]
}

resource "aws_route53_zone_association" "egress-rosa-resolver-vpc-assotiation" {
  zone_id = data.aws_route53_zone.private_rosa_dns_zone.id
  vpc_id  = aws_vpc.egress-vpc.id
}

resource "aws_security_group" "rosa-resolution-sg" {
  name        = "allow-dns"
  description = "Allow DNS inbound traffic"
  vpc_id      = aws_vpc.egress-vpc.id

  ingress {
    description      = "DNS (TCP)"
    from_port        = 53
    to_port          = 53
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "DNS (UDP)"
    from_port        = 53
    to_port          = 53
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_route53_resolver_endpoint" "rosa-resolver-inbound-endpoint" {
  name      = "rosa-resolver-inbound-endpoint"
  direction = "INBOUND"

  security_group_ids = [aws_security_group.rosa-resolution-sg.id]

  dynamic "ip_address" {
    for_each = data.aws_availability_zones.azs.names
    content {
      subnet_id = aws_subnet.egress-subnet-pub[ip_address.value].id  
    }
  }
}

