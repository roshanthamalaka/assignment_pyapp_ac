## Terraform Scripts used provision the infrastructure on the Azure Cloud 

This Folder Contains terraform codes used to provision the Kubernetes Cluster and the Virtual Machine to install a promethus server.

Below is folder structure 
<pre> ```text . ├── aks_cluster.tf # This file contains the AKS Cluster creation ├── backend.tf # This contains the remote backend configuration ├── datasources.tf # Terraform datasources ├── provider.tf # Provider ├── resource_group.tf # Resource group to hold the infrastructure ├── variables.tf # Specify variables used in the setup ├── vm_prometheus.tf # Provisions a VM to install Prometheus with security group and public IP └── vnet.tf # Virtual network for Prometheus VM ``` </pre>

As the remote backed use Azure Blob Storage. This was created manually. Better approach is to use Terraform Bootstrap which haven't been done in this project

This will create AKS Cluster, Virtual Machine with Public IP address which has open ports on 9090 and 22. 
Port 22 for SSH. Port 9090 for Prometheus 

When Proivsioning the Virtual Machine Key based Authentication is configured with my Public Key. So that SSH can be done from the machine when it provisioned


