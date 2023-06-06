## Define the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY to authenticate
provider "aws" {
  region = "eu-central-1"
}

## Create EC2 instance in default vpc
resource "aws_instance" "ubuntu_instance" {
  ami = var.ubuntu_ami  ## ubuntu 22.04
  instance_type = "t3.micro"
  key_name = "ubuntu_instance_kp"
  root_block_device {
    volume_type = "standard"
    volume_size = "30"
  }
  tags = {
    Name = "ubuntu_instance"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("ubuntu_instance_kp.pem")}"
    host        = "${self.public_ip}"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt -y install software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt -y install ansible",
      "sudo apt -y install git",
      "git clone https://github.com/crnakad/devops_projects.git",
      "sudo useradd -m ansible",
      "echo var.UserPass | sudo passwd ansible",
      "sudo usermod -aG sudo ansible",
      "ansible-playbook -i $(pwd)/devops_projects/task1/deploy_dotnet_app/inventory.yaml -e "ansible_password=var.UserPass ansible_become_pass=var.UserPass" $(pwd)/devops_projects/task1/deploy_dotnet_app/playbook.yaml"
    ]
  }
}

