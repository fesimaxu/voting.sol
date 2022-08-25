// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract voting {
    // candidate's details
    struct candidate {
        uint256 ID;
        string name;
        uint256 votes;
    }

    // number of candidates starting from 1
    uint256 numcandidates = 1;

    mapping(address => bool) public voters;

    mapping(uint256 => candidate) public candidates;

    candidate[] public candidateList;

    constructor(string memory _name) {
        candidateRegister(_name);
    }

    // register a candidate to be voted for
    function candidateRegister(string memory name) public {
        candidate storage obi = candidates[numcandidates];
        obi.name = name;
        obi.ID = numcandidates;
        obi.votes = 0;

        candidateList.push(obi);

        numcandidates++;
    }

    // gets the details of a particular candidate registered for the election
    function getCandidate(uint256 ID)
        public
        view
        returns (string memory name, uint256 votes)
    {
        name = candidateList[ID].name;
        votes = candidateList[ID].votes;
    }

    // gets the details of all the candidates registered for the election
    function getAllCandidate()
        public
        view
        returns (string[] memory names, uint256[] memory voteCounts)
    {
        names = new string[](numcandidates);
        voteCounts = new uint256[](numcandidates);

        for (uint256 i = 0; i < candidateList.length; i++) {
            names[i] = candidateList[numcandidates].name;
            voteCounts[i] = candidateList[numcandidates].votes;
        }

        return (names, voteCounts);
    }

    // vote for each candidates
    function vote(uint256 ID) external {
        require(!voters[msg.sender], "you have voted");
        require(ID >= 0 && ID <= numcandidates - 1, "Invalid candidates ID");
        candidates[ID].votes++;
    }
}
