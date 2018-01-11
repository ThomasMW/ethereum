/* Based on the Cryptobragging contract @ cryptobragging.com,
   which allows pariticpants to add new messages as long as
   their transaction value is higher than the most recent one */

pragma solidity ^0.4.11;

contract InvestCompetition {
    /* Most recent investor */
    address public latestInvestor;
    
    /* Personal Message from Investor */
    string public personalMessage;
    
    /* Highest Investment made so far */
    uint public highestInvestment;
    
    address owner;
    
    function InvestCompetition() public {
        owner = msg.sender;
        highestInvestment = 0;
    }
    
    function makeInvestment(string newMessage) public payable {
        /* New investment has to be higher than latest */
        require(msg.value > highestInvestment);
        
        /* Message max length */
        require(bytes(newMessage).length < 500);
        
        highestInvestment = msg.value;
        latestInvestor = msg.sender;
        personalMessage = newMessage;
    }
    
    function displayMessage() public constant returns(string) {
	/* Display message from latest investment */
        return personalMessage;
    }
    
    function displaytotalBalance() public constant returns(uint) {
	/* Displays the total balance of the contract */
        return this.balance;
    }
    
    function withdrawCustom(uint amount) public {
        /* Sends a custom amount back to the owner */
        require(msg.sender == owner);
        owner.transfer(amount);
    }
    
    function withdrawTotalBalance() public {
	/* Transfers the total contractbalance to the owner of the contract,
	   only the owner can do this */
        require(msg.sender == owner);
        owner.transfer(this.balance);
    }
}
