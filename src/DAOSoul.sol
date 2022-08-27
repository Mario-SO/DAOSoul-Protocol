// SPDX-License-Identifier: MIT
pragma solidity >0.4.23 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// @author 0xSensei.eth
// @notice This is my take on a DAO badge protocol using SBTs.

contract DAOSoul is ERC721, ERC721URIStorage, Ownable {
    /*///////////////////////////////////////////////////////////////
                            LIBRARIES 
    //////////////////////////////////////////////////////////////*/

    using Counters for Counters.Counter;

    /*///////////////////////////////////////////////////////////////
                            CONSTANTS
    //////////////////////////////////////////////////////////////*/

    Counters.Counter private _tokenIdCounter;
    uint256 public tokenPrice = 0 ether;

    /*///////////////////////////////////////////////////////////////
                            ERRORS
    //////////////////////////////////////////////////////////////*/

    error IsSBT(string message);

    /*///////////////////////////////////////////////////////////////
                            VIEWS
    //////////////////////////////////////////////////////////////*/

    // @dev This function is used to set the URI of a token. It must have the following format:
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    /*///////////////////////////////////////////////////////////////
                            CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/

    constructor() ERC721("DAO-Soul", "DAOS") {}

    /*///////////////////////////////////////////////////////////////
                            PUBLICS
    //////////////////////////////////////////////////////////////*/

    // @dev Mint function.
    function safeMint(address to, string memory uri) public payable {
        require(
            msg.value == tokenPrice,
            "You must pay the correct price to mint a badge."
        );
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // @dev Price change function.
    function setPrice(uint256 _tokenPrice) public onlyOwner {
        tokenPrice = _tokenPrice;
    }

    /*///////////////////////////////////////////////////////////////
                            INTERNALS 
    //////////////////////////////////////////////////////////////*/

    // @dev Function to burn the token.
    // @notice This function must be implemented, otherwise, there won't be any way to get rid of the token.
    function _burn(uint256 tokenId)
        internal
        override(ERC721, ERC721URIStorage)
    {
        super._burn(tokenId);
    }

    // @dev Function that prevents the token from being transferred.
    // @notice When the address from == adrress(0), it means the token is being issued or minted and not transferred.
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        if (from == address(0)) revert IsSBT("Err: Token is not transferable");
        super._beforeTokenTransfer(from, to, tokenId);
    }
}
