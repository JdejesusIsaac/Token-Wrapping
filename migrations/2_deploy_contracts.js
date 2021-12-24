const FrenchToken = artifacts.require("FrenchToken");
const RanchToken = artifacts.require("RanchToken");
const Wrapper = artifacts.require("Wrapper");

module.exports = async (deployer) => {
  const frenchToken = await deployer.deploy(FrenchToken);
  await frenchToken.deployed();
  const ranchToken = await deployer.deploy(RanchToken);
  await ranchToken.deployed();

  
};
