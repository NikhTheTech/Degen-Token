// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DegenToken is IERC20 {
    string private _name;
    string private _symbol;
    address private _owner;
    mapping(address => uint256) private _balances;
    mapping(address => string[]) private _purchases;
    uint256 private _totalSupply = 0;

    mapping(address => mapping(address => uint256)) private _allowances;
    mapping(string => uint256) private _itemPrices; // Mapping to store item prices

    event Burn(address indexed from, uint256 value);
    event Mint(address indexed to, uint256 value);

    constructor(string memory name, string memory symbol) {
        name = "Degen";
        symbol = "DGN";
        _owner = msg.sender;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
        require(to != address(0), "Invalid receiver address");

        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= value, "Insufficient balance");

        _balances[sender] -= value;
        _balances[to] += value;
        emit Transfer(sender, to, value);
        return true;
    }

    function burn(uint256 value) public returns (bool) {
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= value, "Insufficient balance");

        _balances[sender] -= value;
        _totalSupply -= value;
        emit Burn(sender, value);
        return true;
    }

    function mint(address to, uint256 value) public returns (bool) {
        require(msg.sender == _owner, "Only owner can mint tokens");

        _balances[to] += value;
        _totalSupply += value;
        emit Mint(to, value);
        return true;
    }

    function getPurchases(address account) public view returns (string[] memory) {
        return _purchases[account];
    }

    function setItemPrice(string memory itemName, uint256 price) public {
        require(msg.sender == _owner, "Only owner can set item prices");
        _itemPrices[itemName] = price;
    }

    function redeem(string memory itemName) public {
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        uint256 itemPrice = _itemPrices[itemName];
        require(itemPrice > 0, "Item does not exist");
        require(senderBalance >= itemPrice, "Insufficient balance");

        _balances[sender] -= itemPrice;
        _purchases[sender].push(itemName);
        emit Transfer(sender, address(this), itemPrice);
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) external returns (bool) {
        address owner = msg.sender;
        require(spender != address(0), "Invalid spender address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        address spender = msg.sender;
        uint256 allowanceBalance = _allowances[from][spender];
        require(allowanceBalance >= value, "Insufficient allowance");
        require(to != address(0), "Invalid receiver address");

        _allowances[from][spender] -= value;
        _balances[from] -= value;
        _balances[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    // Errors for better gas efficiency
    error InvalidReceiver(address to);
    error InsufficientBalance(address from, uint256 fromBalance, uint256 value);
    error InsufficientAllowance(address spender, address from, uint256 currentAllowance, uint256 value);
}
