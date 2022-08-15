
// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;


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
    Candidate  candidate1_;
    Candidate  candidate2_;
    event electionResult(string name, uint votes);

    // this function is used by the owner to initialize the candidates, the topic
    function Elected( string memory topics, string memory candidate1, string memory candidate2) public{
        owner = msg.sender;
        candidate1_.name = candidate1;
        candidate2_.name = candidate2;
        topic = topics;

    }


    function voting(uint VoteNumber) public{
        require(msg.sender!=owner, "Owner cannot Vote");
        require(votes[msg.sender].voted== false, "voters can only vote once");
        if(VoteNumber==1){
            candidate1_.voterCount++;
        }else if(VoteNumber==2){
            candidate2_.voterCount++;
        }
        votes[msg.sender].voted= true;
    }


    function end()  public{
        require(msg.sender==owner, "Only authorized people can access");
        emit electionResult(candidate1_.name, candidate1_.voterCount);
        emit electionResult(candidate2_.name, candidate2_.voterCount);

        
    }
    

   
}

