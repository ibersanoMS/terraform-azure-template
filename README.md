# Getting Started with Terraform

Use this template to create a new repository with a Terraform scaffold and basic workflows.

This template has basic workflows and scripts needed for the workflows in the ```.github/ ``` folder and basic Terraform files in the ``` src/ ``` folder.

These are the workflows contained in this repository:
- ``` validate.yml ``` This workflow runs on a pull request to main. It formats and validates your Terraform and then commits the formatting changes back to your branch. 
- ``` build-and-deploy.yml ``` This workflow runs on a push to main. It handles setting up and/or creating remote storage and deploying the Terraform code.

The [Terraform code](/src/) included in this repository demonstrates basic file structure for a Terraform solution:
- ``` main.tf ``` This file contains either resource definitions or references to [Terraform modules](/src/infra/modules/) to deploy.  
- ``` providers.tf ``` This file contains the Terraform providers needed for the solution and the versions or features required for each. 
- ``` variables.tf ``` This file contains definitions for variables used in the Terraform deployment. 
- ``` outputs.tf ``` This file contains definitions for outputs from the Terraform deployment. 
- ``` variables.tfvars``` This file contains definitions in the format ```variable_name=example``` of variables to be used in the deployment. This file is for local deployments and should NOT be committed to a repository as it may contain passwords, credentials, or other sensitive information. 

## Credential Setup

You will need a service principal that is scoped to either the subscription level or resource group level. This repository uses OIDC authentication for [Azure login](https://github.com/Azure/login). This method requires Federated Credentials for GitHub to deploy resource to Azure on your behalf.

Follow the steps below to setup:
1. Navigate to your service principal in the Azure Portal
2. Click on Certificates and Secrets and then Federated Credentials
3. Click on Add credential and select *GitHub Actions deploying Azure resources*
4. Fill out your organization, repository, and entity type information.
5. If you only want users to deploy resources off the main branch, select *Branch* as the entity type and put *main* as the branch name.
6. If you only want users to deploy resources into a specific environment, select *Environment* as the entity type and put your environment name in the name field.
7. If you only want users to deploy resources during a pull request, select *Pull request* as the entity type. 
8. If you only want users to deploy resources off a GitHub tag, select *Tag* as the entity type. 

## GitHub Action Secrets Required

Create the following secrest in your GitHub repository:

1. Navigate to 'Settings' on the repository
2. Select 'Secrets' and 'Actions' link
3. Select 'New repository secret' and create a secret for the following:
- ``` AZURE_TENANT_ID  ``` 
- ``` AZURE_SUBSCRIPTION_ID ```
- ``` AZURE_CLIENT_ID ```
- ``` STATE_STORE_RGNAME  ``` Existing resource group or name of one to be created for your remote state storage account
- ``` STORAGE_ACCOUNT_NAME ``` Existing storage account or name of one to be created for your Terraform remote state to be stored
- ``` STATE_STORAGE_CONTAINER_NAME ``` Existing container name or name of one to be created for your Terraform remote state to be stored
- ``` STATE_STORE_FILENAME ``` Existing filename or new filename for your Terrform state file
- ``` DESTROY_TERRAFORM ``` True or False. Whether you want to destroy the Terraform architecture after it's been created through the workflow. 
- ``` LOCATION ``` Location where you want the Azure resources and Terraform state storage to be deployed. 
- ``` CREATE_STATE_STORE ``` True or False. Whether you want to create a new storage account for your remote state or if you have an existing one you'd like to use. 

## Development Process

- Create a feature/fix branch in your repository 
- When you create a pull request, it will trigger the validate workflow to check your Terraform syntax and format it. 
- Once the validate workflow has completed successfully, you can merge in your changes
- Once the changes are merged in, it will trigger the build and deploy workflow to test deploying the architecture. 