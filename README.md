# CI/CD
## Representation of a CIDC infrastructure & setup for smallwe aplication:
### Infrastructure:
#### - Costum VPC
#### - 2 Public Subnets:
  ##### - Bastion Host
#####     - NAT Gateway
#### - 1 Private Subnet:
#####     - Jenkins Server, Sonarqube, Nexus Repository, Postgesql
#### - Gateway Endpoint
####  - S3 Bucket for storing and backup of Volumes 

| Costum VPC  | Second Header |
| ------------- | ------------- |
|  2 Public Subnets  | Content Cell  |


![alt text](https://github.com/dev126712/cicd/blob/2d79805398c75877537e3484ff48f43334716e04/cicd.png)
