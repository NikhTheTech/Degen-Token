const hre = require("hardhat");

async function main() {
	
  const DegenToken = await hre.ethers.deployContract("DegenToken",["Degen", "DGN"]);

  await DegenToken.waitForDeployment();

  console.log(`Contract Deployed to address ${await DegenToken.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});