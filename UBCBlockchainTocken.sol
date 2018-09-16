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

    mapping (address => AccountType) public accountType;
    mapping (address => uint) private _balanceOf;
    
    function UBCBlockchainTocken() public {
        _balanceOf[msg.sender] = __totalSupply;
        accountType[creator] = AccountType.LEADER;
        creator = msg.sender;
    }

    function totalSupply() public view returns (uint _totalSupply) {
        _totalSupply = __totalSupply;
        return _totalSupply;
    }

    function balanceOf(address _addr) public view returns (uint balance) {
        return _balanceOf[_addr];
    }
    
    function issue (address to, uint value, AccountType type) public { 
        require(accountType[msg.sender] == AccountType.LEADER, "Only the leader can issue token");

        // Create the membership
        _balanceOf[to] = 1;
        accountType[to] = type;

        // If leadership is being issued, we must remove current leadership.
        if (type == AccountType.LEADER) {
            accountType[msg.sender] = AccountType.EXTERNAL;
        }
    }

    function transfer(address _to, uint _value) public returns (bool success) {
        // We're allowing transferring memberships, for now.
        _balanceOf[_to] = 1;
        // If the membership is transferred to you, you are an external.
        accountType[_to] = AccountType.EXTERNAL;
        // Delete the current member as member.
        _balanceOf[_to] = 0;
        accountType[msg.sender] = AccountType.EXTERNAL;
    }
    
    function transferFrom(address _from, address _to, uint _value) public returns (bool success){
        return false;
    }

    function approve(address _spender, uint _value) public returns (bool success){
        return false;
    }

    function allowance(address _owner, address _spender) public returns (uint remaining){
        return false;
    }
    
}
