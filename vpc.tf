resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${var.prefix}-vpc"
    }
}

// This will show the availability zones
data "aws_availability_zones" "available" {}
# output "az" {
#   value = "${data.aws_availability_zones.available.names}"
# }

// create the subnets
resource "aws_subnet" "subnets" {
    count = 2
    availability_zone = data.aws_availability_zones.available.names[count.index]
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.${count.index}.0/24"
    map_public_ip_on_launch = true
    tags = {
         Name = "${var.prefix}-subnet-${count.index}"
    }
}


// Manually create subnets
# resource "aws_subnet" "new-subnet-1" {
#     availability_zone = "us-east-1b"
#     vpc_id = aws_vpc.main.id
#     cidr_block = "10.0.0.0/24"
#     tags = {
#         Name = "${var.prefix}-subnet-2"
#     }
# }

# resource "aws_subnet" "new-subnet-1" {
#     availability_zone = "us-east-1a"
#     vpc_id = aws_vpc.main.id
#     cidr_block = "10.0.0.0/24"
#     tags = {
#         Name = "fullcycle-subnet-2"
#     }
# }