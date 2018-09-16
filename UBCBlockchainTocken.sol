pragma solidity ^0.4.20;

interface ERC20 {
    function totalSupply() public view returns (uint _totalSupply);
    function balanceOf(address _owner) public view returns (uint balance);
    function transfer(address _to, uint _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint _value) public returns (bool success);
    function approve(address _spender, uint _value) public returns (bool success);
    function allowance(address _owner, address _spender) public returns (uint remaining);
    event Transfer(address indexed _from, address indexed _to, uint _value);
    event Approval(address indexed _owner, address indexed _spender, uint _value);
}

contract UBCBlockchainTocken is ERC20 {
    
    string public constant symbol = "UBCT";
    string public constant name = "UBC Blockchain Club Token" ;
    uint8 public constant decimals = 0;
    address private creator;
    
    
    uint private constant __totalSupply = 1000000000;
    
    enum AccountType { LEADER, EXEC, MEMBER, EXTERNAL }

    mapping (address => AccountType) public accountTypes; 
    mapping (address => uint) private __balanceOf;
    mapping (address => mapping(address =>uint)) private __allowances;
    
    function UBCBlockchainTocken() public {
        __balanceOf[msg.sender] = 1;
        accountTypes[creator] = AccountType.EXEC;
        creator = msg.sender;
    }

    function totalSupply() public view returns (uint _totalSupply) {
        _totalSupply = __totalSupply;
        return _totalSupply;
    }
    
    function balanceOf(address _addr) public view returns (uint balance) {
        return __balanceOf[_addr];
    }
    
    function transfer(address _to, uint _value) public returns (bool success) {
        // One
        require(_value == 1, 'Only 1 person can have and transfer 1 membership');

        if (_value <= balanceOf(msg.sender)&& balanceOf(_to) == 0)  {
            __balanceOf[msg.sender] -= _value;
            __balanceOf[_to] += _value;
            return true;
        }
        return false;
    }
    
    function transferFrom(address _from, address _to, uint _value) public returns (bool success){
        // Ensure that only the creator of the contract can send this.
        require (creator == msg.sender);
        require(_value == 1, 'Only 1 person can have and transfer 1 membership');

        if(__allowances[_from][msg.sender]>0 &&_value >0 &&__allowances[_from][msg.sender]>=_value){
             __balanceOf[_from] -= _value;
             __balanceOf[_to] += _value;
             return true;
        }
        return false;
    }
    function approve(address _spender, uint _value) public returns (bool success){
        require (creator == msg.sender);
        __allowances[msg.sender][_spender] = _value;
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint remaining){
        require (creator == msg.sender);
        return __allowances[_owner][_spender];
    }
    

}
