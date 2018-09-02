pragma solidity ^0.4.24;

// This is the Ethtective lucky list, add yourself at http://www.ethtective.com

contract LuckyList {
    
    // You know, at some point we'll do some fancy curved token bonding here
    address owner;
    uint price = 0;//10000000000000000;
    uint list_max = 25;

    uint current_index = 0;
    address[] keys = new address[](25);
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
    function addAddress(string _name, string _logo_ipfs) public payable returns(string) {
        if (msg.value < price) return "Couldn't add because you underpaid";
        Lucky memory newLucky = Lucky(msg.sender, _name, _logo_ipfs);
        //we have a new lucky
        luckyByAddress[msg.sender] = newLucky;
        //add address to keys LUT
        keys[current_index] = msg.sender;
        //increase the indexer
        current_index += 1;
        //and we 
        // price += 10000000000000000;
        if (current_index > list_max)
        {
            current_index = 0;
        }
        if (keys[current_index] != 0)
        {
            delete luckyByAddress[keys[current_index]];
            delete keys[current_index];   
        }
        return "You are on the lucky list!";
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
        if (msg.sender != owner) return;
        msg.sender.transfer(address(this).balance);
    }
    
    function getLucky(uint i) public view returns(address, string, string) 
    {
        Lucky memory temp = luckyByAddress[keys[i]];
        return (temp._address, temp._name, temp._logo_ipfs);
    }
    
    function getIndex() public view returns(uint) 
    {
        return current_index;
    }
    
}