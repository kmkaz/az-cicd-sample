location=$1
env=$2
az deployment sub create --location $location --template-file ./bicep/main.bicep --parameters resourceGroupLocation=$location env=$env