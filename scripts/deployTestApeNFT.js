const hre = require('hardhat');

async function main() {
	const TestApeNFT = await hre.ethers.getContractFactory('TestApeNFT');
	const testApeNFT = await TestApeNFT.deploy();

	await testApeNFT.deployed();

	console.log('TestApeNFT deployed to:', testApeNFT.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
