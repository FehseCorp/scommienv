
param vnetname string
param location string

// Create VNet with three subnets, one for DC, one for SCOMMI and one for SQLMI
resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: vnetname
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.1.0/16'
      ]
    }
    subnets: [
      {
        name: 'AD'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'SQLMI'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
      {
        name: 'SCOMMI'
        properties: {
          addressPrefix: '10.0.3.0/24'
        }
      }
    ]
  }
}


