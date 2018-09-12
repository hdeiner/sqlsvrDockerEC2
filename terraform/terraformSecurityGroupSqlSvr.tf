resource "aws_security_group" "sqlsvrDockerEC2_sqlsvr" {
  name = "sqlsvrDockerEC2_sqlsvr"
  description = "sqlsvrDockerEC2 - SSH and SQL Server Access"
  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  ingress {
    protocol = "tcp"
    from_port = 1433
    to_port = 1433
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  tags {
    Name = "sqlsvrDockerEC2 SqlSvr"
  }
}