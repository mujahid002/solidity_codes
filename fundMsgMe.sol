// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract fundMsgMe {
    mapping(address => uint) public balances;
    struct Mes {
        string name;
        string message;
        address from;
        uint bal;
    }
    Mes[] funders;
    address public owner;

    constructor() {
        owner = msg.sender;
    }
    function Transfer(string memory name, string memory message) public payable {
        require(msg.sender != owner,"owner cannot transfer funds");
        require(msg.value > 0, "Please pay greater than 0 ether");
        balances[msg.sender] += msg.value;
        funders.push(Mes(name,message,msg.sender,address(this).balance));
    }

    function Withdraw() public payable {
        require(msg.sender == owner);
        
        payable(msg.sender).transfer(address(this).balance);
        getMes();
    }
    function getMes() public view returns (Mes[] memory) {
        return funders;
    }
}

