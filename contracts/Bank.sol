// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Bank {
    address public immutable owner;
    struct Depositor {
    address account;
    uint256 amount;
}
Depositor[3] public topDepositors;

    mapping(address => uint256) public deposits;
    modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can withdraw");
    _;
}
    constructor() {
    
        owner = msg.sender;
    }

   function deposit() external payable {
    _recordDeposit();
}

receive() external payable {
    _recordDeposit();
}

function _recordDeposit() private {
    deposits[msg.sender] += msg.value;
    _updateTopDepositors(msg.sender);
}
function _updateTopDepositors(address account) private {
    uint256 amount = deposits[account];

    // 如果该地址已经上榜，先删除旧记录并把后面的记录向前移动。
    for (uint256 i = 0; i < 3; i++) {
        if (topDepositors[i].account == account) {
            for (uint256 j = i; j < 2; j++) {
                topDepositors[j] = topDepositors[j + 1];
            }

            delete topDepositors[2];
            break;
        }
    }

    // 根据最新累计金额重新插入排行榜。
    for (uint256 i = 0; i < 3; i++) {
        if (amount > topDepositors[i].amount) {
            for (uint256 j = 2; j > i; j--) {
                topDepositors[j] = topDepositors[j - 1];
            }

            topDepositors[i] = Depositor(account, amount);
            break;
}
        }
    }    

function withdraw() external onlyOwner {
    uint256 amount = address(this).balance;
    require(amount > 0, "No ETH to withdraw");

    (bool success, ) = payable(owner).call{value: amount}("");
    require(success, "Withdraw failed");
}
}
