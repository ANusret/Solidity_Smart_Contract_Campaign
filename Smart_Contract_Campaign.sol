pragma solidity ^0.4.17;

contract CampaignFactory{

    address[] public publishedCampaign;

    function craeteCampaign(uint _mini) public {
        address newCampaign = new Campaign(_mini, msg.sender);
        publishedCampaign.push(newCampaign);
    }

    function getPublishedCampaign() public view returns(address[]) {
        return publishedCampaign;
    }

}

contract Campaign {

    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
        uint acceptCount;
        mapping(address => bool) acceptorsAccount;
    }

    Request[] public requests;

    address public manager;
    uint public minimumContribution;
    mapping(address => bool) public subscribers;
    uint public subscribersCount;

    modifier checkManager() {
        require(msg.sender == manager);
        _;
    }

    modifier checkContribution() {
        require(msg.value >= minimumContribution);
        _;
    }

    modifier checkSubscribers(){
        require(subscribers[msg.sender]);
        _;
    }

    modifier checkComplete(uint _index){
        require(!requests[_index].complete);
        _;
    }

    constructor(uint _mini, address _owner) public {
        manager = _owner;
        minimumContribution = _mini;
    }
 
    function contribute() public payable checkContribution {
        subscribers[msg.sender] = true;
        subscribersCount++;
    }

    function createRequest(string _description, uint _value, address _recipient)
        public checkManager{
            Request memory newRequest = Request({
                description: _description,
                value: _value,
                recipient: _recipient,
                complete: false,
                acceptCount: 0
            });   
            //Request newRequest = Request(description, value, recipient, false); //şeklinde de tanımlanabilir.
            //Ancak yukarıdaki tanımlama tipini tavsiye etmiyorum çünkü ileride struct yapısı içerisinde yaptığımız,
            //en küçük bir değişiklikte, yer değiştirmeler dahil, bu yapı ile yazdığımız bütün satırları kontrol etmemiz
            //ve güncellememiz gerekecektir.

            requests.push(newRequest);
    }

    function acceptRequest(uint _index) public checkSubscribers checkComplete(_index){
        Request storage thisRequest = requests[_index];
        require(!thisRequest.acceptorsAccount[msg.sender]);
        
        thisRequest.acceptorsAccount[msg.sender] = true;
        thisRequest.acceptCount++;
    }

    function finalizeRequest(uint _index) public payable checkManager checkComplete(_index){
        Request storage thisRequest = requests[_index];
        require(thisRequest.acceptCount > ( subscribersCount / 2 )); // (subscribers / 100) * 51; // fazla gas harcayacağı için kullanamak istemedim

        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.complete = true;
    }

}