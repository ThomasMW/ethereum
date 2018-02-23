pragma solidity ^0.4.20;

/* A simple example of how to change the ownership of a contract */

contract Ownable {

    address owner;
    bool isOwner;

    function Ownable() public {
        owner = msg.sender;
    }

    /* Set up modifier to add to functions which only the owner should be able to call */
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    /* Event for a watcher to register a transfer of ownership */
    event ownershipTransfered(address indexed _oldOwner, address indexed _newOwner);

    function payContract() public payable {
    }

    /* Check if the current address is the owner of the contract */
    function checkOwnership() public returns (bool) {
        if (msg.sender == owner) isOwner = true;
        if (msg.sender != owner) isOwner = false;
        return isOwner;
    }

    /* Transfer all funds out of the contract to the current owner */
    function drainContract() onlyOwner public {
        owner.transfer(this.balance);
    }

    /* Transfer the ownership of the contract to a new account */
    function transferOwnership(address _newOwner) onlyOwner public {
        ownershipTransfered(owner, _newOwner);
        owner = _newOwner;
    }
}
