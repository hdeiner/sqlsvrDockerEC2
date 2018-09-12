resource "aws_key_pair" "sqlsvrDockerEC2_key_pair" {
  key_name = "sqlsvrDockerEC2_key_pair"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}