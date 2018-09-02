pragma solidity ^0.4.24;

// This is the Ethtective lucky list, add yourself at http://www.ethtective.com

contract LuckyList {
    
    // You know, at some point we'll do some fancy curved token bonding here
    address owner;
    uint price = 40000000000000000;
    uint list_max = 100;

    uint current_index = 0;
    bool wrapped = false;
    address[] keys = new address[](100);
    mapping(address => Lucky) luckyByAddress; 

    constructor() public {
        owner = msg.sender;
    }
    
    struct Lucky {
        address _address;
        string _name;
        string _logo_ipfs;
    }  
    
    // Add yourself to Ze List Of AweZome! (buy the Dank Mono Font by the way, disclaimer: I am just a user of the font but it has the most porno Z of all programming fonts in existenZ)
    function addAddress(address _address, string _name, string _logo_ipfs) public payable returns(string) {
        if (owner != msg.sender)
        {
            require(msg.value >= price, "Couldn't add because you underpaid");
        }
        else
        {
            price += 40000000000000000;
        }
        Lucky memory newLucky = Lucky(_address, _name, _logo_ipfs);
        //we have a new lucky
        luckyByAddress[_address] = newLucky;
        //add address to keys LUT
        keys[current_index] = _address;
        price += 40000000000000000;
        //increase the indexer
        current_index += 1;
        if (current_index >= list_max)
        {
            current_index = 0;
            wrapped = true;
        }
        return "You are now on the lucky list!";
    }
    

    // This is to let the owner remove information about his address that he doesn't like, receives a small refund for his efforts and the sad fact that he's not on the list anymore
    function getMeOffTheFuckingList() public {
        delete luckyByAddress[msg.sender];
        //we could fix the array now, but we don't give a fuck
        //we just want to get him off the motherfucking list
    }
    
    // This is for me, all of it, it funds my habits
    function lootDonationBox() public
    {
        assert(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
    
    function getLucky(uint i) public view returns(address, string, string) 
    {
        return (luckyByAddress[keys[i]]._address, luckyByAddress[keys[i]]._name, luckyByAddress[keys[i]]._logo_ipfs);
    }
    
    function getAddress(address a) public view returns(address, string, string) 
    {
        return (luckyByAddress[a]._address, luckyByAddress[a]._name, luckyByAddress[a]._logo_ipfs);
    }
    
    function setPrice(uint _price) public
    {
        assert(msg.sender == owner);
        price = _price;
    }
    
    function getIndexAndLength() public view returns(uint, bool) 
    {
        return (current_index, wrapped);
    }
    
    function getPrice() public view returns(uint)
    {
        return price;
    }
    
}