# CrowedFunding Smart Contract

## Overview
CrowedFunding is a decentralized crowdfunding smart contract built on Solidity. It allows contributors to donate Ether towards a funding goal, with features such as refunds, fund withdrawal with voting, and transparent fund management.

## Features
- **Minimum Contribution**: Contributors must donate at least 100 wei.
- **Deadline and Target**: The campaign has a set deadline and funding target.
- **Refund System**: If the target is not met by the deadline, contributors can request a refund.
- **Manager Role**: The manager creates fund withdrawal requests.
- **Voting Mechanism**: Contributors vote on withdrawal requests to ensure transparency.
- **Secure Payments**: Funds are transferred only when the majority approves the request.

## Smart Contract Functions
### 1. `sendETH()`
Allows users to contribute ETH to the campaign.
```solidity
function sendETH() public payable
```
- Requires the contribution to be above the minimum.
- Updates the raised amount.

### 2. `getContractBalance()`
Returns the current balance of the contract.
```solidity
function getContractBalance() public view returns (uint)
```

### 3. `refund()`
Allows contributors to withdraw their funds if the target is not met by the deadline.
```solidity
function refund() public
```
- Only works if the campaign fails.

### 4. `createRequests()`
Manager creates a request to withdraw funds.
```solidity
function createRequests(string memory _description ,address payable _recipitent , uint _value) public onlyManager
```
- Requires manager role.

### 5. `voteRequest()`
Contributors vote on fund withdrawal requests.
```solidity
function voteRequest(uint _requestNo) public
```
- Ensures only contributors can vote.
- Prevents double voting.

### 6. `makePayment()`
Allows the manager to execute a payment after receiving majority votes.
```solidity
function makePayment(uint _requestNo) public onlyManager
```
- Requires approval from more than 50% of contributors.

## Deployment
1. Compile the contract using Remix or Hardhat.
2. Deploy on Ethereum, Polygon, or Binance Smart Chain.
3. Interact using Web3.js, Ethers.js, or a frontend.

## Repository
[GitHub Repository](https://github.com/seenumehta/CROWEDfund.git)

## License
SPDX-License-Identifier: UNLICENSED

## Author
Developed by [Anoop](https://github.com/seenumehta)

