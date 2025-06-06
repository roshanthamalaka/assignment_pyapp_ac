## Terraform Scripts used provision the infrastructure on the Azure Cloud 

This Folder Contains terraform codes used to provision the Kubernetes Cluster and the Virtual Machine to install a promethus server.

Below is folder structure 
.
├── aks_cluster.tf   # This File Contains the AKS Cluster Creation
├── backend.tf       # This contains the remote backend configuration
├── datasources.tf   # Terraform Datasources 
├── provider.tf      # Provider
├── resource_group.tf  # Resource Group to hold the infrastructure 
├── variables.tf        # Specify Varibales used in the 
├── vm_prometheus.tf  # Terraform Script which provision the Virtual machine to install promethus Alone with Securtiy Group and Public IP
└── vnet.tf # Virtal Network for Promethus Virtual Machine 

As the remote backed use Azure Blob Storage. This was created manually. Better approach is to use Terraform Bootstrap which haven't been done in this project

This will create AKS Cluster, Virtual Machine with Public IP address which has open ports on 9090 and 22. 
Port 22 for SSH. Port 9090 for Prometheus 

When Proivsioning the Virtual Machine Key based Authentication is configured with my Public Key. So that SSH can be done


