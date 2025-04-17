output "vpc_id" {
    description = "VPC ID"
    value = aws_vpc.main_vpc.id
}
output "public_subnet_ids" {
  description = "Public subnet IDS"
  value=[aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]
}