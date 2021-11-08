// SPDX-License-Identifier: GPL-3.int208

pragma solidity >=0.8.9;

contract russianRoulette {
    player[] public players;
    player[] public losers;
    uint256 public odds;
    uint256 public turn;
    address public owner;
    
    struct player {
        address loc;
        bool isAlive;
    }
    
    constructor (){
        owner = msg.sender;
        turn = 0;
    }
    
    function setOdds (uint256 newOdds) public {
        require (msg.sender == owner, "Caller is not owner");
        odds = newOdds;
    }
    
    function addPlayer (address newPlayer) view public {
        for (uint256 i = 0; i < players.length; i++) {
            require (players[i].loc != newPlayer);
        }
        for (uint256 i = 0; i < losers.length; i++) {
            require (losers[i].loc != newPlayer);
        }
        
    }
    
    function isLoser (address newPlayer) public view returns (bool) {
        for (uint256 i = 0; i < losers.length; i++) {
            require (losers[i].loc != newPlayer);
        }
        return true;
    }
    
    function genRandom () public view returns (uint256) {
        return block.timestamp%751;
    }
    
    function lose (player memory loser) private {
        loser.isAlive = false;
        delete players;
        losers.push(loser); 
        turn = 0;
    }
    
    function play () public {
        uint256 num = genRandom();
        player memory nextUp = players[turn];
        if (turn == num) {
            lose(nextUp);
        }
        else {
            turn++;
        }
    }
}