param aiName string
param location string

resource ai 'microsoft.insights/components@2020-02-02' = {
  kind: 'web'
  location: location
  name: aiName
  properties: {
    Application_Type: 'web'
  }
}
