templateFile="mk-204-dep-template.json"
paramFile="mk-204-dep-template.parameters.json"
az deployment group create --name mk-204-dep --resource-group mk-204-rg --template-file $templateFile --parameters $paramFile