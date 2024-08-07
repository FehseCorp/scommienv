param kvName string
param Tags object 
param adminusername string
// secure adminpassword
@secure()
param adminpassword string

resource keyvault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: kvName
}

// Add secret from parameter
resource kvsecret1 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  name: 'AdminUsername'
  tags: Tags
  parent: keyvault
  properties: {
    attributes: {
      enabled: true
    }
    contentType: 'string'
    value: adminusername
  }
}

// Add secret from parameter
resource kvsecret2 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  name: 'AdminPassword'
  tags: Tags
  parent: keyvault
  properties: {
    attributes: {
      enabled: true
    }
    contentType: 'string'
    value: adminpassword
  }
}
