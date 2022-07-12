param storageAccName string
param location string

var blobContainerName = 'uploads'

resource storageAcc 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}

resource storageBlob 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: storageAcc
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: false
    }
    isVersioningEnabled: false
  }
}

resource storageBlobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: storageBlob
  name: blobContainerName
  properties: {
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    immutableStorageWithVersioning: {
      enabled: false
    }
    publicAccess: 'None'
  }
}

