import { ethers } from "hardhat";

async function main() {
  
  const [deployer] = await ethers.getSigners();
  console.log(`Address deploying the contract --> ${deployer.address}`);

  

  const INEC = await ethers.getContractFactory("voting");
  const inec = await INEC.deploy("OBI");

  await inec.deployed();

  console.log("Vault of 1 ETH deployed to:", inec.address);

  let result = await inec.vote(
        1
  )

  let response = (await result.wait());

 console.log("factory cloned successfully", response);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
