param name string
param sku string
param kind string
param location string = resourceGroup().location

resource appPlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: name
  location: location
  kind: kind
  sku: {
    name: sku
  }
  properties: {
    reserved: kind == 'linux'
  }
}

output id string = appPlan.id
