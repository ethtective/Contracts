const Ethtective20 = artifacts.require("./Ethtective20.sol");

module.exports = async function(deployer) {
    await deployer.deploy(Ethtective20, "Ethtective20", "Ethtective20");
    const eth20 = await Ethtective20.deployed();
};
