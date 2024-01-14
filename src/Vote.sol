// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Vote{

    address   owner;
    uint256 cad_count=0;
    uint256 voter_count =0;
    bool public electionStatus = false;

    struct Candidate{
        uint256 cad_id;
        uint256 total_votes;
        address _address;
    }

    event candidateadded(uint256 indexed  cad_id, uint256 total_votes, address _address);

    address[] public candidateAddress;

    mapping(address => Candidate ) public  candidates;


    address[]   votedVoters;
    address[] public votersAddress;
    mapping (address => Voter) public  voters;

    struct Voter{
        uint256 voter_id;
        address voter_address;
        uint256 voter_allowed;
        bool voter_voted;
    }

    event VoterAdded(
        uint256 indexed  voter_id,
        address voter_address,
        uint256 voter_allowed,
        bool voter_voted);


    constructor(){
        owner = msg.sender;
    }

    function setCandidate(address _address) public {
        require(owner == msg.sender, "You are not a owner");
        
        cad_count++;

        Candidate storage candidate = candidates[_address];

            candidate.cad_id = cad_count;
            candidate.total_votes =0;
            candidate._address=_address;

        candidateAddress.push(_address);
        emit candidateadded(cad_count, candidate.total_votes, _address);
    }

    function registerUser(address _address) public {
        voter_count++;

        Voter storage voter = voters[_address];

        require(voter.voter_allowed == 0, "You are already registed");

        voter.voter_allowed=1;
        voter.voter_id=voter_count;
        voter.voter_voted=false;
        voter.voter_address =_address;

        votersAddress.push(_address);

        emit VoterAdded(voter_count, _address, 1, false);
    }

    function AddVote(address _cadAddress) external{
        Voter storage voter = voters[msg.sender];
        bool present =false;

        for(uint256 i=0; i<candidateAddress.length; i++){
            if(candidateAddress[i]== _cadAddress){
                present= true;
                break;
            }
        }

        require(!voter.voter_voted, "You have already voted");
        require(voter.voter_allowed != 0, "You are not allowed to vote");
        require(present, "Candidate is not registed");
        

        voter.voter_voted = true;
        

        votedVoters.push(msg.sender);


        candidates[_cadAddress].total_votes++;
    }

    function startElection() public {
        require(msg.sender==owner, "Election Can only be start by Owner");
        require(!electionStatus, "Election Is Already going on");

        electionStatus =true;
    }

    function stopElection() public {
        require(msg.sender==owner, "Only owner can stop the election");
        require(electionStatus, "Election is Already stop");

        electionStatus = false;
    }
function Result() public view returns (address) {
    require(!electionStatus, "Cannot show results before the election ends");

    address winner = candidateAddress[0];
    uint256 max = candidates[winner].total_votes;

    for (uint256 i = 1; i < candidateAddress.length; i++) {
        uint256 candidateVotes = candidates[candidateAddress[i]].total_votes;
        if (candidateVotes > max) {
            max = candidateVotes;
            winner = candidateAddress[i];
        }
    }

    return winner;
}

function getTotalVotes(address _address) public view returns (uint256) {
    return candidates[_address].total_votes;
}

function getVoterVoted(address _address) public view returns(bool){
    return voters[_address].voter_voted;
}

}