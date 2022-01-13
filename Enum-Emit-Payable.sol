pragma solidity ^0.6.0;

contract HotelRoom {
    
    // Vacant
    // Occupied
    // Enum

    enum Statuses { Vacant, Occupied }

    Statuses currentStatus;

    event Occupy(address Occupant, uint _value);

    address payable public owner; // payable make the owner to receive payments

    constructor() public {
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }

    modifier onWhileVacant {
        require(currentStatus == Statuses.Vacant, "Currently Occupied");
        _;
    }

    modifier costCheck (uint _amount) {
        require(msg.value>=_amount,"Not enough funds");
        _;
    }


    receive() external payable onWhileVacant costCheck(msg.value) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }

}