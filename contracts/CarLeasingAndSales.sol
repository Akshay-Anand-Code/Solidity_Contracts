//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract CarLeasingAndSales {
    struct Car {
        address owner;
        uint256 price;
        uint256 deposit;
        uint256 leaseTerm;
        uint256 leaseEnd;
        bool isLeased;
    }

    mapping(address => Car) public cars;
    uint256 public carCount;

    event CarRegistered(address indexed owner, uint256 price, uint256 deposit, uint256 leaseTerm);
    event CarLeased(address indexed lessee, uint256 leaseEnd);
    event carBought(address indexed buyer);

    constructor() {
        carCount = 0;
    }

    modifier onlyOwner(address _carOwner) {
        require(msg.sender == _carOwner, "Only the car owner can call this function");
        _;
    }

    function registerCar(uint256 _price, uint256 _deposit, uint256 _leaseTerm) public {
        require(_price > 0, "Price must be greater than zero.");
        require(_deposit > 0, "Deposit must be greater than zero");
        require (_leaseTerm > 0, "lease term must be greater than zero");

        Car memory car = Car(msg.sender, _price, _deposit, _leaseTerm, 0, false);

        cars[msg.sender] = car;
        carCount++;

        emit CarRegistered(msg.sender, _price, _deposit, _leaseTerm);
    }

    function leaseCar(address _carOwner) public payable {
        Car storage car = cars[_carOwner];

        require(car.owner != address(0), "car owner not found");
        require(!car.isLeased, "Car is already leased.");
        require(msg.value == car.deposit, "sent amount must be equal to deposit amount.");

        car.isLeased = true;
        car.leaseEnd = block.timestamp + (car.leaseTerm * 1 days);

        emit CarLeased(msg.sender, car.leaseEnd);
    }

    function buyCar(address _carOwner) public payable {
        Car storage car = cars[_carOwner];
        
        require(car.owner != address(0), "car owner not found");
        require(!car.isLeased, "Car is already leased.");
        require(msg.value == car.price, "sent amount must be equal to deposit car price.");

        car.owner = msg.sender;

        emit carBought(msg.sender);
        
    }

    function getCar(address _carOwner) public view returns (uint256, uint256, uint256, bool) {
        Car memory car = cars[_carOwner];
        return (car.price, car.deposit, car.leaseTerm, car.isLeased);
    }
}



