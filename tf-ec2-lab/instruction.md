# ☁️ Hands-on Lab: Provisioning AWS EC2 with Terraform (Separation of Concerns)

Welcome to the Terraform EC2 lab! In this guide, you will learn how to automate the creation of an EC2 instance on AWS directly from your local machine.

---

## 🏗️ Step 1: Create an EC2 machine first.

## 🔐 Step 2: IAM User Setup (One-Time)
You need an IAM user so Terraform can authenticate with AWS.

1. Navigate to **IAM** → **Users** → **Create user**.
2. **Username**: `terraform-user`.
3. **Permissions**: Select **Attach policies directly**.
4. **Policy**: Attach `AmazonEC2FullAccess` (use least privilege in production!).
5. **Security Credentials**: Create **Access Keys** and select **Command Line Interface (CLI)**.

> [!CAUTION]
> **Save your Secret Key immediately!** You will not be able to retrieve it once you leave the AWS console page.

---

## 🛠️ Step 3: Install AWS CLI
The AWS CLI allows you to configure your local environment.

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

**Verify Installation:**
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
If you haven't installed Terraform yet, you can find the commands for your specific OS on the [official HashiCorp page](https://developer.hashicorp.com/terraform/install).

### 🐧 Linux (Ubuntu/Debian)
```bash
# Add HashiCorp GPG key
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Add HashiCorp Repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# Update & Install
sudo apt update && sudo apt install terraform
```

> [!NOTE]
> **About `UBUNTU_CODENAME`:**
> The `$(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs)` section in the command above dynamically fetches your operating system's codename (e.g., `noble` for Ubuntu 24.04, `jammy` for Ubuntu 22.04, `focal` for Ubuntu 20.04, or `bullseye` for Debian 11). This codename must be placed exactly before `main` for the repository to work.
> 
> **How to find your codename:**
> You can manually find your OS codename by running `lsb_release -cs` or `cat /etc/os-release` in your terminal. If the automated command fails to auto-detect your version, you can manually replace that entire section with your actual OS codename (for example, `noble`).

**Verify Installation:**
```bash
terraform version
```

---

## 🔑 Step 6: Create AWS Key Pair
A Key Pair is required to securely SSH into your Linux instance. Follow these steps to create one:

1. Log in to the **AWS Management Console**.
2. Navigate to **EC2** → **Network & Security** → **Key Pairs**.
3. Click the **Create key pair** button.
4. **Name**: Enter `my-ec2-key` (this must match the name in your `.tfvars` file).
5. **Key pair type**: Select `RSA`.
6. **Private key file format**: Select `.pem`.
7. Click **Create key pair**.

> [!IMPORTANT]
> The `.pem` file will be downloaded automatically. Keep it safe! You will need it later to log in to your server.

---

## 📂 Step 7: Clone the Repository
Now, bring the Terraform code to your local machine:

```bash
# 1. Clone the repository
git clone https://github.com/NI-Shourav/Terraform.git

# 2. Navigate to the project folder
cd Terraform/tf-ec2-lab
```

---

## 🚀 Step 8: Initialize the Project
Navigate to your lab directory and run:

```bash
terraform init
```
> [!NOTE]
> This command downloads the necessary AWS providers and prepares your workspace.

---

## 🔍 Step 9: Validate Configuration
Check your code for syntax errors:

```bash
terraform validate
```
**Expected Output:** `Success! The configuration is valid.`

---

## 📝 Step 10: Preview Changes (The "Safe" Step)
See exactly what Terraform plans to build without making any changes:

```bash
terraform plan
```
Confirm that it shows **`1 to add, 0 to change, 0 to destroy`**.

---

## ⚡ Step 11: Apply & Deploy
Launch your infrastructure!

```bash
terraform apply
```
When prompted, type **`yes`** and hit Enter.

### 🎉 Success!
Upon completion, you should see:
`Apply complete! Resources: 1 added, 0 changed, 0 destroyed.`

---

## 🖥️ Step 12: Verify in AWS Console
1. Go to **EC2** → **Instances**.
2. Look for an instance named **`ec2-lab-dev`**.
3. Ensure the region is set to **`us-west-2`**.

---

## 🛑 Step 13: Clean Up (IMPORTANT)
To avoid unnecessary AWS charges, destroy the resources when you are finished:

```bash
terraform destroy
```
Type **`yes`** to confirm deletion.

---

## 🎯 Lab Complete!
Congratulations! You just successfully managed infrastructure using code.

**Keep Building! 🚀**