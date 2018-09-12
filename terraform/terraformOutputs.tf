output "sqlsvr_dns" {
  value = ["${aws_instance.ec2_sqlsvrDockerEC2_sqlsvr.*.public_dns}"]
}

output "sqlsvr_ip" {
  value = ["${aws_instance.ec2_sqlsvrDockerEC2_sqlsvr.*.public_ip}"]
}