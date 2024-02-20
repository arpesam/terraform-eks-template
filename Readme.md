# EKS-Terraform
This is a simple project to generate the whole insfrastructure to support an EKS cluster using terraform including a custom VPC and subnets.
The idea of this project is to serve as consultancy repo for future projects.
It was intended to work with all available providers, but now is only configured to work with the AWS.

## Pre-requisites
- Off course you need terraform installed on your machine. `brew install terraform`
- It is necessary to have kubectl on you machine in order to be able to play with the cli and access the eks on AWS. You can install it running `brew install kubectl`. Test if it is running using `kubectl --help`.
- You will need to install `aws-iam-authenticator` by runnin `brew install aws-iam-authenticator`. Aws will know that you have permission to acces the EKS because of this agent. Test if it is working running `aws-iam-authenticator --help`.

## Usage
First, make sure you have the `˜/.aws/credentials` configured and you have permissions to deploy a cluster. Run `terraform init` to initialize the Terraform. Then `terraform apply` to deploy the cluster alongside with the VPC anda ll insfrasctruture. \
After you apply and everything is deployed (expect this to take at least 15 minutes) you should see a `.kubeconfig` file created. Run `cp kubeconfig ~/.kube/config` to make the new cluster the default config for your cli. If the `~/.kube/config`, create it by running `mkdir ~/.kube/ && touch ~/.kube/config && cp kubeconfig ~/.kube/config`.

After everything ran successfully you can finally run `kubectl get nodes` to see if from local you are able to connect to your just created EKS cluster.

Create you first pod by running `kubectl create deploy  nginx --image=nginx`.

## Commands to play with the EKS
`kubectl get nodes` \
`kubectl get nodes` \
`kubectl create deploy  nginx --image=nginx` \
`kubectl get pods` \
`kubectl port-forward pod/{PODNAME} PORT:PORT`

## Useful commands
`terraform init` \
`terraform plan` \
`terraform apply` \
`terraform apply --auto-approve` \
`terraform destroy`