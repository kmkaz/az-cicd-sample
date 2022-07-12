location=uksouth
az deployment sub create --location $location --template-file ../bicep/main.bicep --parameters resourceGroupLocation=$location