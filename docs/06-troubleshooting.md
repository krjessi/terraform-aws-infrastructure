# Troubleshooting

This section documents common issues encountered during the project setup along with their resolutions.

| Issue                                                       | Resolution                                                                                                                                                                                                              |
| ----------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **`terraform: command not found`**                          | Restarted Visual Studio Code (or opened a new terminal) so the updated `PATH` environment variable was reloaded. Verified the installation by running `terraform version`.                                              |
| **Winget installer hash mismatch for Microsoft OpenJDK 21** | Installed an alternative JDK distribution (such as Eclipse Temurin or Amazon Corretto) or downloaded the official installer directly from the vendor's website. Verified the installation using `java --version`.       |
| **AWS CLI configuration**                                   | Verified the AWS CLI configuration by running `aws sts get-caller-identity`. A successful response confirmed that the configured IAM credentials were valid and the CLI was authenticated with the correct AWS account. |

## Verification Commands

```bash
terraform version

java --version

aws sts get-caller-identity
```

## Best Practices

* Restart your terminal or IDE after installing Terraform or Java to ensure the updated `PATH` is loaded.
* Always verify installations immediately after setup.
* Use an IAM user with programmatic access instead of the AWS root account.
* Confirm your AWS identity before running any Terraform commands that interact with AWS resources.
