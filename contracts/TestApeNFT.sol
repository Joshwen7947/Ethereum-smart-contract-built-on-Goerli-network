// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


//Create a smart contract
contract TestApeNFT is ERC721, Ownable {
    //Creating a VAR in smart contracts:
    //Start w/ uint256 public -> this creates a public VAR for the contract
    // Then set VAR name
    //uint256 = Standard VAR
    //bool = boolean VAR
    uint256 public mintPrice; // set mint price
    uint256 public totalSupply; // set total supply
    uint256 public maxSupply; // set max supply
    uint256 public maxPerWallet; //Prohibit ppl from minting entire collection
    bool public isPublicMintEnabled; //Toggle True or False
    string internal baseTokenUri;  //URL for Opensea to determine where the image is located
    address payable public withdrawWallet;
    mapping(address => uint256) public walletMints; //determines and tracks all the mints that are done !important 


    //runs at the start - ERC721 accepts two arguments, 1.name of nft, 2.token symbol
    constructor() payable ERC721('TestApe', 'TA'){
        mintPrice = 0.02 ether;
        totalSupply = 0; //set to 0 bc this is where we start
        maxSupply = 1000;
        maxPerWallet = 3;
        // set withdraw address as a string
    }

    function setIsPublicMintEnabled(bool isPublicMintEnabled_) external onlyOwner{
        isPublicMintEnabled = isPublicMintEnabled_;
    }

    function setBaseTokenUri(string calldata baseTokenUri_) external onlyOwner {
        baseTokenUri = baseTokenUri_;
    }

    function tokenURI(uint256 tokenId_) public view override returns (string memory){
        require(_exists(tokenId_), 'Token does not exist');
        return string(abi.encodePacked(baseTokenUri, Strings.toString(tokenId_), '.json'));
    }

    function withdraw() external onlyOwner{
        (bool success, ) = withdrawWallet.call{value:address(this).balance }('');
        require(success, 'withdraw failed');
    }



    function mint(uint256 quantity_) public payable{
        require(isPublicMintEnabled, 'minting not enabled');
        require(msg.value == quantity_ * mintPrice, 'wrong mint price');
        require(totalSupply + quantity_ <= maxSupply,'sold out');
        require(walletMints[msg.sender]+quantity_ <= maxPerWallet,'exceeded max per wallet');

        for(uint256 i = 0; i < quantity_; i++){
            uint256 newTokenId = totalSupply + 1;
            totalSupply++;
            _safeMint(msg.sender, newTokenId);

        }
    }
}