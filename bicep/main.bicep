// PARAMETERS
param location string = resourceGroup().location

// VARIABLES
var vnetName = 'vnet-lab-${uniqueString(resourceGroup().id)}'

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

// OUTPUTS
