pragma solidity >=0.8.0;
// SPDX-License-Identifier: MIT

import "./DAOSoul.sol";

// make a factory contract that can create DAOSouls
contract FactoryDAOSoul {
    DAOSoul[] private _daoSoul;

    function createSoul() public {
        DAOSoul daoSoul = new DAOSoul();
        _daoSoul.push(daoSoul);
    }

    function allSouls(uint256 limit, uint256 offset)
        public
        view
        returns (DAOSoul[] memory coll)
    {
        return coll;
    }
}
