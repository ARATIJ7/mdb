resource "null_resource" "configure_mongodb_replica_set" {
  provisioner "remote-exec" {
    inline = [
      "# Initiate the replica set on the primary instance",
      "mongo --eval 'rs.initiate({_id: \"${var.replica_set_name}\", members: [{ _id: 0, host: \"${aws_instance.mongodb_instance1.public_ip}:27017\" }]})'",

      "# Wait for the primary to be ready",
      "sleep 60",

      "# Add the secondary to the replica set",
      "mongo --eval 'rs.add(\"${aws_instance.mongodb_instance2.public_ip}:27017\")'"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = aws_instance.mongodb_instance1.public_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "# Add the secondary to the replica set",
      "mongo --eval 'rs.add(\"${aws_instance.mongodb_instance2.public_ip}:27017\")'"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = aws_instance.mongodb_instance1.public_ip
    }
  }

  depends_on = [aws_instance.mongodb_instance1, aws_instance.mongodb_instance2]
}
