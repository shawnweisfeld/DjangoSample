# Automating Deployment of a Django Python Application to Azure App Service Web Site from VisualStudio.com

## General Informational Links
Config Python
 - https://docs.microsoft.com/en-us/azure/app-service/web-sites-python-configure
 - https://aka.ms/PythonOnAppService

Simple Python Apps
 - https://github.com/Azure-Samples/python-docs-hello-world
 - https://github.com/Azure-Samples/app-service-web-python-get-started

## Project Structure
In the project you will see the following folders:
  - The **ARM** folder contains the ARM templates to deploy the App Service Plan and Azure Website (with the Python extension installed), it also contains a post deployment powershell script
  - The **src** folder contains our source code
    - In the root of the source folder you will see a few important files
      - **ptvs_virtualenv_proxy.py** This file contains some boiler plate setup code, copy it as-is into your project
      - **requirements.txt** This file lists any python dependencies that you have, for us it is only django
      - **web.config** In here you see two important sections
        - **appSettings** Here we need to setup some key/values so that our site works correctly, NOTE the "WSGI_LOG" setting, this enables debugging, you will want to remove this in production.
        - **handlers** Here we tell IIS to use the version of python that we will install via the web site extension
    - We also have a folder **mysite** that is home to our django app 

## Setting up the build
1. Create a new build, pointing at your source code with an **Empty process** template
1. Add an **Azure Deployment** step to your build, and point it at your Azure Subscription and the ARM template and Parameters file from source control.
1. Add an **Azure App Service Deploy** step to your build, this should copy all the code from the src folder into the web site that we created in the last step. 
1. Add an **Azure PowerShell** step to your build, this should run the postdeploy.ps1 file from the ARM folder. This PowerShell script, takes 2 arguments "resourceGroupName" and "webAppname". This script will log into Kudu to have it run pip install against the requirements.txt file to ensure that you have all the proper python dependencies.

> NOTE: this is about the simplest Django app and build/release pipeline, the goal is to show off the process. In the real world the build/release pipeline can be much more complex. 