## Terraform Scripts used provision the infrastructure on the Azure Cloud 

This Folder Contains terraform codes used to provision the Kubernetes Cluster and the Virtual Machine to install a promethus server.

Below is file structure with it purpose 
| File            | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| `aks_cluster.tf`       | Contains the AKS Cluster creation logic                                     |
| `backend.tf`           | Remote backend configuration for Terraform                                  |
| `datasources.tf`       | Terraform data sources definition                                           |
| `provider.tf`          | Terraform provider configuration                                            |
| `resource_group.tf`    | Defines the Azure Resource Group for infrastructure                         |
| `variables.tf`         | Contains the variable definitions used in the setup                         |
| `vm_prometheus.tf`     | Provisions Prometheus VM, security group, and public IP                     |
| `vnet.tf`              | Creates the virtual network for the Prometheus VM                           |


As the remote backed, used Azure Blob Storage. This was created manually. Better approach is to use Terraform Bootstrap to create the backed as well which haven't been done in this project

This will create AKS Cluster, Virtual Machine with Public IP address which has open ports on 9090 and 22. 
Port 22 for SSH. Port 9090 for Prometheus 

When Proivsioning the Virtual Machine Key based Authentication is configured with my Public Key. So that SSH can be done from the machine when it provisioned


