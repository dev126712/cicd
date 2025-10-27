
# CI/CD Representation of a CIDC infrastructure & setup for smaller Aplication:
## Infrastructure Deployment: Terraform (Infrastructure as Code)
### The entire AWS infrastructure is deployed using Terraform (IaC) tool. It define all resources (VPC, subnets, EC2 instance, endpoints) in configuration files, we ensure the infrastructure is version-controlled, auditable, and reproducible.
### Key Feature: The entire environment can be deployed with a single command ```terraform apply --auto-approve``` or destroyed using ```terraform destroy --auto-approve```  guaranteeing consistency and significantly reducing manual configuration errors. Enables rapid environment provisioning (e.g., creating a separate staging environment) and easy rollback capabilities.

|  Infrastructure:  | AWS |
| ------------- | ------------- |
| Costum VPC  | Isolate The Network From The Outside World |
| 2 Public Subnets | Bastion Host && NAT Gateway |
| 1 Private Subnet | Jenkins Server, Sonarqube, Nexus Repository, Postgesql |
| S3 Bucket | For Storing Container Volumes Data For Backup & Disaster Recovery |
| Gateway Endpoint | For Accessing s3 Bucket Internally |
| NAT Endpoint | To Allows Resources In The Private Subnet To Connect To The Internet Securly |

|  CI/CD Technology Stack:  | Services |
| ------------- | ------------- |
| Jenkins  | Central Automation Engine Of The CI/CD Pipeline. |
| SonarQube | Static Code Analysis Platform |
| Nexus Repository Manager | Central Repository |
| PostgreSQL | Relational Database To Persist |



| CI/CD Deployment:  | Docker Compose |
| ------------- | ------------- |
| Unified Service Definition  | One Single ```docker-compose.yml ``` File Defines The Entire Application Stack |
| Service Orchestration and Networking | Docker Compose Manages The Lifecycle and Internal Communication Between The Services |
|  State Management and Persistence | Compose Is Used To Define And Map Persistent Docker Volumes |



![alt text](https://github.com/dev126712/cicd/blob/2d79805398c75877537e3484ff48f43334716e04/cicd.png)
