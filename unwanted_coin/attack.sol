pragma solidity >= 0.6.1;

contract payassist {
    function payforme(address payable addr) public payable {
        addr.transfer(msg.value);
    }
    function destroy_pay(address payable addr) public payable {
        selfdestruct(addr);
    }
}