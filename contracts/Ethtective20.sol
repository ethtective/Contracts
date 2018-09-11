pragma solidity ^0.4.24;

import "../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";

// This is the Ethtective MetaData Cafe contract, add your own metametametadata at http://cafe.ethtective.com

contract MetaDataStorage is ERC721Token {
    
    address owner;
    uint price = 13000000000000000;

    uint currentIndex = 0;
    address[] public keys;
    mapping(uint => MetaData) public history; 
    mapping(address => MetaData) public adresses; 

    event Submission (
        address _address,
        string _name,
        uint _index
    );

    constructor() public ERC721Token(_name, _symbol) {
        owner = msg.sender;
        string memory _name = "Metadata Token Holder";
        string memory _symbol = "METH";
    }
    
    struct MetaData {
        address _address;
        string _name;
        string _ipfs;
    }  
    
    // Add yourself to Ze List Of AweZome! (buy the Dank Mono Font by the way, disclaimer: I am just a user of the font but it has the most porno Z of all programming fonts in existenZ)
    function addAddress(address _address, string _name, string _ipfs) public payable returns(string) {
        require(msg.value >= price, "Couldn't add because you underpaid");
        mintUniqueTokenTo(msg.sender, currentIndex, _name);
        addInternal(_address, _name, _ipfs);
        return "You are now on the MetaData list, and you have a shiny curation token to show for it!!";
    }

    function addByOwner(address _address, string _name, string _ipfs) public {
        assert(msg.sender == owner);
        mintUniqueTokenTo(msg.sender, currentIndex, _name);
        addInternal(_address, _name, _ipfs);
    }

    function addInternal(address _address, string _name, string _ipfs) private {
        MetaData memory newData = MetaData(_address, _name, _ipfs);
        //we have a new MetaData
        adresses[_address] = newData;
        history[currentIndex] = newData;
        //add address to keys LUT
        keys.push(_address);
        //increase the indexer
        emit Submission(_address, _name, currentIndex);
        currentIndex += 1;
    }

    function populate(address _original) public {
        assert(msg.sender == owner);
        MetaDataStorage original = MetaDataStorage(_original);
        for(uint i=0; i<original.getCurrentIndex(); i++)
        {
            (address _address,string memory _name,string memory _ipfs) = original.getByIndex(i);
            addInternal(_address,_name,_ipfs);
        }
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
        return (adresses[keys[i]]._address, adresses[keys[i]]._name, adresses[keys[i]]._ipfs);
    }
    
    function getByAddress(address a) public view returns(address, string, string) 
    {
        return (adresses[a]._address, adresses[a]._name, adresses[a]._ipfs);
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

    function getCurrentIndex() public view returns(uint) {
        return currentIndex;
    }

    function mintUniqueTokenTo(
        address _to,
        uint256 _tokenId,
        string  _tokenURI
    ) public
    {
        super._mint(_to, _tokenId);
        super._setTokenURI(_tokenId, _tokenURI);
    }
    
}