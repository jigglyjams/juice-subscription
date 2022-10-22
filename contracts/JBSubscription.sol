pragma solidity ^0.8.16;

import '@jbx-protocol/juice-contracts-v3/contracts/JBETHERC20ProjectPayer.sol';

contract JBSubscription is JBETHERC20ProjectPayer {
  uint256 public selfProjectId;
  uint256 public subscriptionFeeMinimum = 1 ether;
  mapping(uint256 => uint256) public projectSubscriptionBalances;
  uint256[] public subscribedProjectIds;
  
  constructor(
    uint256 _projectId,
    IJBDirectory _directory,
    address _owner
  )
    JBETHERC20ProjectPayer(
      _projectId,
      payable(_owner),
      false,
      '',
      '',
      false,
      _directory,
      _owner
    ) 
  {
    selfProjectId = _projectId;
  }

   error NOT_ENOUGH();

  function subscribe(uint256 _projectId) public payable {
     if (msg.value < subscriptionFeeMinimum) revert NOT_ENOUGH();

     this.topUp{value:msg.value}(_projectId);
     
     subscribedProjectIds.push(_projectId);
  }

  function topUp(uint256 _projectId) public payable {
    projectSubscriptionBalances[_projectId] += msg.value;

     // forward funds to jb project. set the project token beneficiary to be the payer.
    _pay(
      selfProjectId,    // uint256 _projectId
      JBTokens.ETH,     // address _token
      msg.value,        // uint256 _amount
      18,               // uint256 _decimals
      msg.sender,       // address _beneficiary
      0,                // uint256 _minReturnedTokens
      false,            // bool _preferClaimedTokens
      '',               // string memory _metadata
      ''                // bytes calldata _metadata
    );
  }

  function setSelfProject(uint256 _projectId) external onlyOwner {
    selfProjectId = _projectId;
  }

  function supportsInterface(bytes4 interfaceId) public view override(JBETHERC20ProjectPayer) returns (bool) {
    return JBETHERC20ProjectPayer.supportsInterface(interfaceId);
  }
}