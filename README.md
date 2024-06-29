# DegenToken

DegenToken is an ERC20 token contract implemented in Solidity. This contract allows for basic ERC20 token functionalities such as transferring tokens, minting new tokens, burning tokens, and managing allowances. Additionally, it includes a redeem feature where users can redeem tokens for items.

## Table of Contents

- [Features](#features)
- [Deployment](#deployment)
- [Functions](#functions)
  - [totalSupply()](#totalsupply)
  - [balanceOf(address account)](#balanceofaddress-account)
  - [transfer(address to, uint256 value)](#transferaddress-to-uint256-value)
  - [burn(uint256 value)](#burnuint256-value)
  - [mint(address to, uint256 value)](#mintaddress-to-uint256-value)
  - [getPurchases(address account)](#getpurchasesaddress-account)
  - [redeem(string memory itemName, uint256 value)](#redeemstring-memory-itemname-uint256-value)
  - [allowance(address owner, address spender)](#allowanceaddress-owner-address-spender)
  - [approve(address spender, uint256 value)](#approveaddress-spender-uint256-value)
  - [transferFrom(address from, address to, uint256 value)](#transferfromaddress-from-address-to-uint256-value)
  - [changeNameAndSymbol(string memory newName, string memory newSymbol)](#changenameandsymbolstring-memory-newname-string-memory-newsymbol)
  - [name()](#name)
  - [symbol()](#symbol)
- [Errors](#errors)
  - [InvalidReceiver(address _to)](#invalidreceiveraddress-_to)
  - [InsufficientBalance(address from, uint256 fromBalance, uint256 value)](#insufficientbalanceaddress-from-uint256-frombalance-uint256-value)
  - [InsufficientAllowance(address spender, address from, uint256 currentAllowance, uint256 value)](#insufficientallowanceaddress-spender-address-from-uint256-currentallowance-uint256-value)
- [Connecting to Avalanche with Hardhat](#connecting-to-avalanche-with-hardhat)
  - [Introduction](#introduction)
  - [Prerequisites](#prerequisites)
  - [Why Avalanche and Hardhat?](#why-avalanche-and-hardhat)
  - [Folder Structure](#folder-structure)
  - [Setup and Configuration](#setup-and-configuration)
  - [Deploying Smart Contracts](#deploying-smart-contracts)
- [License](#license)

## Features

- **Total Supply:** Retrieve the total supply of the tokens.
- **Balance Of:** Retrieve the balance of a specific account.
- **Transfer:** Transfer tokens to another address.
- **Burn:** Burn tokens, reducing the total supply.
- **Mint:** Mint new tokens, increasing the total supply.
- **Approve:** Approve another address to spend tokens on behalf of the owner.
- **Transfer From:** Transfer tokens from one address to another, using allowance.
- **Get Purchases:** Retrieve a list of items purchased (redeemed) by an account.
- **Redeem:** Redeem tokens for items.

## Deployment

The contract can be deployed with the following command:

```solidity
constructor() {
    _name = "Degen";
    _symbol = "DGN";
    _owner = msg.sender;
}
```

## Functions

### totalSupply()

Returns the total supply of the tokens.

```solidity
function totalSupply() external view returns (uint256);
```

### balanceOf(address account)

Returns the balance of a specific account.

```solidity
function balanceOf(address account) external view returns (uint256);
```

### transfer(address to, uint256 value)

Transfers tokens to another address.

```solidity
function transfer(address to, uint256 value) public returns (bool);
```

### burn(uint256 value)

Burns tokens, reducing the total supply.

```solidity
function burn(uint256 value) public returns (bool);
```

### mint(address to, uint256 value)

Mints new tokens, increasing the total supply.

```solidity
function mint(address to, uint256 value) public returns (bool);
```

### getPurchases(address account)

Returns a list of items purchased (redeemed) by an account.

```solidity
function getPurchases(address account) public view returns (string[] memory);
```

### redeem(string memory itemName, uint256 value)

Redeems tokens for items.

```solidity
function redeem(string memory itemName, uint256 value) public;
```

### allowance(address owner, address spender)

Returns the remaining number of tokens that `spender` will be allowed to spend on behalf of `owner`.

```solidity
function allowance(address owner, address spender) external view returns (uint256);
```

### approve(address spender, uint256 value)

Sets `value` as the allowance of `spender` over the caller’s tokens.

```solidity
function approve(address spender, uint256 value) external returns (bool);
```

### transferFrom(address from, address to, uint256 value)

Transfers `value` tokens from `from` to `to`.

```solidity
function transferFrom(address from, address to, uint256 value) external returns (bool);
```

### changeNameAndSymbol(string memory newName, string memory newSymbol)

Changes the name and symbol of the token. Only the owner can call this function.

```solidity
function changeNameAndSymbol(string memory newName, string memory newSymbol) public onlyOwner;
```

### name()

Returns the name of the token.

```solidity
function name() public view returns (string memory);
```

### symbol()

Returns the symbol of the token.

```solidity
function symbol() public view returns (string memory);
```

## Errors

### InvalidReceiver(address _to)

Reverts if the recipient address is invalid (address(0)).

### InsufficientBalance(address from, uint256 fromBalance, uint256 value)

Reverts if the sender's balance is insufficient.

### InsufficientAllowance(address spender, address from, uint256 currentAllowance, uint256 value)

Reverts if the allowance is insufficient.

## Connecting to Avalanche with Hardhat

### Introduction

Welcome to the guide on connecting to Avalanche, a high-performance blockchain platform, using Hardhat, a popular development environment for Ethereum smart contracts. This guide will walk you through the necessary steps to get started, deploy smart contracts, and interact with the Avalanche ecosystem.

### Prerequisites

Before you begin, ensure you have the following prerequisites:

- Node.js installed (version X.X.X or higher)
- Basic knowledge of Ethereum and smart contracts
- Familiarity with the command line interface (CLI)

### Why Avalanche and Hardhat?

Avalanche is a next-generation blockchain platform that provides high scalability, low fees, and fast transaction finality. It offers a rich ecosystem for building decentralized applications, DeFi protocols, and various other use cases. Avalanche's flexibility, interoperability, and robustness make it an attractive choice for developers.

Hardhat is a powerful development environment for Ethereum smart contracts. While it is primarily designed for Ethereum, it can be configured to work seamlessly with Avalanche. Hardhat offers advanced features like testing, debugging, and deployment automation, making it an ideal choice for Avalanche development.

### Folder Structure

Before we dive into the setup process, let's take a look at the recommended folder structure for your Avalanche project:

```
├── contracts/            # Contains your smart contracts
├── scripts/              # Deployment and interaction scripts
├── test/                 # Test cases for your smart contracts
├── hardhat.config.js     # Hardhat configuration file
├── README.md             # Project documentation
└── ...
```

This structure helps organize your project and separates the different components of your Avalanche development workflow.

### Setup and Configuration

#### Step 1: Project Setup

Create a new folder for your project and navigate into it:

```sh
$ mkdir my-avalanche-project
$ cd my-avalanche-project
```

Initialize the project and install Hardhat as a development dependency:

```sh
$ npm init -y
$ npm install --save-dev hardhat
```

Initialize your Hardhat project:

```sh
$ npx hardhat
```

Select the option `Create a JavaScript project`. This will generate a Hardhat config file (e.g., `hardhat.config.js`).

Install the Hardhat Toolbox plugin:

```sh
$ npm i --save-dev @nomicfoundation/hardhat-toolbox
```

#### Step 2: Project Configuration

Modify your `hardhat.config.js` file to include Avalanche configurations:

```js
require("@nomicfoundation/hardhat-toolbox");

const FORK_FUJI = false;
const FORK_MAINNET = false;
let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: "https://api.avax.network/ext/bc/C/rpcc",
 

 };
}
if (FORK_FUJI) {
  forkingData = {
    url: "https://api.avax-test.network/ext/bc/C/rpc",
  };
}

module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {
      gasPrice: 225000000000,
      chainId: !forkingData ? 43112 : undefined,
      forking: forkingData,
    },
    fuji: {
      url: 'https://api.avax-test.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43113,
      accounts: [
        // YOUR PRIVATE KEY HERE
      ],
    },
    mainnet: {
      url: 'https://api.avax.network/ext/bc/C/rpc',
      gasPrice: 225000000000,
      chainId: 43114,
      accounts: [
        // YOUR PRIVATE KEY HERE
      ],
    },
  },
};
```

Replace `YOUR PRIVATE KEY HERE` with your actual private key for the desired network.

### Deploying Smart Contracts

In the `scripts/` directory, create a deployment script, e.g., `deploy.js`. Use the following template:

```js
const hre = require("hardhat");

async function main() {
  const contractName = "YOUR CONTRACT NAME";
  const contract = await hre.ethers.deployContract(contractName);

  await contract.waitForDeployment();

  console.log(`Contract Deployed to address ${await contract.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

Run the deployment script on the desired network:

```sh
$ npx hardhat run scripts/deploy.js --network fuji
```

Ensure you have some AVAX tokens in your account before deploying the contract on Avalanche.
