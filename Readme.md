## Overview of the Project

This Repository Contains all the codes related Python Web Application it is deployment components. In the repository it has several sub folders. Purpose of those sub folders are shown in the below table

| Folder Name                             | Purpose                                                                                                                    |
|----------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| Ansible_playbooks_promethus_configuration | This folder contains the playbook used to install and configure Prometheus on a Linux virtual machine (Ubuntu assumed)    |
| Infrastrucuture                         | This folder contains Terraform scripts used to provision resources on Azure Cloud                                          |
| K8Manifests                             | This folder contains the Kubernetes manifests to deploy deployments and services                                            |
| static and templates                    | This folder contains static content (e.g., images) and templates (e.g., HTML) used by the Python web application           |

Ansible Playbooks,Infrastructure and K8Manifests has its own Readme.md file describing about its configuration. 

## Description about the application 

In the repository there is a python web application named as app.py.

To create this App Flask Framework has been used. There are two popular frameworks for developing python WebApps which are Django and Flask. Since Flask is light weight Flask has been chosen to develop the application.

Refer below documentation understand how to create Python Web Application 
https://medium.com/@dattu1993/creating-a-web-application-with-python-a-comprehensive-guide-for-beginners-db59df5867e4 

To Understand Flaks its sub functions refer to flask documentation 
https://flask.palletsprojects.com/en/stable/quickstart/ 

When flaks application is created by default it runs on port 5000 with accessible on localhost.

To use custom port and listen on all address (0.0.0.0) added below code block  as per below documentation
if __name__ == "__main__":
    app.run('0.0.0.0', 8181)
https://learn.microsoft.com/en-us/visualstudio/ide/quickstart-python?view=vs-2022 

By adding this applications was exposed on custom port and able to run without flaks. (Issue python3)