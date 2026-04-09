const hre = require("hardhat");

async function main() {
  const USDC_ADDRESS = "0x..."; 
  
  const Market = await hre.ethers.getContractFactory("Market");
  const market = await Market.deploy(USDC_ADDRESS);

  await market.waitForDeployment();
  console.log("Prediction Market deployed to:", await market.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
