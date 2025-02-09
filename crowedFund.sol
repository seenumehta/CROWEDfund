//SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.5.0 < 0.9.0;

contract crowedFunding{
    mapping (address => uint) public contributors;
    address public manager;
    uint public minimumContribution;
    uint public deadline;
    uint public  target;
    uint public raisedAmount;
    uint public noOfContributor; //for voting purpose on withdrawel

    struct Request{
        string descript;
        address payable recipitent;
        uint value;
        bool completed;
        uint noOFvoters;
        mapping (address=>bool) voters;
    }
    mapping (uint=>Request) public requests;
    uint public  numRequest;

    constructor(uint _target, uint _deadline) {
         target = _target;
         deadline = block.timestamp + _deadline; //10sec + 3600sec (60*60) sec = 1 hours just for understanding for this line
         minimumContribution = 100 wei;
         manager = msg.sender;
        

    }
    function sendETH() public payable{
        require(block.timestamp < deadline , "Deadline is cross ,contract not exist");
        require(msg.value >= minimumContribution, "MINIMUM CONTRI not MET");
        if(contributors[msg.sender] == 0){
            noOfContributor++ ;
    
        }
        contributors[msg.sender] += msg.value;
        raisedAmount += msg.value ;

    }
    function getContractBalance() public view returns (uint){
        return address(this).balance;

    }
    // now refund if anycontributors want or in condition of eth not collected enogh on deadline 
    function refund() public {

        require(block.timestamp > deadline && raisedAmount < target , "refund not available cuz time and money both have left");
        require(contributors[msg.sender] > 0);

        address payable user = payable(msg.sender);
        user.transfer(contributors[msg.sender]);
        contributors[msg.sender] = 0;

    }
    //function for manageer
    modifier onlyManager() {
        require (manager == msg.sender, "Only Manager canperform this action");
        _;}
    function createRequests(string memory _description ,address payable _recipitent , uint _value) public onlyManager{
        Request storage newRequest = requests[numRequest];
        numRequest++ ;

        newRequest.descript = _description ;
        newRequest.recipitent = _recipitent ;
        newRequest.value = _value ;
        newRequest.completed = false ;
        newRequest.noOFvoters = 0;
    }

    //function for voting
     function voteRequest(uint _requestNo) public{
        require(contributors[msg.sender]>0,"YOu must be contributor");
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.voters[msg.sender]==false,"You have already voted");
        thisRequest.voters[msg.sender]=true;
        thisRequest.noOFvoters;
    }
    //function for payment
      function makePayment(uint _requestNo) public onlyManager{
        require(raisedAmount>=target);
        Request storage thisRequest=requests[_requestNo];
        require(thisRequest.completed==false,"The request has been completed");
        require(thisRequest.noOFvoters > noOfContributor/2,"Majority does not support");
        thisRequest.recipitent.transfer(thisRequest.value);
        thisRequest.completed=true;
    }

}