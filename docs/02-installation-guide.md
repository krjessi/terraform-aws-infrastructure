# Installation Guide

This guide walks you through installing and verifying all the software required for the **Terraform AWS Infrastructure Automation** project.

---

# Prerequisites

Ensure the following software is installed on your system.

| Software | Required | Purpose |
|----------|----------|---------|
| Git | ✅ | Version Control |
| Terraform | ✅ | Infrastructure as Code |
| AWS CLI | ✅ | AWS Authentication |
| Docker | ✅ | Container Platform |
| Java 21+ | ✅ | Spring Boot Application |
| Visual Studio Code | ✅ | Development IDE |

---

# 1. Install Git

## Windows

Download Git from the official website:

https://git-scm.com/downloads

Run the installer and keep the default settings.

---

## Ubuntu

```bash
sudo apt update

sudo apt install git -y
```

---

## Verify Installation

```bash
git --version
```

Example output:

```text
git version 2.50.1
```

---

# 2. Install Terraform

## Windows

Download Terraform from:

https://developer.hashicorp.com/terraform/downloads

Steps:

1. Download the Windows AMD64 ZIP.
2. Extract the ZIP file.
3. Copy `terraform.exe` to a folder, for example:

```text
C:\Terraform
```

4. Add the folder to the Windows **PATH** environment variable.

Restart your terminal or VS Code after updating the PATH.

---

## Ubuntu

```bash
sudo apt update

sudo apt install -y wget gpg software-properties-common

wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo \
"deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com \
$(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

sudo apt install terraform -y
```

---

## Verify Installation

```bash
terraform version
```

Example output:

```text
Terraform v1.15.x
```

---

# 3. Install AWS CLI

## Windows

Download the AWS CLI MSI installer from:

https://aws.amazon.com/cli/

Run the installer and complete the installation.

---

## Ubuntu

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
-o "awscliv2.zip"

unzip awscliv2.zip

sudo ./aws/install
```

---

## Verify Installation

```bash
aws --version
```

Example output:

```text
aws-cli/2.x.x
```

---

# 4. Configure AWS CLI

Run:

```bash
aws configure
```

Provide:

```text
AWS Access Key ID
AWS Secret Access Key
Default Region: ap-south-1
Default Output Format: json
```

Verify:

```bash
aws sts get-caller-identity
```

Expected output:

```json
{
  "UserId": "AIDXXXXXXXXXXXX",
  "Account": "123456789012",
  "Arn": "arn:aws:iam::123456789012:user/terraform-user"
}
```

---

# 5. Install Docker

## Windows

Download Docker Desktop from:

https://www.docker.com/products/docker-desktop/

Steps:

1. Install Docker Desktop.
2. Enable WSL2 (recommended).
3. Restart the computer.
4. Start Docker Desktop.

---

## Ubuntu

```bash
sudo apt update

sudo apt install docker.io -y

sudo systemctl enable docker

sudo systemctl start docker
```

(Optional) Run Docker without `sudo`:

```bash
sudo usermod -aG docker $USER
```

Log out and log back in for the group change to take effect.

---

## Verify Installation

```bash
docker --version
```

Example output:

```text
Docker version 28.x.x
```

---

# 6. Install Java (JDK 21 or Later)

## Windows

Download a Java 21 distribution such as:

- Eclipse Temurin (Adoptium)
- Oracle JDK
- Microsoft OpenJDK

Run the installer and ensure the JDK `bin` directory is added to the **PATH**.

---

## Ubuntu

```bash
sudo apt update

sudo apt install openjdk-21-jdk -y
```

---

## Verify Installation

```bash
java --version
```

Example output:

```text
openjdk 21.x.x
```

---

# 7. Install Visual Studio Code

Download Visual Studio Code from:

https://code.visualstudio.com/

Install using the default settings.

---

# Recommended VS Code Extensions

| Extension | Purpose |
|-----------|---------|
| HashiCorp Terraform | Terraform syntax support |
| AWS Toolkit | AWS integration |
| Docker | Docker support |
| GitLens | Git history |
| Error Lens | Better error highlighting |
| YAML | YAML support |
| Markdown All in One | Markdown editing |
| Prettier | Code formatting |

---

# Verify All Installations

Run the following commands:

```bash
terraform version

aws --version

git --version

docker --version

java --version
```

Example output:

```text
Terraform v1.15.x

aws-cli/2.x.x

git version 2.x.x

Docker version 28.x.x

openjdk 21.x.x
```

---

# Troubleshooting

## `terraform: command not found`

### Cause

Terraform is not installed or its executable is not added to the system PATH.

### Solution

- Verify Terraform is installed.
- Add the Terraform installation directory to the PATH.
- Restart the terminal or Visual Studio Code.

---

## `aws: command not found`

### Cause

AWS CLI is not installed or not available in the PATH.

### Solution

- Install the AWS CLI.
- Restart the terminal.
- Verify using:

```bash
aws --version
```

---

## `docker: command not found`

### Cause

Docker is not installed or Docker Desktop is not running.

### Solution

- Install Docker Desktop.
- Start the Docker service.
- Restart the terminal.

---

## `java: command not found`

### Cause

Java is not installed or the JDK `bin` directory is not in the PATH.

### Solution

- Install JDK 21 or later.
- Configure the `JAVA_HOME` environment variable.
- Add `%JAVA_HOME%\bin` (Windows) or `$JAVA_HOME/bin` (Linux) to the PATH.

---

## `git: command not found`

### Cause

Git is not installed or not added to the PATH.

### Solution

- Install Git.
- Restart the terminal.
- Verify using:

```bash
git --version
```

---

# Installation Checklist

| Software | Installed | Verified |
|----------|:---------:|:--------:|
| Git | ☐ | ☐ |
| Terraform | ☐ | ☐ |
| AWS CLI | ☐ | ☐ |
| Docker | ☐ | ☐ |
| Java 21+ | ☐ | ☐ |
| Visual Studio Code | ☐ | ☐ |
| VS Code Extensions | ☐ | ☐ |

---