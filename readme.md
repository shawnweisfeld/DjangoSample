# Automating Deployment of a Django Python Application to Azure App Service Web Site from VisualStudio.com

## General Informational Links
Config Python
https://docs.microsoft.com/en-us/azure/app-service/web-sites-python-configure
https://aka.ms/PythonOnAppService

Simple Python Apps
https://github.com/Azure-Samples/python-docs-hello-world
https://github.com/Azure-Samples/app-service-web-python-get-started

## Project Structure
In the project you will see 3 folders: ARM, docs and src. 
  - The **ARM** folder contains the ARM templates to deploy the App Service Plan and Azure Website (with the Python extension installed)
  - The **Docs** folder contains images for this readme
  - The **src** folder contains our source code
    - In the root of the source folder you will see a few important files
      - **ptvs_virtualenv_proxy.py** This file contains some boiler plate setup code, copy it as-is into your project
      - **requirements.txt** This file lists any python dependencies that you have, for us it is only django
      - **web.config** In here you see two important sections
        - **appSettings** Here we need to setup some key/values so that our site works correctly, NOTE the "WSGI_LOG" setting, this enables debugging, you will want to remove this in production.
        - **handlers** Here we tell IIS to use the version of python that we will install via the web site extension
    - We also have a folder **mysite** that is home to our django app 
