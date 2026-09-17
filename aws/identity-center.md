# AWS IAM Identity Center

This portion of the lab demonstrates centralized AWS access management using IAM Identity Center.

## Groups

- AWS-Developers
- AWS-ReadOnly-Users

## Permission Sets

### AWS-Developer
Assigned to the AWS-Developers group.

Provides approved developer access to:
- Amazon EC2
- Amazon S3
- Amazon ECR

AdministratorAccess was intentionally not used in order to demonstrate least privilege.

### AWS-ReadOnly
Assigned to the AWS-ReadOnly-Users group.

Uses the AWS managed ReadOnlyAccess policy to provide view-only access to AWS services and resources.

## Access Model

```text
AWS Identity Center User
        ↓
Identity Center Group
        ↓
Permission Set
        ↓
AWS Account