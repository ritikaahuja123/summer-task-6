provider "aws" {
    region = "ap-south-1"
    profile = "default"
}
# Launch Ec2 instance 
resource "aws_instance" "NewOS" {
	ami = "ami-0ad704c126371a549"
	instance_type = "t2.micro"
	
	tags = {
		Name = "MLOS"
	}
}

output "MY_AZ" {
	value= aws_instance.NewOS.availability_zone
}

output "MY_PUBLIC_IP" {
	value= aws_instance.NewOS.public_ip
}

# create EBS volume
resource "aws_ebs_volume" "myvol" {
	availability_zone = aws_instance.NewOS.availability_zone
	size = 5

	tags = {
		Name = "MLvol"
	}
}

# Attach the volume to the OS
resource "aws_volume_attachment" "vol_attach" {
	device_name = "/dev/sdb"
 	volume_id   = aws_ebs_volume.myvol.id
	instance_id = aws_instance.NewOS.id
}



