# Django Python Application

## General Information Links
Config Python
https://docs.microsoft.com/en-us/azure/app-service/web-sites-python-configure
https://aka.ms/PythonOnAppService

Simple Python Apps
https://github.com/Azure-Samples/python-docs-hello-world
https://github.com/Azure-Samples/app-service-web-python-get-started

## Creating the Azure Enviroment
(with Azure CLI 2.0 and ARM)

Create the Resource Group
```
az group create -l southcentralus -n djangoRG
```

Deploy the ARM template - this will create the ASP & the WebSite
```
az group deployment create -g djangoRG --template-file ARM/azuredeploy.json --parameters ARM/azuredeploy.parameters.json
```

Clean Up
```
az group delete -n djangoRG -y --no-wait 
```

python.exe -m pip install --upgrade -r d:\home\site\wwwroot\requirements.txt


## Hints/Tweaks
Having trouble with Python? Add the following App Settings value (in the portal, so you can turn it off without a redeploy) to output a debug file you can review to get hints about what is wrong. 
Key: WSGI_LOG
Value: D:\home\site\wwwroot\logs.txt


My django app is default except for:

I added the following to my settings.py
```
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')
STATIC_URL = '/static/'
STATICFILES_DIRS = (
    os.path.join(BASE_DIR, 'static'),
)
```

I created a views.py and added a simple helloworld view and the routing to it in the urls.py file.

ptvs_virtualenv_proxy.py is from the Azure docs no changes

requirements.txt just pulling in django

runtime.txt forcing Azure to 3.4

web.config default web.config from the Azure docs, except I did tweak the App Settings area to work with django. 


D:\Python34\python.exe -m pip install --upgrade -r d:\home\site\wwwroot\requirements.txt

