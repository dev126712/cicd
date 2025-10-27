
# CI/CD
## Representation of a CIDC infrastructure & setup for smaller Aplication:




|  Infrastructure:  | AWS |
| ------------- | ------------- |
| Costum VPC  | Isolate The Network From The Outside World |
| 2 Public Subnets | Bastion Host/NAT Gateway |
| 1 Private Subnet | Jenkins Server, Sonarqube, Nexus Repository, Postgesql |
| S3 Bucket | For Storing Container Volumes Data For Backup & Disaster Recovery |
| Gateway Endpoint | For Accessing s3 Bucket Internally |
| NAT Endpoint | To Allows Resources In The Private Subnet To Connect To The Internet Securly |



![alt text](https://github.com/dev126712/cicd/blob/2d79805398c75877537e3484ff48f43334716e04/cicd.png)
