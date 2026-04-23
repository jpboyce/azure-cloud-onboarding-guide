// PARAMETERS
param location string = resourceGroup().location
param tenantId string

// VARIABLES
var vnetName = 'vnet-lab-${uniqueString(resourceGroup().id)}'
var lawName = 'law-lab-${uniqueString(resourceGroup().id)}'
var appiName = 'appi-lab-${uniqueString(resourceGroup().id)}'
var uamiFuncName = ''
var kvName = 'kv-lab-${uniqueString(resourceGroup().id)}'

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

// OUTPUTS
