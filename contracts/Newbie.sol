// SPDX-License-Identifier: None
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import 'hardhat/console.sol';

contract Newbie is ERC721, ERC721Enumerable, ERC721URIStorage{

    using Counters for Counters.Counter;

    uint constant MAX_NFTS = 10;

    Counters.Counter private _tokenIdCounter;

    string _baseMetaDataURI;

    mapping(address => uint256) public newbiesTokenList;


    constructor(string memory baseURI) ERC721("Newbie", "NWB"){
        _baseMetaDataURI = baseURI;
        safeMint(msg.sender, _baseMetaDataURI);
    }

    function safeMint(address to, string memory uri) public {
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId <= MAX_NFTS, "All NFT's have been minted");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);

        // add to mapping 
        newbiesTokenList[to] = tokenId;
        console.log("NFT has been minted by : " , msg.sender);
        _setTokenURI(tokenId, uri);
    }

    function viewTokenId() public view returns(uint){
        return newbiesTokenList[msg.sender];
    }


    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
    

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }




    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}