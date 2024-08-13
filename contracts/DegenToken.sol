// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is IERC20 {
    string private _name = "Degen";
    string private _symbol = "DGN";
    address private _owner;
    mapping(address => uint256) private _balances;
    mapping(address => string[]) private _purchases;
    mapping(address => mapping(string => uint256)) private _itemCounts; // Mapping to store the count of items each user has
    uint256 private _totalSupply = 0;

    mapping(address => mapping(address => uint256)) private _allowances;

    struct Item {
        string name;
        uint256 price;
    }

    Item[] private _inventory; // Array to store available items

    event Burn(address from, uint256 value);
    event Mint(address to, uint256 value);
    event ItemAdded(string name, uint256 price);

    constructor() {
        _owner = msg.sender;

        // Initialize the inventory with some items
        _inventory.push(Item("shirt", 10));
        _inventory.push(Item("pent", 8));
        _inventory.push(Item("belt", 5));
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) public returns (bool) {
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

    function getPurchases(address account) public view returns (string[] memory) {
        return _purchases[account];
    }

    function getItemCount(address account, string memory itemName) public view returns (uint256) {
        return _itemCounts[account][itemName];
    }

    function redeem(string memory itemName, uint256 value) public {
        address sender = msg.sender;
        uint256 senderBalance = _balances[sender];
        if (_balances[sender] < value) {
            revert InsufficientBalance(sender, senderBalance, value);
        }

        uint256 itemPrice;
        bool itemFound = false;

        // Find the item price in the inventory
        for (uint256 i = 0; i < _inventory.length; i++) {
            if (keccak256(abi.encodePacked(_inventory[i].name)) == keccak256(abi.encodePacked(itemName))) {
                itemPrice = _inventory[i].price;
                itemFound = true;
                break;
            }
        }

        require(itemFound, "Item not found in inventory");
        require(value == itemPrice, "Incorrect value sent");

        _balances[sender] -= value;
        _purchases[sender].push(itemName);
        _itemCounts[sender][itemName] += 1; // Increase the count of the purchased item

        emit Transfer(sender, address(this), value);
        emit Burn(sender, value);
    }

    function showInventory() public view returns (string memory) {
        string memory inventoryList = "";
        for (uint256 i = 0; i < _inventory.length; i++) {
            inventoryList = string(abi.encodePacked(inventoryList, _inventory[i].name, "(", uint2str(_inventory[i].price), ")"));
            if (i < _inventory.length - 1) {
                inventoryList = string(abi.encodePacked(inventoryList, ", "));
            }
        }
        return inventoryList;
    }

    function addItem(string memory itemName, uint256 itemPrice) public {
        require(msg.sender == _owner, "Only owner can add items to the inventory");
        _inventory.push(Item(itemName, itemPrice));
        emit ItemAdded(itemName, itemPrice);
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) external returns (bool) {
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

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
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

    // Helper function to convert uint256 to string
    function uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint256 j = _i;
        uint256 length;
        while (j != 0) {
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        while (_i != 0) {
            k = k - 1;
            uint8 temp = (48 + uint8(_i - (_i / 10) * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }

    error InvalidReceiver(address _to);

    error InsufficientBalance(address from, uint256 fromBalance, uint256 value);

    error InsufficientAllowance(address spender, address from, uint256 currentAllowance, uint256 value);
}
