// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Bank {
    address private owner; // Address of the contract owner
    mapping (address => uint256) private userBalances; // Mapping to store user balances

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function"); // Modifier to restrict access to the owner
        _;
    }

    function deposit() public payable returns (bool) {
        require(msg.value > 0, "Please deposit some ether"); // Ensure a positive deposit amount
        userBalances[msg.sender] += msg.value; // Add the deposited amount to the user's balance
        return true;
    }

    function withdraw(uint256 _amount) public returns (bool) {
        uint256 _a=_amount* 1 ether;
        require(_a > 0, "Withdrawal amount must be greater than zero"); // Ensure a positive withdrawal amount
        require(_a <= userBalances[msg.sender], "Insufficient balance"); // Ensure user has enough balance to withdraw
        

        userBalances[msg.sender] -= _a; // Subtract the withdrawal amount from the user's balance
        payable(msg.sender).transfer(_a); // Transfer the ether to the user
        
        return true;
    }

    function getBalance() public view returns (uint256) {
        return userBalances[msg.sender]; // Return the balance of the caller
    }

    function getContractBalance() public view onlyOwner returns (uint256) {
        return address(this).balance; // Return the balance of the contract
    }

    function withdrawFunds(uint256 _funds) public onlyOwner returns (bool) {
        uint256 _f=_funds* 1 ether;
        require(_f > 0, "Withdrawal amount must be greater than zero"); // Ensure a positive withdrawal amount
        require(_f <= address(this).balance, "Insufficient contract balance"); // Ensure contract has enough balance
        
        payable(owner).transfer(_f); // Transfer the specified funds to the owner
        
        return true;
    }
}
