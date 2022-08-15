
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

//Here instead of creating two different structures, we are going to use array of structures

contract Election{
    struct Candidate{
        string name;
        uint voterCount;
    }

    struct Voter{
        uint voterID;
        bool voted;

    }

    address public owner;
    mapping(address=>Voter) votes;
    string topic;
    Candidate[] public Candidates;
    event electionResult(string name, uint votes);

    // this function is used by the owner to initialize the candidates, the topic
    function Elected( string memory topics, string memory candidate1) public{
        owner = msg.sender;
        topic = topics;
        Candidate memory tempCandidate;
        tempCandidate.name = candidate1;
        Candidates.push(tempCandidate);

    }


    function voting(uint VoteNumber) public{
        require(msg.sender!=owner, "Owner cannot Vote");
        require(votes[msg.sender].voted== false, "voters can only vote once");
        if(VoteNumber==1){
            Candidates[0].voterCount++;
        }else if(VoteNumber==2){
            Candidates[1].voterCount++;
        }
        votes[msg.sender].voted= true;
    }


    function end()  public{
        require(msg.sender==owner, "Only authorized people can access");
        for(uint i=0;i<Candidates.length;i++){
            emit electionResult(Candidates[i].name, Candidates[i].voterCount);
        }
        
    }
    

   
}


