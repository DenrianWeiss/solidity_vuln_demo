pragma solidity >=0.6.1;

contract Modcoin {
    mapping(uint256 => bool) public is_successful;
    function recvpay() public payable {
        require(((msg.value / 0.001 ether ) % 2 == 0 && ((msg.value % 0.001 ether) == 0)), "Not Accepting These Coins.");
    }
    function getflag(uint256 target) public {
        require((address(this).balance / 0.001 ether ) % 2 == 1,"Not Wanted value");
        require(msg.sender.send(address(this).balance));
        is_successful[target] = true;
    }
    fallback () external payable {
        require(((msg.value / 0.001 ether ) % 2 == 0 && ((msg.value % 0.001 ether) == 0)), "Not Accepting These Coins.");
    }
}
