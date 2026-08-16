# AWS-TestEc2Stack
Deploy a Ubuntu EC2 for test. It can only create SSH connection from your own IP address and can get ICMP check from internet.

Make files into a zip file.
Upload the zip file to your cloudshell.
Unzip the zip file.
Do this commands.
    cd [unziped folder]
    chmod +x deploy.sh delete.sh key-gen.sh
    ./deploy.sh

Then your ec2 public ip address will be deplayed. Download your ssh key and just make ssh connection to you EC2.

When you want to delete your EC2, do this command.
    ./delete.sh