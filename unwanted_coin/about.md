# Unwanted coin

## Problem

This contract only accepts ether pay that ((msg.value / 0.001 ether ) % 2 == 0 && ((msg.value % 0.001 ether) == 0), which is limited by fallback function and recvpay.
```solidity
    fallback () external payable {
        require(((msg.value / 0.001 ether ) % 2 == 0 && ((msg.value % 0.001 ether) == 0)), "Not Accepting These Coins.");
    }
    function recvpay() public payable {
        require(((msg.value / 0.001 ether ) % 2 == 0 && ((msg.value % 0.001 ether) == 0)), "Not Accepting These Coins.");
    }
```
However, It requires the balance of this contract (address(this).balance / 0.001 ether ) % 2 == 1, Which is not possible if you use normal payment method

## Knowledge

In Ethereum, normal payment that not satisfy require will be rolled back. However some kinds of payment cannot be refused, like another contract's selfdestruct() and mining. So, you can make use of self-destruct and force these coins into the contract's balance.

## Solution

See attack.sol.
