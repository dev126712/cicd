resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = aws_vpc.vpc_cicd.id
  service_name      = "com.amazonaws.ca-central-1.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private-route-table.id
  ]

  tags = {
    Name        = "S3-Gateway-Endpoint-for-CI-CD"
    Environment = "test"
  }
}
