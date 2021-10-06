// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import '@ensdomains/ens-contracts/contracts/registry/ENS.sol';
import '@ensdomains/ens-contracts/contracts/resolvers/profiles/AddrResolver.sol';
import '@ensdomains/ens-contracts/contracts/resolvers/profiles/NameResolver.sol';
import '@ensdomains/ens-contracts/contracts/resolvers/profiles/TextResolver.sol';
import '@openzeppelin/contracts/access/Ownable.sol';

contract CitizenENSResolver is Ownable, AddrResolver, NameResolver, TextResolver {

    ENS public immutable _registry;

    constructor(ENS registry) {

        _registry = registry;

    }

    // Overrides.

    // TODO: What permissions should the subdomain owner have?
    function isAuthorised(bytes32 node) internal override view returns(bool) {

        return owner() == msg.sender || _registry.owner(node) == msg.sender;

    }

    function supportsInterface(bytes4 interfaceID) virtual override(AddrResolver, NameResolver, TextResolver) public pure returns(bool) {

        return super.supportsInterface(interfaceID);

    }

}
