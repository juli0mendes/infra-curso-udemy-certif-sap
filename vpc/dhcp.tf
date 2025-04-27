resource "aws_vpc_dhcp_options" "dhcp_vpc_a" {
  domain_name_servers   = ["AmazonProvidedDNS"]
  domain_name           = "ec2.internal"
  netbios_name_servers  = []
  netbios_node_type     = 2
  ntp_servers           = ["169.254.169.123"]

  tags = {
    "Name" = "dhcp-options-vpc-a"
  }
}

resource "aws_vpc_dhcp_options_association" "dhcp_assoc_vpc_a" {
  vpc_id          = aws_vpc.vpc_a.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_vpc_a.id
}