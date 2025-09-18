# AWS Jenkins EC2 using Terraform

This project provisions an **EC2 instance on AWS** with **Jenkins and Java installed** using **Terraform**.  
It automates the setup of Jenkins on an Amazon Linux 2 server (`ami-0886832e6b5c3b9e2`) in the `us-east-1` region.

---

## 🚀 Features
- Creates a **VPC, subnet, and security group** to allow access.
- Provisions an **EC2 instance (t2.medium)** with Jenkins installed.
- Installs:
  - Java 17 (Amazon Corretto)
  - Jenkins (latest stable)
  - Git
- Configures Jenkins to start automatically on boot.
- Outputs the **public IP** of the instance so you can access Jenkins on port **8080**.

---

## 📂 Project Structure

.
├── main.tf # Terraform resources (VPC, EC2, Security Group, Jenkins installation)
├── variables.tf # Input variables (region, instance_type, etc.)
├── provider.tf # AWS provider configuration
├── outputs.tf # Output values (Public IP, Instance ID)


---

## 🛠️ Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.1.0
- AWS account and IAM user with **EC2, VPC** permissions
- AWS CLI configured (`aws configure`)
- An existing AWS Key Pair (for SSH access)

---

## ⚙️ Usage

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/aws-jenkins-ec2.git
cd aws-jenkins-ec2

2. Initialize Terraform

terraform init

3. Validate Terraform configuration

terraform validate

4. Apply Terraform Plan

terraform apply -auto-approve

🔑 Access Jenkins

    Get the public IP:

terraform output public_ip

    Open your browser:

http://<public_ip>:8080

    Unlock Jenkins:

ssh -i your-key.pem ec2-user@<public_ip>
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

Copy this password into the Jenkins setup page.
📌 Outputs

    Instance ID

    Public IP

    Jenkins URL → http://<public_ip>:8080

🧹 Cleanup

To destroy the infrastructure:

terraform destroy -auto-approve

📖 Notes

    Security group allows ports 22 (SSH) and 8080 (Jenkins).

    By default, EC2 is created in us-east-1a availability zone.

    Jenkins will be running as a service (systemctl status jenkins).

✅ With this setup, you’ll have a fully automated Jenkins server on AWS EC2 provisioned using Terraform.


