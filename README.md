
# CI/CD Representation of a CIDC infrastructure & setup for smaller Aplication:
## Infrastructure Deployment: Terraform (Infrastructure as Code)
#### The entire AWS infrastructure is deployed using Terraform (IaC) tool. It define all resources (VPC, subnets, EC2 instance, endpoints) in configuration files, we ensure the infrastructure is version-controlled, auditable, and reproducible.
### Key Feature: The entire environment can be deployed with a single command ```terraform apply --auto-approve``` or destroyed using ```terraform destroy --auto-approve```  guaranteeing consistency and significantly reducing manual configuration errors. Enables rapid environment provisioning (e.g., creating a separate staging environment) and easy rollback capabilities.


## Infrastructure: AWS Network and Security
#### The network architecture is specifically designed to isolate and protect the CI/CD resources.

|  Component  |Functionality | Functionality |
| ------------- | ------------- | ------------- |
| Costum VPC  | Isolate The Network From The Outside World | Creates a secure, private cloud boundary. |
| Bastion Host | A single, hardened server in the public subnet. | Serves as a secure jump box for authorized personnel to access the private EC2 instance for maintenance or troubleshooting (SSH). |
| Private Subnet | Hosts all critical, stateful CI/CD services (Jenkins, SonarQube, Nexus, PostgreSQL). | Prevents unauthorized inbound connections from the public internet to core services. |
| NAT Gateway | Allows resources in the private subnet to connect to the Internet (e.g., pulling Docker images, fetching plugins, updating rules). | Allows outbound-only connectivity, maintaining private network integrity by preventing external parties from initiating connections. |

## CI/CD Technology Stack
#### This stack provides a complete, self-hosted software delivery pipeline.

|  Service  | Role | Key Feature |
| ------------- | ------------- | ------------- |
| Jenkins  | Central Automation Engine Of The CI/CD Pipeline. | Orchestrates the entire build/test/deploy lifecycle using Pipeline as Code. |
| SonarQube | Static Code Analysis Platform | Enforces Quality Gates to block vulnerable or low-quality code from being deployed. |
| Nexus Repository Manager | Central Repository for binaries and dependencies. | Acts as a secure, private cache (proxy) for dependencies and hosts finalized deployable Artifacts. |
| PostgreSQL | Relational Database To Persist Service State. | Provides transactional data integrity and durable storage for the configuration and metadata of all CI/CD tools. |



| CI/CD Deployment:  | Docker Compose |
| ------------- | ------------- |
| Unified Service Definition  | One Single ```docker-compose.yml ``` File Defines The Entire Application Stack |
| Service Orchestration and Networking | Docker Compose Manages The Lifecycle and Internal Communication Between The Services |
|  State Management and Persistence | Compose Is Used To Define And Map Persistent Docker Volumes |



![alt text](https://github.com/dev126712/cicd/blob/2d79805398c75877537e3484ff48f43334716e04/cicd.png)
