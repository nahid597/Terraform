# Terraform Project

This repository contains Terraform configurations for provisioning and managing infrastructure resources. The project is structured to follow best practices, including the use of modules for reusable components and a clear separation of concerns.

---

## Prerequisites

Before using this repository, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) (v1.0 or later)
- AWS CLI configured with appropriate credentials
- Access to an AWS account

---

## Usage

### 1. Initialize the Terraform Project
Run the following command to initialize the Terraform project and download the necessary providers:
```bash
terraform init

```


### 2.  Plan the Infrastructure
Run the following command to generate an execution plan to preview the changes Terraform will make:
```bash
terraform plan

```

### 3. Apply the Configuration
Run the following command to apply the Terraform configuration to provision the infrastructure:
```bash
terraform apply

```

### 4. Destroy the Infrastructure
Run the following command to tear down the infrastructure:
```bash
terraform destroy

```