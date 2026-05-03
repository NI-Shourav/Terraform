# 🛡️ AWS EC2: Provision with Security Group (Single File)

This lab demonstrates how to provision an AWS EC2 instance and attach a custom Security Group to allow SSH access, all within a single Terraform configuration file.

---

## 🏗️ Step 1: Create an AWS EC2 Instance (Control Node)
First, you need a Linux machine (Control Node) where you will install Terraform and manage your infrastructure.

1.  Go to the **EC2 Dashboard** → **Launch instance**.
2.  **Name**: `Terraform-Control-Node`.
3.  **OS**: **Ubuntu 24.04 (Noble)** or **Ubuntu 22.04 (Jammy)**.
4.  **Instance Type**: `t2.micro` (Free Tier eligible).
5.  **Key Pair**: Create or select an existing key pair to SSH into this machine.
6.  **Network**: Ensure **Auto-assign public IP** is **Enabled**.
7.  **Launch Instance** and connect to it via SSH.

---

## 🔐 Step 2: IAM User Setup (One-Time)
Terraform needs programmatic access to your AWS account.

1.  Log in to the **AWS Management Console**.
2.  Search for **IAM** → **Users** → **Create user**.
3.  **Username**: `terraform-user`.
4.  **Permissions**: Select **Attach policies directly**.
5.  **Policy**: Attach `AmazonEC2FullAccess`.
6.  **Security Credentials**: Go to the user's **Security credentials** tab → **Access keys** → **Create access key**.
7.  Select **Command Line Interface (CLI)** and download the `.csv` file.

> [!CAUTION]
> **Secure your Secret Key!** This is the only time you can download it. Keep it private.

---

## 🛠️ Step 3: Install AWS CLI
The AWS CLI acts as the bridge between your machine and AWS.

### 🐧 For Linux (Ubuntu/Debian)
```bash
# 1. Update system and install unzip
sudo apt update && sudo apt install unzip -y

# 2. Download and install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

**Verify:** `aws --version`

---

## ⚙️ Step 4: Configure AWS Credentials
Connect your Control Node to your AWS account:

```bash
aws configure
```
*   **Access Key ID**: [Paste from CSV]
*   **Secret Access Key**: [Paste from CSV]
*   **Region**: `us-west-2` (Must match the region in `main.tf`)
*   **Default output format**: `json`

---

## 🧱 Step 5: Install Terraform
Execute these commands to add the official HashiCorp repository and install Terraform:

```bash
# 1. Add HashiCorp GPG key
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

# 2. Add HashiCorp Repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

# 3. Update & Install
sudo apt update && sudo apt install terraform -y
```

> [!NOTE]
> **About `UBUNTU_CODENAME`:**
> The command above dynamically detects your OS version (e.g., `noble` for 24.04). 
> **Manual Check:** Run `lsb_release -cs`. If the auto-detection fails, manually replace the `$(...)` part with your codename.

---

## 🔑 Step 6: Create AWS Key Pair
This key pair is required by the EC2 instance defined in the Terraform code.

1.  Navigate to **EC2** → **Network & Security** → **Key Pairs**.
2.  Click **Create key pair**.
3.  **Name**: `terra-pc-key` (**Crucial**: This must match the `key_name` in `main.tf`).
4.  **Format**: `.pem`.
5.  **Download** and save it.

---

## 🚀 Step 7: Clone and Run
Now, bring the code to your machine and deploy.

```bash
# 1. Clone the repository
git clone https://github.com/NI-Shourav/Terraform.git
cd Terraform/EC2+INBOUNDRULEADD+ShouOutputIP

# 2. Initialize the project
terraform init

# 3. Preview the plan
terraform plan

# 4. Deploy changes
terraform apply
```
Type `yes` when prompted.

### 📊 Deployment Logic
1.  **Network**: Terraform identifies the **Default VPC**.
2.  **Security**: Creates a Security Group (`nur-sg`) with **Port 22 (SSH)** open.
3.  **Provision**: Creates an EC2 instance and attaches the Security Group to it.
4.  **Output**: Displays the **Public IP** address for SSH access.

---

## 🛑 Step 8: Clean Up
To avoid any AWS charges, always destroy your lab resources:
```bash
terraform destroy
```
Type `yes` to confirm.

---

## ⚙️ Customization Guide
Modify the values in `main.tf` to suit your preferences:

| Parameter | Current Value | Customization Note |
| :--- | :--- | :--- |
| **`region`** | `"us-west-2"` | Change at the top of `main.tf`. |
| **`ami`** | `"ami-0d76b90...` | The OS image ID. Must be valid for your region. |
| **`instance_type`** | `"t3.micro"` | Instance size. (e.g., `t2.micro`). |
| **`key_name`** | `"terra-pc-key"` | Must match a Key Pair created in Step 6. |
| **`name` (SG)** | `"nur-sg"` | The name of your Security Group. |
| **`from_port`** | `22` | The starting port for access (22 is for SSH). |

---

## 🔍 How to Find the AMI ID
AMI IDs are **Region-specific**. If you change regions, you must find a new AMI ID:

1.  Go to **EC2** → **AMI Catalog**.
2.  Select an OS (e.g., **Ubuntu 24.04**).
3.  Copy the **AMI ID** (e.g., `ami-0abcdef1234567890`).
4.  Update the `ami` value in your `main.tf`.

---
**Happy Automating! 🚀**
