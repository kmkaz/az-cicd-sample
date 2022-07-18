param name string
param osVersion string
param appSvcPlanId string
param instrumentationKey string
param location string = resourceGroup().location

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: name
  location: location
  tags: {}
  properties: {
    siteConfig: {
      appSettings: [
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: 'InstrumentationKey=${instrumentationKey}'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: instrumentationKey
        }
      ]
      linuxFxVersion: osVersion
    }
    serverFarmId: appSvcPlanId
  }
}
