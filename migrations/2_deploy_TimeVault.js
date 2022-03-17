
const TimeVault = artifacts.require("TimeVault");

module.exports = async function (deployer) {
  await deployer.deploy(TimeVault);
  let instance = await TimeVault.deployed();
  console.log('TimeVault Deployed at address ', instance.address);
};

