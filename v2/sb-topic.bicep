param parentName string
param name string
param subs array

resource sbTopic 'Microsoft.ServiceBus/namespaces/topics@2022-01-01-preview' = {
  name: '${parentName}/${name}'
}

module sbTopicSub 'sb-topic-sub.bicep' = [for sub in subs: {
  name: '${name}-${sub}-sub'
  params: {
    name: sub
    parentName: sbTopic.name
  }
}]
