// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract KingOfEther {
    address public king;
    // current balance of the king
    uint public balance;
    // Number of prev|current kings
    mapping(address => uint) public balances;

    // create deposit function that makes sure you cannot deposit lower than current king.
    // contract: 0xeF01B26ccD02FfA900CB5Cd34AE8f9CCFdF25502

    function claimThrone() external payable {

        // adds the new king balance
        // to the contract balance
        balances[king] += balance;

        balance = msg.value;
        king = msg.sender;
    }

    function withdraw() public {
        // the msg.sender cannot 
        // be the current king
        require(msg.sender != king, "Current king cannot withdraw");

        // store current amount of ether
        // that msg.sender can withdraw in "amount" var
        uint amount = balances[msg.sender];
        // set amount that msg.sender can withdraw to 0
        // set balance to 0 before sending ether to
        // protect against re-entrancy
        balances[msg.sender] = 0;

        // send the ether to msg.sender
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
