// This is an example contract where people can make 'investments' to a contract
// Each investment has to be higher than the latest one to get accepted
// Investors can attach a personal message which other people can read
// Based on: Cryptobragging from Neel Rao @ https://cryptobragging.com/

pragma solidity ^0.4.11;

contract InvestCompetition {
    // Most recent investor
    address public latestInvestor;

    // Personal Message from Investor
    string public personalMessage;

    // Highest Investment made so far
    uint public highestInvestment;

    address owner;

    function InvestCompetition() public {
        owner = msg.sender;
        highestInvestment = 0;
    }

    function makeInvestment(string newMessage) public payable {
        // New investment has to be higher than latest
        require(msg.value > highestInvestment);

        // Message max length
        require(bytes(newMessage).length < 500);

        highestInvestment = msg.value;
        latestInvestor = msg.sender;
        personalMessage = newMessage;
    }

    function displayMessage() public constant returns(string) {
	// Display message from latest investment
        return personalMessage;
    }

    function displaytotalBalance() public constant returns(uint) {
	// Displays the total balance of the contract
        return this.balance;
    }

    function withdrawBalance() public {
	// Transfers the contractbalance to the owner of the contract
        require(msg.sender == owner);
        owner.transfer(this.balance);
    }
}
