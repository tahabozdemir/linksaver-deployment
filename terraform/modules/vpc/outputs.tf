output "vpc_subnet_public_id" {
  value = aws_subnet.linksaver_subnet_public.id
}

output "linksaver_vpc_id" {
  value = aws_vpc.linksaver_vpc.id
}