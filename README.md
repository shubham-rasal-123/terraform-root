# Terraform AWS Infrastructure Root Configuration

![Terraform](https://img.shields.io/badge/Terraform-v1.5+-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?style=for-the-badge&logo=amazonaws)
![Jenkins](https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?style=for-the-badge&logo=jenkins)
![License](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Active-success?style=for-the-badge)

A Terraform **root configuration repository** used to provision AWS infrastructure by integrating reusable Terraform modules.

This project manages AWS infrastructure deployment using:

- Terraform modules
- Environment-specific variable files
- Remote backend state management
- Jenkins CI/CD automation

---

## 📖 Overview

The **terraform-root** repository acts as the main Terraform orchestration layer.

This repository does not directly create every AWS resource. Instead, it consumes reusable Terraform modules and provides environment-based infrastructure deployment.

The project uses the following Terraform modules:

- `terraform-module-vpc`
- `terraform-module-subnet`
- `terraform-module-ec2`
- `terraform-module-s3`

---

## 🏗️ Infrastructure Architecture

```text
                    Terraform Root Repository

                              |
                              |
        ------------------------------------------------
        |              |              |                |
        ↓              ↓              ↓                ↓

 terraform-      terraform-     terraform-      terraform-
 module-vpc      module-        module-         module-s3
                 subnet         ec2


                              |
                              ↓

                       AWS Infrastructure
```

---

## ✨ Features

- ✅ Terraform root configuration
- ✅ Modular infrastructure approach
- ✅ AWS infrastructure automation
- ✅ Environment-based deployment
- ✅ Jenkins parameter-driven execution
- ✅ Remote Terraform backend
- ✅ Separate Terraform state per environment
- ✅ Reusable Terraform modules
- ✅ Infrastructure as Code (IaC)

---

## 📂 Repository Structure

```text
terraform-root/
│
├── main.tf                  # Calls Terraform modules
├── variables.tf             # Defines input variables
├── outputs.tf               # Defines Terraform outputs
├── backend.tf               # Configures remote backend
├── Jenkinsfile              # Jenkins pipeline configuration
│
├── envs/
│   │
│   ├── dev.tfvars           # Development environment variables
│   ├── uat.tfvars           # UAT environment variables
│   └── prod.tfvars          # Production environment variables
│
└── README.md                # Project documentation
```

---

## 📋 Requirements

| Tool | Version |
|------|---------|

| Terraform | >= 1.5.0 |
| AWS CLI | Latest |
| Jenkins | Latest |
| Git | Latest |

---

## 🔗 Terraform Modules Used

This root project consumes reusable Terraform modules.

| Module Repository | Purpose |
|-------------------|---------|

| `terraform-module-vpc` | Creates AWS VPC infrastructure |
| `terraform-module-subnet` | Creates public and private subnets |
| `terraform-module-ec2` | Creates EC2 instances |
| `terraform-module-s3` | Creates S3 buckets |

---

## 🚀 Usage

This project is designed to be executed from the Terraform root repository.

Terraform modules are called from the `main.tf` file.

Example:

```hcl
module "vpc" {
  cidr_block = var.vpc_cidr
  vpc_name   = var.project_name

  tags = var.tags
}
```

The actual infrastructure values are provided through environment-specific variable files.

---

## 🌍 Environment Configuration

Environment configurations are maintained inside the `envs` folder.

```text
envs/

├── dev.tfvars
├── uat.tfvars
└── prod.tfvars
```

Each environment contains its own:

- AWS region
- VPC CIDR
- Project name
- Bucket configuration
- Resource tags
- Subnet configuration
- EC2 instance configuration

---

## Example: dev.tfvars

```hcl
environment   = "dev"
project_name  = "my-terraform-project"
aws_region    = "ap-south-1"

vpc_cidr      = "10.0.0.0/16"

bucket_suffix = "assets-dev-20240102"

tags = {
  Owner      = "dev-team"
  CostCenter = "cc-dev-001"
  Terraform  = "true"
}
```

---

## 🔧 Jenkins Build Parameters

Infrastructure deployment is controlled through Jenkins build parameters.

| Parameter | Type | Description |
|-----------|------|-------------|

| `ENV` | Choice | Select environment (`dev`, `uat`, `prod`) |
| `ACTION` | Choice | Select Terraform operation (`plan`, `apply`, `destroy`) |
| `BRANCH` | String | Git branch to deploy |

---

## 🔄 Jenkins CI/CD Workflow

The Jenkins pipeline automates Terraform deployment using selected build parameters.

Workflow:

```text
Developer Starts Jenkins Build

              |
              ↓

Select Environment
(dev / uat / prod)

              |
              ↓

Select Action
(plan / apply / destroy)

              |
              ↓

Git Checkout

              |
              ↓

Terraform Init

              |
              ↓

Load envs/<environment>.tfvars

              |
              ↓

Terraform Execution

              |
              ↓

AWS Infrastructure
```

---

## 🔐 Backend Configuration

Terraform state is managed using a remote backend.

The `backend.tf` file configures remote state storage.

Example:

```hcl
terraform {
  backend "s3" {
    bucket = "terraform-state-bucket"
    region = "ap-south-1"
    key    = "terraform.tfstate"
  }
}
```

The Jenkins pipeline maintains separate state files based on environment:

```text
dev/terraform.tfstate

uat/terraform.tfstate

prod/terraform.tfstate
```

Benefits:

- Environment isolation
- Secure state management
- Team collaboration
- State consistency

---

## 📥 Input Variables

Input values are provided using environment-specific `.tfvars` files.

Examples:

| Variable | Description |
|----------|-------------|

| `environment` | Deployment environment |
| `project_name` | Project name |
| `aws_region` | AWS region |
| `vpc_cidr` | VPC CIDR block |
| `bucket_suffix` | S3 bucket naming suffix |
| `tags` | Resource tags |

---

## 📤 Outputs

Terraform outputs expose important infrastructure information.

| Output | Description |
|--------|-------------|

| `vpc_id` | Created VPC ID |
| `subnet_ids` | Created subnet IDs |
| `instance_ids` | Created EC2 instance IDs |
| `bucket_name` | Created S3 bucket name |

---

## 📁 File Description

| File | Description |
|------|-------------|

| **main.tf** | Calls reusable Terraform modules |
| **variables.tf** | Defines root module variables |
| **outputs.tf** | Defines infrastructure outputs |
| **backend.tf** | Configures Terraform remote state |
| **Jenkinsfile** | Automates Terraform deployment workflow |
| **dev.tfvars** | Development environment configuration |
| **uat.tfvars** | UAT environment configuration |
| **prod.tfvars** | Production environment configuration |

---

## 🔒 Best Practices

- Use reusable Terraform modules.
- Maintain separate environment configurations.
- Store Terraform state remotely.
- Never commit AWS credentials.
- Use Jenkins credentials management.
- Review infrastructure changes before deployment.
- Follow AWS security best practices.

---

## ☁️ Technologies Used

- Terraform
- AWS
- Jenkins
- GitHub
- AWS S3 Backend
- Infrastructure as Code (IaC)

---

## 🤝 Contributing

Contributions are welcome!

To contribute:

- Fork this repository
- Create a new branch
- Make your changes
- Submit a Pull Request

---

## 📄 License

This project is licensed under the **MIT License**.

---

## 👨‍💻 Author

- **Shubham Rasal**

- AWS Certified Solutions Architect – Associate
- DevOps Engineer
- Cloud & Infrastructure Automation Enthusiast

Connect with me:

- **GitHub:** [shubham-rasal-123](https://github.com/shubham-rasal-123)

---

## ⭐ Support

If you find this project useful, consider giving it a **⭐ Star** on GitHub.
