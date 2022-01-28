/*pragma solidity >=0.4.22 <0.8.0;

 contract Election {
 	// what we need to do
 	//modell a candidate
 	struct Candidate {
 		uint id;
 		string name;
 		uint voteCount;
 	}
 	//store candiadte

 	// fetch candidate
           //array of candiate through mapping
 	mapping(uint => Candidate) public candidates;
 	// store candidate count (counter cash)
 	uint public candidatesCount;
 	constructor () public{
 		addCandidate("Candidate 1");
 		addCandidate("Candidate 2");
 		
 	}
 	// now need a function to add candidate    [ local variable start with _na]
 	function addCandidate(string memory _name)private{
 		candidatesCount++; // cause this represnts the id thats why 0+1
 		candidates[candidatesCount]=Candidate(candidatesCount, _name,0);
 	}

 }*/
 pragma solidity 0.4.25;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    // Store accounts that have voted
    mapping(address => bool) public voters;
    // Store Candidates
    // Fetch Candidate
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    // voted event
    event votedEvent (
        uint indexed _candidateId
    );

    constructor () public {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate (string _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}