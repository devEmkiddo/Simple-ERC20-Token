// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Token{
   address public _owner;

   string public name = "My Token";
   string public symbol = "MTK";

   uint8 public _decimal = 9;
   uint256 public _totalSupply = 1000000 * 10**_decimal;

   mapping(address => uint256) public _balanceOf;
   mapping(address => mapping(address => uint256)) public _allowances;

   event Transfer(
    address indexed from,
    address indexed to,
    uint256 value
   );

   event Approval(
     address spender,
     uint256 value
   );

   constructor(){
    _owner = msg.sender;
    _balanceOf[_owner] = _totalSupply;
   }
   
   function transfer(address _to, uint256 amount) public returns(bool){
    require(_balanceOf[msg.sender] >= amount, "Insufficient balance");
    _balanceOf[msg.sender] -= amount;
    _balanceOf[_to] += amount;
    emit Transfer(msg.sender, _to, amount);
    return true;
   }

   function transferFrom(address _from, address _to, uint256 amount)public returns (bool){
    require(_allowances[_from][_to] > amount, "Insufficient allowance");
    _balanceOf[_from] -= amount;
    _balanceOf[_to] += amount;
    _allowances[_from][_to] -= amount;
    emit Transfer(_from, _to, amount);
    return true;
   }

   function approve(address spender, uint256 amount) public returns(bool){
      _allowances[msg.sender][spender] = amount;
      return true;
   }
 }
