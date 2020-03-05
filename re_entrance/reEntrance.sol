pragma solidity >=0.6.1;

// Demo Address: Ropsten:
// There also exists an overflow error, however we are not handling it.

contract ReEntrance {
    mapping(address => uint256) public remainCredit;
    function deposit() public payable {
        remainCredit[msg.sender] += msg.value;
    }
    function withdraw (uint256 _weiToWithdraw) public {
        require(remainCredit[msg.sender] >= _weiToWithdraw, "No enough credits!");
        // limit the withdrawal
        (bool p, bytes memory q) = msg.sender.call.value(_weiToWithdraw)("");
        require(p,"No enough credits");
        /**
          * Here Exposed the vuln of this contract:
          * call.value will transfer the all remaining gas to the callee
          * It would process normally when it's paid by a non-contact callee
          * However when a contract is paid, it's fallback payable will be called,
          * and now it have your remaining gas and can be executed before minus your credit.
        */
        remainCredit[msg.sender] -= _weiToWithdraw;
    }
}