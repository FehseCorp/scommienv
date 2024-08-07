param scomminame string = 'scommi'
param vnetname string
param vnetaddressrange string
param subnetname string
param subnetrange string
param dcIPaddress string
param location string
param adminusername string
@secure()
param adminpassword string


module DC './Templates/DC/dc.bicep' = {
  name: 'dc'
  dependsOn: [
    vnets
  ]
  params: {
    adminPassword: ''
    adminUsername: 'azureadmin'
    domainName: 'contoso.com'
    adNicIPAddress: dcIPaddress
    adSubnetAddressPrefix: subnetrange
    adSubnetName: subnetname
    virtualNetworkAddressRange: vnetaddressrange
    virtualNetworkName: vnetname
  }
}

module vnets './Templates/VNet/vnet.bicep' = {
  name: 'vnets'
  params: {
    vnetname: vnetname
    location: location
  }
}

// keyvault
module keyvault './Templates/KeyVault/keyvault.bicep' = {
  name: 'keyvault'
  params: {
    kvName: scomminame
    Tags: {
      environment: 'dev'
    }
    location: location
  }
}
// UMI
module umi './Templates/UMI/umi.bicep' = {
  name: 'umi'
  params: {
    location: location
    Tags: {
      environment: 'dev'
    }
    userIdentityName: scomminame
  }
}
module secrets './scommi/kvsecrets.bicep' = {
  name: 'secrets'
  params: {
    kvName: scomminame
    Tags: {
      environment: 'dev'
    }
    adminusername: adminusername
    adminpassword: adminpassword
  }
}
// module sqlmi 'Templates/SQLMI/sqlmi.bicep' = {
//   name: 'sqlmi'
//   params: {
//     sqlminame: sqlminame
//     scomminame: scomminame
//   }
// }

// customize SQLMI with entraid admin
// Create Keyvault and secrets


// Create UMI
