# 🏗️ Terraform Blocks: The Building Units

In Terraform, **blocks** are the fundamental building units used to describe **Infrastructure as Code (IaC)**. Each block has a specific purpose, syntax, and scope within your configuration files.

---

## 🚀 Quick Reference Guide

| Block Type | Primary Purpose | Scope |
| :--- | :--- | :--- |
| `terraform` | Configure Terraform settings & backend | Global |
| `provider` | Define cloud/service platform (AWS, Azure, etc.) | Global/Project |
| `resource` | Create and manage infrastructure components | Resource-specific |
| `variable` | Define input values for dynamic config | Input |
| `output` | Export values for use or display | Output |
| `locals` | Define internal temporary variables | Local |
| `data` | Fetch information from external sources | Read-only |
| `module` | Group resources for reusability | Reusability |

---

## 🛠️ Detailed Block Breakdown

### 1️⃣ `terraform` Block
This block is used to configure Terraform itself, including the version, providers, and where the state file is stored.

> [!NOTE]
> This is usually placed in a `versions.tf` or `main.tf` file.

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "tf-state-bucket"
    key    = "dev/terraform.tfstate"
    region = "us-west-2"
  }
}
```

---

### 2️⃣ `provider` Block
Defines **which cloud or service** Terraform will interact with. A single project can utilize multiple providers (e.g., AWS and Cloudflare).

```hcl
provider "aws" {
  region = "ap-south-1"
}
```

---

### 3️⃣ `resource` Block
The **heart of Terraform**. This block declares the specific infrastructure components you want to create and manage.

**Syntax:**
```hcl
resource "<PROVIDER>_<TYPE>" "<LOCAL_NAME>" { 
  # Configuration arguments
}
```

**Example:**
```hcl
resource "aws_instance" "web_server" {
  ami           = "ami-0abcdef"
  instance_type = "t2.micro"
  
  tags = {
    Name = "Primary-Web-Server"
  }
}
```

---

### 4️⃣ `variable` Block
Defines **Input Variables** that make your code flexible and reusable without hard-coding values.

```hcl
variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

# Usage:
# instance_type = var.instance_type
```

---

### 5️⃣ `output` Block
Used to display information on the terminal after `terraform apply` or to pass data between modules.

```hcl
output "instance_public_ip" {
  description = "The public IP of the web server"
  value       = aws_instance.web_server.public_ip
}
```

---

### 6️⃣ `locals` Block
Defines **local values** that can be reused within the same module. Think of them as internal temporary variables.

```hcl
locals {
  staging_env = "dev"
  app_name    = "web-app-${local.staging_env}"
}

# Usage:
# Name = local.app_name
```

---

### 7️⃣ `data` Block
Used to **query and fetch information** from an external source or existing infrastructure. It does not create anything.

```hcl
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}
```

---

### 8️⃣ `module` Block
Allows you to **containerize and reuse** groups of resources. This is key to building scalable, DRY (Don't Repeat Yourself) infrastructure.

```hcl
module "vpc" {
  source = "./modules/network"
  cidr   = "10.0.0.0/16"
  env    = "production"
}
```

---

### 🛡️ Special: `lifecycle` Block
Nested *inside* a resource block, it controls how Terraform handles resource changes.

| Argument | Description |
| :--- | :--- |
| `create_before_destroy` | Create new resource before deleting the old one |
| `prevent_destroy` | Error out if an attempt is made to delete this resource |
| `ignore_changes` | Ignore manual changes to specific attributes |

```hcl
resource "aws_instance" "protected_server" {
  ami = "ami-xyz"

  lifecycle {
    prevent_destroy = true
  }
}
```

---

## 🎯 Summary
Mastering these blocks is the first step toward becoming a Cloud Infrastructure expert. 

**Keep Building! 🚀**