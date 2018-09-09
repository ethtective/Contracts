pragma solidity ^0.4.24;

// This is the Ethtective lucky list, add yourself at http://www.ethtective.com

contract LuckyList {
    
    address owner;
    uint price = 40000000000000000;
    uint priceIncrease = 40000000000000000;
    uint list_max = 100;

    uint current_index = 0;
    bool wrapped = false;
    address[] public keys;
    mapping(address => Lucky) public luckyByAddress; 

    constructor() public {
        owner = msg.sender;
    }
    
    struct Lucky {
        address _address;
        bool exists;
        bool removed;
    }  
    
    // Add yourself to Ze List Of AweZome! (buy the Dank Mono Font by the way, disclaimer: I am just a user of the font but it has the most porno Z of all programming fonts in existenZ)
    function addAddress(address _address) public payable returns(string) {
        require(msg.value >= price, "Couldn't add because you underpaid.");
        require(luckyByAddress[_address].exists != true, "Come on, you already submitted.");
        //we have a new lucky
        price += priceIncrease;
        addInternal(_address);
        return "You are now on the lucky list!";
    }
    
    
    // Add yourself to Ze List Of AweZome! (buy the Dank Mono Font by the way, disclaimer: I am just a user of the font but it has the most porno Z of all programming fonts in existenZ)
    function addAddressAdmin(address[] _addresses) public payable returns(string) {
        assert(msg.sender == owner);
        for(uint i = 0; i < _addresses.length; i++)
        {
            addInternal(_addresses[i]);
        }
        return "You are now on the lucky list!";
    }
    
    function addInternal(address _address) private {
        Lucky memory newLucky = Lucky(_address, true, false);
        luckyByAddress[_address] = newLucky;
        keys.push(_address);
        //increase the indexer
        current_index += 1;
    }

    // This is to let the owner remove information about his address that he doesn't like
    function getMeOffTheFuckingList() public {
        if (luckyByAddress[msg.sender].exists == true)
        {
              luckyByAddress[msg.sender].removed = true;
        }
        //we could fix the array now, but we don't give a fuck
        //we just want to get him off the motherfucking list
    }
    
    // This is for me, all of it, it funds my habits
    function lootDonationBox() public
    {
        assert(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
    
    function getLucky(uint i) public view returns(address) 
    {
        return (luckyByAddress[keys[i]]._address);
    }
    
    function getAddress(address a) public view returns(address) 
    {
        return (luckyByAddress[a]._address);
    }
    
    function setPrice(uint _price) public
    {
        assert(msg.sender == owner);
        price = _price;
    }
    
    function getIndex() public view returns(uint) 
    {
        return current_index;
    }
    
    function getPrice() public view returns(uint)
    {
        return price;
    }
    
}