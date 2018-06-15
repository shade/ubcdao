pragma solidity ^0.4.23;


contract Demiurge {

    // This is the last date any of the axioms can be changed.
    // This is currently set for January 3, 2019.
    // Exactly 10 years after the BTC Genesis date
    uint256 public PETRIFICATION_DATE = 1546539305000;
    address public creationAddress;
    string[] public axioms;

    modifier isValidRequest () {
        require(block.timestamp > PETRIFICATION_DATE);
        require(msg.sender == creationAddress);
        _;
    }

    constructor () public {
        axioms.push("This contract and its children must obey the following axioms");
    }

    function updateAxiom (uint8 index, string value) isValidRequest public {
        axioms[index] = value;
    }

    function addAxiom (string value) isValidRequest public {
        axiom.push(value);
    }
}
