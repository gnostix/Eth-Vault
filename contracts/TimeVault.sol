// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract TimeVault {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public lockTime;

    event DepositEth(address depositor, uint amount);

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;

        emit DepositEth(msg.sender, msg.value);
    }

    function increaseLockTime(uint256 _secondsToIncrease) public {
        lockTime[msg.sender] += _secondsToIncrease;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "this address has no balance");
        require(
            block.timestamp > lockTime[msg.sender],
            "Locktime is less than a week"
        );

        uint balance = balances[msg.sender];
        balances[msg.sender] = 0;

        address payable owner = payable(msg.sender);
        owner.transfer(balance);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
