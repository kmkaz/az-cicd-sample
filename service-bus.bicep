param namespace string
param location string


resource serviceBus 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  location: location
  name: namespace
  properties: {
    disableLocalAuth: false
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}
