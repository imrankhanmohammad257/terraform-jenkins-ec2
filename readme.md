# 🚀 AWS Jenkins EC2 using Terraform

This project provisions an **EC2 instance on AWS** with **Jenkins and Java installed** using **Terraform**.  
It automates the setup of Jenkins on an **Amazon Linux 2** server (`ami-0886832e6b5c3b9e2`) in the **us-east-1** region.  

---

## ✨ Features
✔️ Creates a **VPC, Subnet, Internet Gateway, and Security Group**  
✔️ Launches an **EC2 instance (t2.medium)**  
✔️ Installs & configures:
   - ☕ Java 17 (Amazon Corretto)  
   - 🛠️ Git  
   - ⚙️ Jenkins (latest stable)  
✔️ Jenkins is **enabled as a service** and runs on **port 8080**  
✔️ Outputs the **Public IP** of the instance for easy access  

---

## 📂 Project Structure

├── main.tf # Terraform resources (VPC, EC2, SG, Jenkins installation) and its having

      variables # Input variables (region, instance_type, etc.)

      provider # AWS provider configuration

      utputs # Output values (Public IP, Instance ID)




---

## 🛠️ Prerequisites
Before you begin, ensure you have:
- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.1.0  
- AWS account + IAM user with **EC2/VPC permissions**  
- AWS CLI configured (`aws configure`)  
- An existing AWS **Key Pair** (for SSH access)  

---

## ⚡ Usage Guide

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/your-username/aws-jenkins-ec2.git
cd aws-jenkins-ec2


2️⃣ Initialize Terraform

terraform init

3️⃣ Validate Configuration

terraform validate

4️⃣ Apply Terraform Plan

terraform apply -auto-approve

🔑 Access Jenkins

Get the public IP:
terraform output public_ip

Open your browser:
http://<public_ip>:8080

Unlock Jenkins:
ssh -i your-key.pem ec2-user@<public_ip>
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Copy the password into the Jenkins setup wizard.


📌 Outputs

🆔 Instance ID

🌐 Public IP

🔗 Jenkins URL → http://<public_ip>:8080


🧹 Cleanup

When finished, destroy the resources:

terraform destroy -auto-approve


📖 Notes

Security Group allows 22 (SSH) and 8080 (Jenkins).

EC2 is launched in us-east-1a AZ by default.

Check Jenkins status:

systemctl status jenkins


✅ With this project, you’ll have a fully automated Jenkins server on AWS EC2 provisioned using Terraform! 🎉
