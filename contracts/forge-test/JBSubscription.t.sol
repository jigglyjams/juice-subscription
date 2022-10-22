pragma solidity ^0.8.16;

import 'forge-std/Test.sol';
import { console } from 'forge-std/console.sol';
import '../JBSubscription.sol';
import '@jbx-protocol/juice-contracts-v3/contracts/interfaces/IJBDirectory.sol';

contract JBSubscriptionTest is Test {
  JBSubscription public subscription;
  address internal _owner = address(this);
  address internal _notOwner = address(1234);

  IJBDirectory public directory = IJBDirectory(0x65572FB928b46f9aDB7cfe5A4c41226F636161ea);

  function setUp() public {
    subscription = new JBSubscription(
      188,
      directory,
      _owner
    );
  }

  function testSetSelfProject() public { 
    subscription.setSelfProject(uint256(99));
  }

  function testFailSetSelfProject() public { 
    vm.prank(_notOwner);
    subscription.setSelfProject(uint256(99));
  }

  function testSubscribe() public {
    subscription.subscribe{value: uint256(1 ether)}(uint256(1));
  }
}