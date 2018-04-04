# $resourceGroupName = "DjangoRG"
# $webAppname = "DjangoTest-zq2tuw2chb6g4"

param($resourceGroupName, $webAppname)

function Get-PublishingProfileCredentials($resourceGroupName, $webAppName){

    $resourceType = "Microsoft.Web/sites/config"
    $resourceName = "$webAppName/publishingcredentials"

    $publishingCredentials = Invoke-AzureRmResourceAction -ResourceGroupName $resourceGroupName -ResourceType $resourceType -ResourceName $resourceName -Action list -ApiVersion 2015-08-01 -Force

    return $publishingCredentials
}

function Get-KuduApiAuthorisationHeaderValue($resourceGroupName, $webAppName){

    $publishingCredentials = Get-PublishingProfileCredentials $resourceGroupName $webAppName

    return ("Basic {0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $publishingCredentials.Properties.PublishingUserName, $publishingCredentials.Properties.PublishingPassword))))
}

function Install-PythonRequirements($webAppName, $accessToken ){

    $apiUrl = "https://$webAppName.scm.azurewebsites.net/api/command"
    $headers = @{Authorization=$accessToken}
    $body = "{'command': 'python.exe -m pip install --upgrade -r d:\\home\\site\\wwwroot\\requirements.txt', 'dir' : '\\home\\python364x64' }"

    $result = Invoke-WebRequest -Uri $apiUrl -Method Post -Headers $headers -Body $body -ContentType "application/json"
     
    return $result`
}


$accessToken = Get-KuduApiAuthorisationHeaderValue $resourceGroupName $webAppname
Write-Output (Install-PythonRequirements $webAppname $accessToken)
