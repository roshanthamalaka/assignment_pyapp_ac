I have Create My Own Docker Hub Public Repository to hold my image
Docker Hub Repository to hold the image is roshanthamalaka/roshanassignemt_ac

Once the Image is available in the docker Hub create these mainifest files to  run it in the Kind Cluster as initial test.

Use Docker Hub login with PAT for authentication and Pulling the image 

Encountered Kind Cluster related issue because Kind does not expose Nodeport just like normal kubernetes cluster. 
To Test Temporarliy I have used port forwarding Like below 

sudo KUBECONFIG=$HOME/.kube/config kubectl port-forward svc/adcashs 80:80
 
Reason for that is Port 80 does not allowed to expose without root and to run kubectl with root access