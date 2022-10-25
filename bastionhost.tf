resource "aws_instance" "project-bastion" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  subnet_id              = module.vpc.public_subnets[0]
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.project_bastion_sg.id]
  tags = {
    Name = "Project Bastion Host"
  }
  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.project_rds.address, dbuser = var.db_user, dbpass = var.db_pass })
    destination = "/tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "sudo /tmp/vprofile-dbdeploy.sh"
    ]
  }

  connection {
    user        = var.username
    private_key = file(var.priv_key_path)
    host        = self.public_ip
  }

  depends_on = [aws_db_instance.project_rds]


}