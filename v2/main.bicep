param location string = resourceGroup().location
var prefix = 'mkbicep'

// module sb 'sb.bicep' = {
//   name: 'sb'
//   params: {
//     name: '${prefix}sb'
//     location: location
//   }
// }

module storage 'storage.bicep' = {
  name: 'storage'
  params: {
    name: '${prefix}st'
    location: location
  }
}

module appInsights 'app-insights.bicep' = {
  name: 'appInsights'
  params: {
     name: '${prefix}-ai'
     location: location
  }
}

module webAppPlan 'app-plan.bicep' = {
  name: 'webAppPlan'
  params: {
    name: '${prefix}-webapp-plan-linux'
    sku: 'F1'
    kind: 'linux'
    location: location
  }
}

module webApp 'web-app.bicep' = {
  name: 'webApp'
  params: {
    name: '${prefix}-web-app'
    location: location
    osVersion: 'DOCKER|mcr.microsoft.com/appsvc/staticsite:latest'
    appSvcPlanId: webAppPlan.outputs.id
    instrumentationKey: appInsights.outputs.instrumentationKey
  }
}

module logicAppPlan 'app-plan.bicep' = {
  name: 'logicAppPlan'
  params: {
    name: '${prefix}-logic-app-plan'
    sku: 'WS1'
    kind: 'elastic'
    location: location
  }
}

module logicApp 'logic-app.bicep' = {
  name: 'logicApp'
  params: {
    name: '${prefix}-logic-app'
    location: location
    appSvcPlanId: logicAppPlan.outputs.id
    instrumentationKey: appInsights.outputs.instrumentationKey
    storageConnectionString: storage.outputs.connectionString
  }
}
