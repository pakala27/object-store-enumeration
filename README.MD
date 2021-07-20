Object storage Enumeration Tool deployment in Minkube

Follow below steps to achieve following:
   - Create object store (S3 Bucket) and upload conent using Terraform
   - Build a program/tool to enumarate the object store
   - Host the program/tool inside Docker image
   - Deploy the Docker image inside Container Platform (Minikube)

1. Create object store (S3 Bucket) and upload conent using Terraform 

Follow below link to install terraform CLI 
https://learn.hashicorp.com/tutorials/terraform/install-cli

Follow below link to install AWS CLI V2
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-mac.html

Configure AWS CLI
#aws configure --profile <profile name>
AWS Access Key ID [None]: <secret>
AWS Secret Access Key [None]: <secret>
Default region name [None]: <region>
Default output format [None]: <output format>
Create a directry to host the terraform config file
#mkdir terraform; cd terraform

Initiate the terraform
#terraform init

Create terraform conf file to host the logic for creating S3 bucket and upload content

refer terraform/s3BucketCreation.tf 

Plan and apply the config to the provider
#terraform plan
#terraform apply

Login to AWS web console and verify the s3 bucket or use AWS CLI for checking

aws s3 ls s3://<s3 bucket name> --recursive --profile <profile name>

Desclaimer : 
I mentioned AWS secrets in terraform.tf file without encryption but it is not a standard practice. We should use terraform vault or SOPS for encrypting secrets

2. Build a program/tool to enumarate the object store

I created a bash script for simplicity and it does the work.
Refer docker/include/etc/listObjectStore.sh for more information

this script has 3 functions.
  env_check()
    To check the necessary env were given or not. If not found it exit the script.
  configure_awscli()
    This function configure the AWS CLI using environment variables
  enumerate_objectstore()
    this fuction does the actual job to enumerate the object store

Desclaimer : 
We can use any other language to build this tool/program but I chose bash for simplicity.
There is also a room for improve the script to deal with failure scenarios

3. Host the program/tool inside Docker image

Please refer docker/Dockerfile for more information
Install docker cli to build the image and test the tool/program

#docker build . -t pakala27/awscli:v1

Push the image to the container registry this is optional for this step but essentail for the next step when you want to run the image in container platform (Minikube)

#docker push pakala27/awscli:v1

Run the container using the newly built container image

#docker run  -e DEFAULT_REGION='region' \
            -e AWS_ACCESS_KEY_ID='secret' \
            -e AWS_SECRET_ACCESS_KEY='secret' \
            -e DEFAULT_OUTPUT='output format' \
            pakala27/awscli:v1

Desclaimer :
 Container registry : I used hub.docker.io and logged into it before pushing the image. You can use any other container registry like nexus etc.
 Container Runtime : I use docker runtime but you can use podman etc.

4. Deploy the Docker image inside Container Platform (Minikube)

Installing minikube is simple and easy with just few steps. I followed below link installation.

https://minikube.sigs.k8s.io/docs/start/

Create secret and deployment files and deploy them in minikube

Please refer minikube/secret.yaml and minikube/deployment.yaml for more information.

#kubectl create -f minikube/secret.yaml
#kubectl create -f minikube/deployment.yaml

Verify the pod log in minikube dashboard.

Desclaimer :
  I have not automated the steps for installing minikube as these are few steps. Also, I concetrated on other steps more than building the container platform which takes time.

  

