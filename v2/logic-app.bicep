param name string
param appSvcPlanId string
param storageConnectionString string
param serviceBusConnection string
param instrumentationKey string
param location string = resourceGroup().location

resource site 'Microsoft.Web/sites@2021-02-01' = {
  name: name
  location: location
  kind: 'functionapp,workflowapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    httpsOnly: true
    siteConfig: {
      appSettings: [
        {
          name: 'ServiceBusConnection'
          value: serviceBusConnection
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'node'
        }
        {
          name: 'AzureWebJobsStorage'
          value: storageConnectionString
        }
        {
          name: 'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING'
          value: storageConnectionString
        }
        {
          name: 'WEBSITE_CONTENTSHARE'
          value: '${name}-wc'
        }
        {
          name: 'APP_KIND'
          value: 'workflowApp'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: instrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: 'InstrumentationKey=${instrumentationKey}'
        }
      ]
      use32BitWorkerProcess: true
    }
    serverFarmId: appSvcPlanId
    clientAffinityEnabled: false
  }
}
