# 🪣 Hands-on Lab: Provisioning AWS S3 with Terraform

Welcome to the Terraform S3 lab! In this guide, you will learn how to automate the creation of an S3 bucket on AWS and manage its configurations using code.

---

## 🏗️ Step 1: Create an EC2 machine first.


## 🔐 Step 2: IAM User Setup (One-Time)
Terraform needs permissions to manage S3 buckets.

1. Navigate to **IAM** → **Users** → **Create user**.
2. **Username**: `terraform-user`.
3. **Permissions**: Select **Attach policies directly**.
4. **Policy**: Attach `AmazonS3FullAccess`.
5. **Security Credentials**: Create **Access Keys** for the CLI.

> [!CAUTION]
> **Secure your keys!** Download the CSV file immediately. You won’t get a second chance to see the Secret Key.

---

## 🛠️ Step 3: Install AWS CLI
If not already installed, follow your OS instructions:

### For Linux
```bash
# 1. Update system and install unzip
sudo apt update && sudo apt install unzip -y

# 2. Download the AWS CLI v2 installer
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# 3. Extract and run the installer
unzip awscliv2.zip
sudo ./aws/install
```

**Verify:**
```bash
aws --version
```

---

## ⚙️ Step 4: Configure AWS Credentials
Connect your machine to AWS:

```bash
aws configure
```
*   **Access Key ID**: `YOUR_ACCESS_KEY`
*   **Secret Access Key**: `YOUR_SECRET_KEY`
*   **Region**: `us-west-2` (or your preferred region)

---

## 🧱 Step 5: Install Terraform
If you need to install or update Terraform, you can find the commands for your specific OS on the [official HashiCorp page](https://developer.hashicorp.com/terraform/install).

### 🐧 Linux (Ubuntu/Debian)
```bash
# Add HashiCorp GPG key
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp Repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update & Install
sudo apt update && sudo apt install terraform
```

---

## 📂 Step 6: Clone the Repository
Now, bring the Terraform code to your local machine:

```bash
# 1. Clone the repository
git clone https://github.com/NI-Shourav/Terraform.git

# 2. Navigate to the project folder
cd Terraform/tf-s3-lab
```

---

## 🚀 Step 7: Initialize the Project
Prepare your working directory:

```bash
terraform init
```
> [!NOTE]
> This command installs the AWS provider plugin required to interact with S3.

---

## 🔍 Step 8: Validate Configuration
Always check for syntax errors before deploying:

```bash
terraform validate
```
**Expected Output:** `Success! The configuration is valid.`

---

## 📝 Step 9: Preview the Plan
See exactly what will happen:

```bash
terraform plan
```
**Look for:** `Plan: 3 to add, 0 to change, 0 to destroy.`
*(Note: It adds 3 resources because it typically includes the bucket, versioning, and public access blocks).*

---

## ⚡ Step 10: Apply & Create
Deploy the bucket to AWS:

```bash
terraform apply
```
When prompted, type **`yes`** and press Enter.

### 🎉 Success!
You should see:
`Apply complete! Resources: 3 added, 0 changed, 0 destroyed.`

---

## 🖥️ Step 11: Verify in AWS Console
1. Go to the **S3 Console**.
2. Search for the bucket name: **`nur-terraform-s3-bucket-25`**.
3. Check the properties to see your configurations in action.

---

## 🛑 Step 12: Clean Up (IMPORTANT)
To avoid costs, always destroy your lab resources:

```bash
terraform destroy
```
Type **`yes`** to confirm.

---

## 🎯 Lab Complete!
You've successfully mastered S3 provisioning with Terraform.

**Keep Building! 🚀**