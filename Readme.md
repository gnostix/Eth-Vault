Create a time Vault which we can break with number overflow!

Start running Ganache.
From within the project run
1.  `truffle console development` // coonect to Ganache blockchain testnet
2.  truffle(development)> `compile`  // compile code
3.  truffle(development)> `migrate`  // migrate contract to chain
4.  truffle(development)>`let instance = await TimeVault.deployed()`  // get contract instance
5.  truffle(development)>`inst.deposit({from: accounts[0], value: 3000000000000000000})` // deposit 3 Eth 
6.  truffle(development)>`inst.withdraw({from: accounts[0]})` // will fail with error from contract due to timelock limit
7.  node test/get_storage.js // read mapping from storage
8.  TODO we have to break contract and get back our Eth

Notes on Rnkeby deployment

let instance = await TimeVault.deployed()
instance.address
web3.eth.getStorageAt(instance.address, 0) // owner address
instance.deposit({from:accounts[0], value:100000000000000000})
instance.getBalance().then((value) => console.log(web3.utils.fromWei(value, "ether")))