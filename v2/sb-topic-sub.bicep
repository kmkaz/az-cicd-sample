param parentName string
param name string

resource sbTopicSub 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2022-01-01-preview' = {
  name: '${parentName}/${name}'
}
