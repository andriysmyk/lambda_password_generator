# 🔐 AWS Lambda Password Generator - DevOps Project

This project demonstrates how to deploy an AWS Lambda function using **Terraform** and automate the process with **GitHub Actions**. It's a simple and effective showcase of **Infrastructure as Code (IaC)**, **CI/CD pipelines**, and practical **AWS Cloud** skills.

---

## 📌 Features

- **Lambda Function**: Python script that generates a random password.
- **Terraform**: Infrastructure code to create:
  - Lambda function
  - IAM role and policy for logging to CloudWatch
  - Two S3 buckets (for Terraform backend and Lambda source code)
- **S3 Buckets**:
  - `terraform-state-asmyk` — stores `terraform.tfstate`
  - `lambda-code-asmyk` — stores the Lambda zip package
- **GitHub Actions**:
  - Automatically runs `terraform plan` on pull request
  - Runs `terraform apply` when merged to `main`
  - Optional manual `terraform destroy` via `workflow_dispatch`

---

## 🧰 Tech Stack

| Tool             | Purpose                                 |
|------------------|------------------------------------------|
| **Python**       | Lambda password generator                |
| **AWS Lambda**   | Stateless function execution             |
| **Terraform**    | IaC for provisioning AWS resources       |
| **GitHub Actions** | CI/CD for deploy, plan, and destroy     |
| **S3**           | Remote state + function code storage     |
| **IAM**          | Roles and policies for Lambda execution  |

---

## 📁 Project Structure

```
.
├── lambda_function.py         # Python script generating passwords
├── lambda.zip                 # Zipped Lambda source code
├── main.tf                    # Terraform config for Lambda, IAM, S3
├── variables.tf               # Terraform variables
├── .github/workflows/
│   └── deploy-lambda.yaml     # GitHub Actions workflow
├── README.md                  # Project documentation
└── ...                        # Other config and project files
```

---

## 🚀 How to Deploy

### 1. Prepare Lambda Function

Package your Lambda code:

```bash
zip lambda.zip lambda_function.py
```

Upload it to the designated S3 bucket (e.g., `lambda-code-asmyk`).

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Validate and Plan

```bash
terraform validate
terraform plan
```

### 4. Apply Infrastructure

```bash
terraform apply -auto-approve
```

### 5. (Optional) Destroy Infrastructure

```bash
terraform destroy -auto-approve
```

---

## ⚙️ GitHub Actions CI/CD

This project includes a fully automated deployment pipeline using GitHub Actions.

### Triggers:

- **Pull Request to `main`**  
  → Runs `terraform plan`

- **Merge or Push to `main`**  
  → Runs `terraform apply`

- **Manual trigger (`workflow_dispatch`)**  
  → Runs `terraform destroy` if selected

### Required GitHub Secrets:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

---

## 🧲 Lambda Response Example

```json
{
  "statusCode": 200,
  "your_password": "A$7qz!d8L@"
}
```

---

## 🔒 Security

- IAM roles restrict permissions to only necessary services (CloudWatch).
- Passwords are generated in-memory and not stored or logged.
- Sensitive credentials are stored as GitHub Secrets.

---

## 💡 Future Improvements

- Accept password length as an input via `event`
- Add API Gateway for public access
- Add monitoring with CloudWatch metrics and alarms
- Use AWS Secrets Manager for enhanced security

---

## 👨‍💻 Author

**Andriy Smyk** – Junior DevOps Engineer based in London 🇬🇧  
🔗 [LinkedIn Profile](https://www.linkedin.com/in/andriy-smyk-b5446311b)

This project reflects the practical skills I’ve recently acquired in **AWS Cloud**, **Terraform**, **Python**, and **GitHub Actions**, and how they can be applied in a production-like scenario.

---

## 📄 License

This project is licensed under the MIT License.


Just add some text to trigger the CI/CD pipeline.