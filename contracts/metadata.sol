pragma solidity ^0.4.24;

// This is the Ethtective MetaData list, add yourself at http://www.ethtective.com

contract MetaDataStorage {
    
    address owner;
    uint price = 10000000000000000;

    uint current_index = 0;
    address[] public keys;
    mapping(address => MetaData) public adresses; 

    constructor() public {
        owner = msg.sender;
    }
    
    struct MetaData {
        address _address;
        string _name;
        string _logo_ipfs;
    }  
    
    // Add yourself to Ze List Of AweZome! (buy the Dank Mono Font by the way, disclaimer: I am just a user of the font but it has the most porno Z of all programming fonts in existenZ)
    function addAddress(address _address, string _name, string _logo_ipfs) public payable returns(string) {
        require(msg.value >= price, "Couldn't add because you underpaid");
        addInternal(_address, _name, _logo_ipfs);
        return "You are now on the MetaData list!";
    }

    function addByOwner(address _address, string _name, string _logo_ipfs) public {
        assert(msg.sender == owner);
        addInternal(_address, _name, _logo_ipfs);
    }
    
    //function addMultiple(address[] _address, string[] _name, string[] _logo_ipfs) public {
        
    //}

    function addInternal(address _address, string _name, string _logo_ipfs) private {
        MetaData memory newData = MetaData(_address, _name, _logo_ipfs);
        //we have a new MetaData
        adresses[_address] = newData;
        //add address to keys LUT
        keys.push(_address);
        //increase the indexer
        current_index += 1;
    }

    // This is to let the owner remove information about his address that he doesn't like, receives a small refund for his efforts and the sad fact that he's not on the list anymore
    function getMeOffTheFuckingList() public {
        delete adresses[msg.sender];
    }
    
    // This is for me, all of it, it funds my habits
    function lootDonationBox() public
    {
        assert(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
    
    function getByIndex(uint i) public view returns(address, string, string) 
    {
        return (adresses[keys[i]]._address, adresses[keys[i]]._name, adresses[keys[i]]._logo_ipfs);
    }
    
    function getByAddress(address a) public view returns(address, string, string) 
    {
        return (adresses[a]._address, adresses[a]._name, adresses[a]._logo_ipfs);
    }
    
    function setPrice(uint _price) public
    {
        assert(msg.sender == owner);
        price = _price;
    }
    
    function getPrice() public view returns(uint)
    {
        return price;
    }
    
}