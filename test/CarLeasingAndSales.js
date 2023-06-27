const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("CarLeasingAndSales", function () {
  let carLeasingAndSales;
  let owner;
  let addr1;

  beforeEach(async function () {
    [owner, addr1] = await ethers.getSigners();
  
    const CarLeasingAndSales = await ethers.getContractFactory("CarLeasingAndSales");
    carLeasingAndSales = await CarLeasingAndSales.deploy();
    await carLeasingAndSales.deployed();
  });
  
  // Write tests here
  

  it("should lease a car successfully", async function () {
    const price = ethers.utils.parseEther("2");
    const deposit = ethers.utils.parseEther("0.5");
    const leaseTerm = 365;
  
    // Register a car
    await carLeasingAndSales.registerCar(price, deposit, leaseTerm);
  
    // Lease the car
    await carLeasingAndSales.connect(addr1).leaseCar(owner.address, { value: deposit });
  
    // Get the leased car details
    const leasedCar = await carLeasingAndSales.getCar(owner.address);
  
    expect(leasedCar.isLeased).to.equal(true);
    expect(leasedCar.owner).to.equal(addr1.address);
  }).timeout(5000);
  
  
  // Write more tests here
  
});
