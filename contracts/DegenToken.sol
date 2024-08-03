// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is IERC20 {
    string private _name = "Degen";
    string private _symbol = "DGN";
    address private _owner;
    mapping(address => uint256) private _balances;
    mapping(address => string[]) private _purchases;
    uint256 private _totalSupply = 0;

    mapping(address => mapping(address => uint256)) private _allowances;

    event Burn(address from, uint256 value);
    event Mint(address to, uint256 value);

    struct Item {
        string name;
        uint256 price;
    }

    Item[] private items;

    constructor() {
        _owner = msg.sender;
    }

    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public override returns (bool) {
        if (to == address(0)) {
            revert InvalidReceiver(address(0));
        }
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        if (_balances[sender] < value) {
            revert InsufficientBalance(sender, senderBalance, value);
        }
        _balances[sender] -= value;
        _balances[to] += value;
        emit Transfer(sender, to, value);
        return true;
    }

    function burn(uint256 value) public returns (bool) {
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        if (_balances[sender] < value) {
            revert InsufficientBalance(sender, senderBalance, value);
        }
        _balances[sender] -= value;
        _totalSupply -= value;
        emit Burn(sender, value);
        return true;
    }

    function mint(address to, uint256 value) public returns (bool) {
        require(msg.sender == _owner, "Only owner is allowed to perform this operation"); 
        _balances[to] += value;
        _totalSupply += value;
        emit Mint(to, value);
        return true;
    }

    function purchases(address account) public view returns (string[] memory) {
        return _purchases[account];
    }

    function redeem(uint256 itemId) public {
        require(itemId < items.length, "Item does not exist");
        Item memory item = items[itemId];
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        if (_balances[sender] < item.price) {
            revert InsufficientBalance(sender, senderBalance, item.price);
        }
        _balances[sender] -= item.price;
        _purchases[sender].push(item.name);
        emit Transfer(sender, address(this), item.price);
    }

    function addItem(string memory itemName, uint256 itemPrice) public  {
        require(msg.sender == _owner, "Only owner is allowed to perform this operation"); 
        items.push(Item(itemName, itemPrice));
    }

   function inventory() public view returns (string memory) {
    string memory itemList = "";
    for (uint256 i = 0; i < items.length; i++) {
        string memory indexString = uintToString(i );
        string memory priceString = uintToString(items[i].price);
        itemList = string(abi.encodePacked(itemList, indexString, ". ", items[i].name," (", priceString, ")", i < items.length - 1 ? "\n" : ""));
    }
    return itemList;
}

    function uintToString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer); 
    }


    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) external override returns (bool) {
        address owner = msg.sender;
        uint256 ownerBalance = _balances[owner];
        if (spender == address(0)) {
            revert InvalidReceiver(spender);
        }
        if (ownerBalance < value) {
            revert InsufficientBalance(owner, ownerBalance, value);
        }
        _balances[owner] -= value;
        _allowances[owner][spender] += value;
        emit Approval(owner, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external override returns (bool) {
        address spender = msg.sender;
        uint256 allowanceBalance = _allowances[from][spender];

        if (to == address(0)) {
            revert InvalidReceiver(to);
        }
        if (allowanceBalance < value) {
            revert InsufficientAllowance(spender, from, allowanceBalance, value);
        }
        _allowances[from][spender] -= value;
        _balances[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    error InvalidReceiver(address _to);
    error InsufficientBalance(address from, uint256 fromBalance, uint256 value);
    error InsufficientAllowance(address spender, address from, uint256 currentAllowance, uint256 value);
}
