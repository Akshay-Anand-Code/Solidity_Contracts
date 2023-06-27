// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  // Get the contract factory
  const CarLeasingAndSales = await ethers.getContractFactory("CarLeasingAndSales");

  // Deploy the contract
  console.log("Deploying CarLeasingAndSales contract...");
  const carLeasingAndSales = await CarLeasingAndSales.deploy();

  // Wait for the contract to be mined
  await carLeasingAndSales.deployed();

  console.log("CarLeasingAndSales contract deployed to:", carLeasingAndSales.address);
}

// Run the deployment
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
