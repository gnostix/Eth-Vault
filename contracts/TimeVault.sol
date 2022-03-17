// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract TimeVault {

    mapping(address => uint256) public balances;
    mapping(address => uint256) public lockTime;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint256 _secondsToIncrease) public {
        lockTime[msg.sender] += _secondsToIncrease;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "this address has no balance");
        require(block.timestamp > lockTime[msg.sender], "Locktime is less than a week");
        balances[msg.sender] = 0;
    }
    
}
