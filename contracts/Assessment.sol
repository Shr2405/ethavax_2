// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//import "hardhat/console.sol";

contract Assessment {
    address payable public owner;
    uint256 public Speeding;

    event IncreaseSpeed(uint256 Speed);
    event DecreaseSpeed(uint256 Speed);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        Speeding = initBalance;
    }

    function getBalance() public view returns(uint256){
        return Speeding;
    }

    function Increasespeed(uint256 _Speed) public payable {
        uint _Previous = Speeding;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        Speeding += _Speed;

        // assert transaction completed successfully
        assert(Speeding == _Previous + _Speed);

        // emit the event
        emit IncreaseSpeed(_Speed);
    }

    // custom error
    error InsufficientRating(uint256 Speeding, uint256 Negative);

    function Decreasespeed(uint256 _Negative) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _Previous = Speeding;
        if (Speeding < _Negative) {
            revert InsufficientRating({
                Speeding: Speeding,
                Negative: _Negative
            });
        }

        // DecreaseSpeed the given Speed
        Speeding -= _Negative;

        // assert the Speeding is correct
        assert(Speeding == (_Previous - _Negative));

        // emit the event
        emit DecreaseSpeed(_Negative);
    }
}
