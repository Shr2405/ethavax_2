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

    function Incresespeed(uint256 _Speed) public payable {
        uint _PreviousSpeed = Speeding;

        // make sure this is the owner
        require(msg.sender == owner, "You are not the owner of this account");

        // perform transaction
        Speeding += _Speed;

        // assert transaction completed successfully
        assert(Speeding == _PreviousSpeed + _Speed);

        // emit the event
        emit IncreaseSpeed(_Speed);
    }

    // custom error
    error InsufficientSpeed(uint256 Speeding, uint256 NegativeRatingRate);

    function Negativerating(uint256 _NegativeSpeed) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint _PreviousSpeed = Speeding;
        if (Speeding < _NegativeSpeed) {
            revert InsufficientSpeed({
                Speeding: Speeding,
                NegativeRatingRate: _NegativeSpeed
            });
        }

        // DecreaseSpeed the given Speed
        Speeding -= _NegativeSpeed;

        // assert the Speeding is correct
        assert(Speeding == (_PreviousSpeed - _NegativeSpeed));

        // emit the event
        emit DecreaseSpeed(_NegativeSpeed);
    }
}
