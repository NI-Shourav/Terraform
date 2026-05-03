# 📖 Understanding the S3 Lab Infrastructure (Separation of Concerns)

This guide explains how the different Terraform files in this directory work together to create and secure an S3 bucket.

---

## 🗺️ How the Files Connect (The Restaurant Analogy)

Think of Terraform like a high-end restaurant. Here is how the files work together:

| File | Analogy | What it actually does |
| :--- | :--- | :--- |
| **`versions.tf`** | 🏗️ **The Building Code** | Ensures the kitchen (Terraform) has the right tools and safety standards. |
| **`variables.tf`** | 📋 **The Menu** | Lists the possible options a customer can choose (Bucket name, Region, etc.). |
| **`terraform.tfvars`** | 📝 **The Order** | The specific choices the customer makes (I want a bucket named `my-unique-bucket`). |
| **`main.tf`** | 👨‍🍳 **The Chef** | Takes the order and actually "cooks" the infrastructure on AWS. |
| **`outputs.tf`** | 🧾 **The Receipt** | Provides a summary of exactly what was delivered (Bucket Name, ARN). |

---

### 🔄 The Data Flow
1. **Inputs** (`tfvars`) ➔ 2. **Definition** (`variables`) ➔ 3. **Execution** (`main`) ➔ 4. **Results** (`outputs`)

---

## 📂 File-by-File Breakdown

### 1️⃣ `versions.tf`
**The Foundation.**
Defines the required Terraform version (`>= 1.5.0`) and the AWS provider version. This ensures consistency across different environments.

### 2️⃣ `variables.tf`
**The Inputs.**
Declares the variables used in the project, such as `aws_region` and `bucket_name`. It acts as a blueprint for what data the configuration needs to run.

### 3️⃣ `terraform.tfvars`
**The Answer Key.**
This is where you provide the actual values for the variables. Since S3 bucket names must be **globally unique**, you'll edit this file to give your bucket a custom name.

### 4️⃣ `main.tf`
**The Engine.**
The primary configuration file where resources are defined. It performs three main tasks:
1.  **Creates the Bucket**: Uses `aws_s3_bucket`.
2.  **Enables Versioning**: Tracks changes to files inside the bucket.
3.  **Sets Encryption**: Ensures data is encrypted at rest using AES256.

### 5️⃣ `outputs.tf`
**The Results.**
After the bucket is created, this file displays the **Bucket Name** and **ARN** (Amazon Resource Name) in your terminal for easy reference.

---

## 🔄 The Execution Flow
1.  **`terraform init`**: Prepares the workspace and downloads the S3-capable AWS provider.
2.  **`terraform plan`**: Shows you the 3 resources (Bucket, Versioning, Encryption) that will be created.
3.  **`terraform apply`**: Builds the infrastructure and prints the outputs.

**You've now automated a secure cloud storage solution! 🚀**
