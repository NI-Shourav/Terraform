# 📖 Understanding the EC2 Lab Infrastructure

This guide explains how the different Terraform files in this directory work together to build your EC2 instance.

---

## 🗺️ How the Files Connect (The Restaurant Analogy)

Think of Terraform like a high-end restaurant. Here is how the files work together:

| File | Analogy | What it actually does |
| :--- | :--- | :--- |
| **`versions.tf`** | 🏗️ **The Building Code** | Ensures the kitchen (Terraform) has the right tools and safety standards. |
| **`variables.tf`** | 📋 **The Menu** | Lists the possible options a customer can choose (Instance type, Region, etc.). |
| **`terraform.tfvars`** | 📝 **The Order** | The specific choices the customer makes (I want a `t3.micro` in `us-west-2`). |
| **`main.tf`** | 👨‍🍳 **The Chef** | Takes the order and actually "cooks" the infrastructure on AWS. |
| **`outputs.tf`** | 🧾 **The Receipt** | Provides a summary of exactly what was delivered (IP Address, Instance ID). |

---

### 🔄 The Data Flow
1. **Inputs** (`tfvars`) ➔ 2. **Definition** (`variables`) ➔ 3. **Execution** (`main`) ➔ 4. **Results** (`outputs`)

---

## 📂 File-by-File Breakdown

### 1️⃣ `versions.tf`
**The Foundation.**
This file tells Terraform which version of the software to use and which cloud provider plugins (like AWS) are required. It ensures everyone running the code uses the same environment.

### 2️⃣ `variables.tf`
**The Inputs.**
Think of this as a list of blanks that need to be filled. It defines what parameters the project needs (like `region`, `instance_type`, and `key_name`) but doesn't necessarily set their final values.

### 3️⃣ `terraform.tfvars`
**The Answer Key.**
This file is where you provide the actual values for the variables defined in `variables.tf`. For example, this is where you specify that your `key_name` is `"my-ec2-key"`.

### 4️⃣ `main.tf`
**The Engine.**
This is where the magic happens. It uses the variables and instructions to:
*   **Search**: Find the latest Ubuntu image (using a `data` block).
*   **Organize**: Set naming rules (using `locals`).
*   **Build**: Create the actual EC2 server (`aws_instance`).

### 5️⃣ `outputs.tf`
**The Results.**
After Terraform finishes building your server, this file tells it to print useful information to your terminal, such as the **Public IP Address** and **Instance ID**.

---

## 🔄 The Execution Flow
1.  **`terraform init`**: Reads `versions.tf` to download the AWS provider.
2.  **`terraform plan`**: Combines `variables.tf`, `tfvars`, and `main.tf` to show you a preview.
3.  **`terraform apply`**: Executes the plan and then triggers `outputs.tf` to show you the results.

**Now you're ready to master Infrastructure as Code! 🚀**
