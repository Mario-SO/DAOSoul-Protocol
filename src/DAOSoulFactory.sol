// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./DAOSoul.sol";
import "@optionality/contracts/CloneFactory.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DAOSoulFactory is Ownable, CloneFactory {
    address public libraryAddress;

    event SoulCreated(address newFoundation);

    function SoulFactory(address _libraryAddress) public {
        libraryAddress = _libraryAddress;
    }

    function setLibraryAddress(address _libraryAddress) public onlyOwner {
        libraryAddress = _libraryAddress;
    }

    function createSoul(string _name) public onlyOwner {
        address clone = createClone(libraryAddress);
        DAOSoul(clone).init(_name);
        SoulCreated(clone);
    }
}
