Here's a README file for your DegenToken contract that you can use for your GitHub repository:

```markdown
# DegenToken

DegenToken is an ERC20 token contract implemented in Solidity. This contract allows for basic ERC20 token functionalities such as transferring tokens, minting new tokens, burning tokens, and managing allowances. Additionally, it includes a redeem feature where users can redeem tokens for items.

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

### `totalSupply()`

Returns the total supply of the tokens.

```solidity
function totalSupply() external view returns (uint256);
```

### `balanceOf(address account)`

Returns the balance of a specific account.

```solidity
function balanceOf(address account) external view returns (uint256);
```

### `transfer(address to, uint256 value)`

Transfers tokens to another address.

```solidity
function transfer(address to, uint256 value) public returns (bool);
```

### `burn(uint256 value)`

Burns tokens, reducing the total supply.

```solidity
function burn(uint256 value) public returns (bool);
```

### `mint(address to, uint256 value)`

Mints new tokens, increasing the total supply.

```solidity
function mint(address to, uint256 value) public returns (bool);
```

### `getPurchases(address account)`

Returns a list of items purchased (redeemed) by an account.

```solidity
function getPurchases(address account) public view returns (string[] memory);
```

### `redeem(string memory itemName, uint256 value)`

Redeems tokens for items.

```solidity
function redeem(string memory itemName, uint256 value) public;
```

### `allowance(address owner, address spender)`

Returns the remaining number of tokens that `spender` will be allowed to spend on behalf of `owner`.

```solidity
function allowance(address owner, address spender) external view returns (uint256);
```

### `approve(address spender, uint256 value)`

Sets `value` as the allowance of `spender` over the caller’s tokens.

```solidity
function approve(address spender, uint256 value) external returns (bool);
```

### `transferFrom(address from, address to, uint256 value)`

Transfers `value` tokens from `from` to `to`.

```solidity
function transferFrom(address from, address to, uint256 value) external returns (bool);
```

### `changeNameAndSymbol(string memory newName, string memory newSymbol)`

Changes the name and symbol of the token. Only the owner can call this function.

```solidity
function changeNameAndSymbol(string memory newName, string memory newSymbol) public onlyOwner;
```

### `name()`

Returns the name of the token.

```solidity
function name() public view returns (string memory);
```

### `symbol()`

Returns the symbol of the token.

```solidity
function symbol() public view returns (string memory);
```

## Errors

### `InvalidReceiver(address _to)`

Reverts if the recipient address is invalid (address(0)).

### `InsufficientBalance(address from, uint256 fromBalance, uint256 value)`

Reverts if the sender's balance is insufficient.

### `InsufficientAllowance(address spender, address from, uint256 currentAllowance, uint256 value)`

Reverts if the allowance is insufficient.

## License

This project is licensed under the MIT License.
```

You can copy this content into a `README.md` file and add it to your GitHub repository.
