// SPDX-License-Identifier: MIT
pragma solidity <0.9.0;

contract TimeVault {
    address owner;
    mapping(uint256 => uint256) public numbers;
    mapping(address => uint256) public balances;
    mapping(address => uint256) public lockTime;

    event DepositEth(address depositor, uint256 amount);

    constructor() {
        owner = msg.sender;
        numbers[10] = 12345;
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
        numbers[20] += 20000;

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

        uint256 balance = balances[msg.sender];
        balances[msg.sender] = 0;

        address payable client = payable(msg.sender);
        client.transfer(balance);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function getNumber(uint256 number) public view returns (uint256) {
        return numbers[number];
    }

    function selfDestruct() public {
        selfdestruct(payable(owner));
    }
}
