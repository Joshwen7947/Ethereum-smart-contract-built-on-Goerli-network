require('@nomicfoundation/hardhat-toolbox');
require('@nomiclabs/hardhat-etherscan');
const dotenv = require('dotenv');
const { task } = require('hardhat/config');

dotenv.config();

task('accounts', 'Prints the list of accounts', async (tasksArgs, hre) => {
	const accounts = await hre.ethers.getSigner();

	for (const account of accounts) {
		console.log(account.address);
	}
});
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
	solidity: '0.8.17',
	networks: {
		goreli: {
			url: process.env.REACT_APP_GORELI_URL,
			accounts: [process.env.REACT_APP_PRIVATE_KEY],
		},
	},
	etherscan: {
		apiKey: process.env.REACT_APP_ETHERSCAN_KEY,
	},
};
