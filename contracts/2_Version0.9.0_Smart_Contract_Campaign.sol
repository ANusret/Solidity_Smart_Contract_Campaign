// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract CampaignFactory {

    Campaign[] public publishedCampaigns;

    function createCampaign(uint256 _mini) public {
        Campaign newCampaign = new Campaign(_mini, msg.sender);
        publishedCampaigns.push(newCampaign);
    }

    function getPublishedCampaigns() public view returns (Campaign[] memory) {
        return publishedCampaigns;
    }

}

contract Campaign {

    struct Request {
        string description;
        uint256 value;
        address payable recipient;
        bool complete;
        uint256 acceptCount;
        mapping(address => bool) acceptorsAccount;
    }

    mapping(uint256 => Request) public requests;
    uint256 numRequests;

    address public manager;
    uint256 public minimumContribution;
    mapping(address => bool) public subscribers;
    uint256 public subscribersCount;
    
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

    constructor(uint256 minimum, address creator) {
        manager = creator;
        minimumContribution = minimum;
    }

    function contribute() public payable checkContribution {
        subscribers[msg.sender] = true;
        subscribersCount++;
    }

    function createRequest(string memory _description, uint256 _value, address payable _recipient) public checkManager {
        Request storage thisRequest = requests[numRequests++];
        thisRequest.description = _description;
        thisRequest.value = _value;
        thisRequest.recipient = _recipient;
        thisRequest.complete = false;
        thisRequest.acceptCount = 0;
    }

    function acceptRequest(uint256 _index) public checkSubscribers checkComplete(_index) {
        Request storage thisRequest = requests[_index];
        require(!thisRequest.acceptorsAccount[msg.sender]);

        thisRequest.acceptorsAccount[msg.sender] = true;
        thisRequest.acceptCount++;
    }

    function finalizeRequest(uint256 _index) public checkManager checkComplete(_index) {
        Request storage thisRequest = requests[_index];
        require(thisRequest.acceptCount > (subscribersCount / 2));

        thisRequest.recipient.transfer(thisRequest.value);
        thisRequest.complete = true;
    }

}