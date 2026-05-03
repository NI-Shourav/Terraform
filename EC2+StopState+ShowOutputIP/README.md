# 🛑 AWS EC2: Provision, Stop, and Export IP with Terraform (Single File)

Welcome to this hands-on lab! You will learn how to use Terraform to automate the provisioning of an AWS EC2 instance, manage its lifecycle state (stopping it immediately), and extract its public IP address using outputs.

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
*   **Region**: `us-west-2`
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
cd Terraform/EC2+StopState+ShowOutputIP

# 2. Initialize the project
terraform init

# 3. Preview the plan
terraform plan

# 4. Deploy changes
terraform apply
```
Type `yes` when prompted.

### 📊 Deployment Logic
1.  **Provision**: Terraform creates an EC2 instance (`My-Auto-VM`).
2.  **Lifecycle**: The `aws_ec2_instance_state` resource immediately **stops** the instance to prevent running costs.
3.  **Output**: The terminal will display the **Public IP** address of the created instance.

---

## 🛑 Step 8: Clean Up
To avoid any AWS charges, always destroy your lab resources:
```bash
terraform destroy
```
Type `yes` to confirm.

---

## ⚙️ Customization Guide
Modify `main.tf` to suit your preferences:

| Parameter | Current Value | Customization Note |
| :--- | :--- | :--- |
| **`ami`** | `"ami-03f65b86...` | The OS image ID. Must be valid for your chosen `region`. |
| **`instance_type`** | `"t3.micro"` | Instance size. Use `t2.micro` for Free Tier if `t3` isn't available. |
| **`key_name`** | `"terra-pc-key"` | Must match a Key Pair created in Step 6. |
| **`Name` (Tag)** | `"My-Auto-VM"` | Label for your instance in the AWS Console. |
| **`state`** | `"stopped"` | Use `"running"` to keep the instance active after creation. |

---

## 🔍 How to Find the AMI ID
AMI IDs are **Region-specific**. If you change regions, you must find a new AMI ID:

1.  Go to **EC2** → **AMI Catalog**.
2.  Select an OS (e.g., **Ubuntu 24.04**).
3.  Copy the **AMI ID** (e.g., `ami-0abcdef1234567890`).
4.  Update the `ami` value in your `main.tf`.

---
**Happy Automating! 🚀**
