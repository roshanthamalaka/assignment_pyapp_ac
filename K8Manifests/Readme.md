I have Create My Own Docker Hub Public Repository to hold my image
Docker Hub Repository to hold the image is roshanthamalaka/roshanassignemt_ac

Once the Image is available in the docker Hub create these mainifest files to  run it in the Kind Cluster as initial test.

Use Docker Hub login with PAT for authentication and Pulling the image 

Encountered Kind Cluster related issue because Kind does not expose Nodeport just like normal kubernetes cluster. 
To Test Temporarliy I have used port forwarding Like below 

sudo KUBECONFIG=$HOME/.kube/config kubectl port-forward svc/adcashs 80:80
 
Reason for that is Port 80 does not allowed to expose without root and to run kubectl with root access

__AKS Cluster Configuration__

Since AKS Cluster has a Default LoadBalancer. Therefore I use that Loadbalancer to expose the APplication as per below documentation
https://learn.microsoft.com/en-us/azure/aks/load-balancer-standard 

According Kubernete Docs if the Environemt Supports Cloud Load Balancer it provides External IP address. Refer below Docs 
https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/ 
Modified the Service from NodePort to LoadBalancer therefore 

After that IT has assigned external IP and Able to Access from static Public IP.

__App Deployment__

For the Deployment of the App use Deployments. Then Expose it through the Load Balancer service.

Deployment and service available in the app_deployment.yml file.
