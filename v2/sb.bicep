param name string
param location string = resourceGroup().location

var topics = [
  'sku'
  'sku-hierarchy'
]

resource sb 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  location: location
  name: name
  properties: {
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

module topic 'sb-topic.bicep' = [for topicName in topics: {
  name: topicName
  params: {
    name: topicName
    parentName: sb.name
    subs: [
      '${topicName}-sub'
    ]
  }
}]

var sbPath = '${sb.id}/AuthorizationRules/RootManageSharedAccessKey'
output endpoint string = 'Endpoint=sb://${sb.name}.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=${listKeys(sbPath, sb.apiVersion).primaryKey}'
