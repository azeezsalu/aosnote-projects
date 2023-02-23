# create security group for the application load balancer
resource "aws_security_group" "alb_security_group" {
  name        = "${}-${}-alb-sg"
  description = "enable http/https access on port 80/443"
  vpc_id      = 

  ingress {
    description = "http access"
    from_port   = 
    to_port     = 
    protocol    = 
    cidr_blocks = 
  }

  ingress {
    description = "https access"
    from_port   = 
    to_port     = 
    protocol    = 
    cidr_blocks = 
  }

  egress {
    from_port   = 
    to_port     = 
    protocol    = 
    cidr_blocks = 
  }

  tags = {
    Name = "${}-${}-alb-sg"
  }
}

# create security group for the bastion host aka jump box
resource "aws_security_group" "bastion_security_group" {
  name        = "${}-${}-bastion-sg"
  description = "enable ssh access on port 22"
  vpc_id      = 

  ingress {
    description = "ssh access"
    from_port   = 
    to_port     = 
    protocol    = 
    cidr_blocks = 
  }

  egress {
    from_port   = 
    to_port     = 
    protocol    = 
    cidr_blocks = 
  }

  tags = {
    Name = "${}-${}-bastion-sg"
  }
}

# create security group for the app server
resource "aws_security_group" "app_server_security_group" {
  name        = "${}-${}-app-server-sg"
  description = "enable http/https access on port 80/443 via alb sg"
  vpc_id      = 

  ingress {
    description     = "http access"
    from_port       = 
    to_port         = 
    protocol        = 
    security_groups = 
  }

  ingress {
    description     = "https access"
    from_port       = 
    to_port         = 
    protocol        = 
    security_groups = 
  }

  egress {
    from_port   = 
    to_port     = 
    protocol    = 
    cidr_blocks = 
  }

  tags = {
    Name = "${}-${}-app-server-sg"
  }
}

# create security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "${}-${}-database-sg"
  description = "enable mysql/aurora access on port 3306"
  vpc_id      = 

  ingress {
    description     = "mysql/aurora access"
    from_port       = 
    to_port         = 
    protocol        = 
    security_groups = 
  }

  ingress {
    description     = "custom access"
    from_port       = 
    to_port         = 
    protocol        = 
    security_groups = 
  }

  egress {
    from_port   = 
    to_port     = 
    protocol    = 
    cidr_blocks = 
  }

  tags = {
    Name = "${}-${}-database-sg"
  }
}