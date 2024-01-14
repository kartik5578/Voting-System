// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import {Test, console2} from "forge-std/Test.sol";
import {Vote} from "../src/Vote.sol";

contract VoteTest is Test {
    Vote public vote;
    address owner;
    address candidate1;
    address candidate2;
    address voter1;
    address voter2;

    function setUp() public {
        vote = new Vote();
        owner = address(this);
        candidate1 = address(0x1);
        candidate2 = address(0x2);
        voter1 = address(0x3);
        voter2 = address(0x4);
    }

    function test_setCandidate() public{
        vote.setCandidate(candidate1);
        assertEq(vote.candidateAddress(0), candidate1, "Address Does not match");
    }

    function test_registerUser() public{
        vote.registerUser(voter1);
        assertEq(vote.votersAddress(0), voter1, "Voter not added successfully");
    }

    function test_total_registerUser(address voter) public{
        vote.registerUser(voter);
        assertEq(vote.votersAddress(0), voter, "Voter not added successfully");
    }

    function test_vote() public{
        vote.setCandidate(candidate1);
        vote.registerUser(voter1);
        
        vm.prank(address(voter1));
        vote.AddVote(candidate1);

        assertEq(vote.getTotalVotes(candidate1), 1, "Vote not recorded correctly");
        assertTrue(vote.getVoterVoted(voter1), "Voter should be marked as voted");
    }

    function testStartAndStopElection() public {
        vote.startElection();
        assertTrue(vote.electionStatus(), "Election not started correctly");

        vote.stopElection();
        assertFalse(vote.electionStatus(), "Election not stopped correctly");
    }


    function testResult() public {
        vote.setCandidate(candidate1);
        vote.setCandidate(candidate2);
        vote.registerUser(voter1);
        vote.registerUser(voter2);


        vm.prank(address(voter1));
        vote.AddVote(candidate1);
        vm.prank(address(voter2));
        vote.AddVote(candidate1);


        address winner = vote.Result();
        assertEq(winner, candidate1, "Incorrect winner");
    }



    

  
}
