param resourceGroupLocation string
param env string
var resourceGroupName = 'mk-bicep-${env}'
var storageAccName = 'mkstorage${env}'
var serviceBusNamespace = 'mksb${env}'
var appInsightsName = 'mkai${env}'

targetScope = 'subscription'
resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

module storage 'storage.bicep' = {
  name: 'StorageModule'
  scope: rg
  params: {
    location: rg.location
    storageAccName: storageAccName
  }
}

module serviceBus 'service-bus.bicep' = {
  name: 'ServiceBusModule'
  scope: rg
  params: {
    location: rg.location
    namespace: serviceBusNamespace
  }
}

module ai 'app-insights.bicep' = {
  name: 'AppInsightsModule'
  scope: rg
  params: {
    aiName: appInsightsName
    location: rg.location
  }
}
