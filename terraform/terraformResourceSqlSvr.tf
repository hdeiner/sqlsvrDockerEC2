resource "aws_instance" "ec2_sqlsvrDockerEC2_sqlsvr" {
  count = 1
  ami = "ami-759bc50a"
  instance_type = "t2.small"
  key_name = "${aws_key_pair.sqlsvrDockerEC2_key_pair.key_name}"
  security_groups = ["${aws_security_group.sqlsvrDockerEC2_sqlsvr.name}"]
  provisioner "remote-exec" {
    connection {
      type = "ssh",
      user = "ubuntu",
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    script = "terraformProvisionSqlSvrUsingDocker.sh"
  }
  tags {
    Name = "sqlsvrDockerEC2 SqlSvr ${format("%03d", count.index)}"
  }
}