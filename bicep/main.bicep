// PARAMETERS
param location string = resourceGroup().location
param tenantId string

// VARIABLES
var vnetName = 'vnet-lab-${uniqueString(resourceGroup().id)}'
var lawName = 'law-lab-${uniqueString(resourceGroup().id)}'
var appiName = 'appi-lab-${uniqueString(resourceGroup().id)}'
var uamiFuncName = ''
var kvName = 'kv-lab-${uniqueString(resourceGroup().id)}'
var aspName = 'asp-lab-${uniqueString(resourceGroup().id)}'
var storageName = 'stlab${uniqueString(resourceGroup().id)}'
var funcName = ''

var privateStorageFileDnsZoneName = 'privatelink.file.${environment().suffixes.storage}'
var privateStorageBlobDnsZoneName = 'privatelink.blob.${environment().suffixes.storage}'
var privateStorageQueueDnsZoneName = 'privatelink.queue.${environment().suffixes.storage}'
var privateStorageTableDnsZoneName = 'privatelink.table.${environment().suffixes.storage}'

var privateEndpointStorageFileName = 'pe-${funcName}-file'
var privateEndpointStorageTableName = 'pe-${funcName}-table'
var privateEndpointStorageBlobName = 'pe-${funcName}-blob'
var privateEndpointStorageQueueName = 'pe-${funcName}-queue'

// RESOURCES
resource vnet 'Microsoft.Network/virtualNetworks@2025-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/24'
      ]
    }
    subnets: [
      {
        name: 'snet-pe' // Private Endpoints Subnet
        properties: {
          addressPrefixes: [
            '10.0.0.0/28'
          ]
          defaultOutboundAccess: false
        }
      }
      {
        name: 'snet-vni'  // Virtual Network Integration subnet
        properties: {
          addressPrefixes: [
            '10.0.0.128/27'
          ]
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
              locations: [
                'australiaeast'
              ]
            }
          ]
          delegations: [
            {
              name: 'delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverfarms'
              }
            }
          ]
          defaultOutboundAccess: true
        }
      }
    ]
  }
}

resource privateStorageFileDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateStorageFileDnsZoneName
  location: 'global'
}
resource privateStorageBlobDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateStorageBlobDnsZoneName
  location: 'global'
}
resource privateStorageQueueDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateStorageQueueDnsZoneName
  location: 'global'
}
resource privateStorageTableDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: privateStorageTableDnsZoneName
  location: 'global'
}

resource privateStorageFileDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  name: '${privateStorageFileDnsZoneName}-link'
  parent: privateStorageFileDnsZone
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

resource privateStorageBlobDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  name: '${privateStorageBlobDnsZoneName}-link'
  parent: privateStorageBlobDnsZone
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

resource privateStorageTableDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  name: '${privateStorageTableDnsZoneName}-link'
  parent: privateStorageTableDnsZone
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

resource privateStorageQueueDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  name: '${privateStorageQueueDnsZoneName}-link'
  parent: privateStorageQueueDnsZone
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: vnet.id
    }
  }
}

resource privateEndpointStorageFile 'Microsoft.Network/privateEndpoints@2025-05-01' = {
  name: privateEndpointStorageFileName
  location: location
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'snet-pe')
    }
    privateLinkServiceConnections: [
      {
        name:'StorageFilePrivateLinkConnection'
        properties: {
          privateLinkServiceId: storage.id
          groupIds: [
            'file'
          ]
        }
      }
    ]
  }
}

resource privateEndpointStorageBlob 'Microsoft.Network/privateEndpoints@2025-05-01' = {
  name: privateEndpointStorageBlobName
  location: location
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'snet-pe')
    }
    privateLinkServiceConnections: [
      {
        name:'StorageBlobPrivateLinkConnection'
        properties: {
          privateLinkServiceId: storage.id
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
}

resource privateEndpointStorageTable 'Microsoft.Network/privateEndpoints@2025-05-01' = {
  name: privateEndpointStorageTableName
  location: location
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'snet-pe')
    }
    privateLinkServiceConnections: [
      {
        name:'StorageTablePrivateLinkConnection'
        properties: {
          privateLinkServiceId: storage.id
          groupIds: [
            'table'
          ]
        }
      }
    ]
  }
}

resource privateEndpointStorageQueue 'Microsoft.Network/privateEndpoints@2025-05-01' = {
  name: privateEndpointStorageQueueName
  location: location
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'snet-pe')
    }
    privateLinkServiceConnections: [
      {
        name:'StorageQueueuPrivateLinkConnection'
        properties: {
          privateLinkServiceId: storage.id
          groupIds: [
            'queue'
          ]
        }
      }
    ]
  }
}

resource law 'Microsoft.OperationalInsights/workspaces@2025-07-01' = {
  name: lawName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appiName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: law.id
  }
}

resource uamiFunc 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-05-31-preview' = {
  name: uamiFuncName
  location: location
}

resource kv 'Microsoft.KeyVault/vaults@2025-05-01' = {
  name: kvName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: tenantId
  }
}

resource asp 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: aspName
  location: location
  kind: 'linux'
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource storage 'Microsoft.Storage/storageAccounts@2025-08-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
    publicNetworkAccess: 'Disabled'
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

// OUTPUTS
