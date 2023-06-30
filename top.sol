// Solidity Version
pragma solidity ^0.8.0;

// Contract definition
contract CharityCampaign {
    address public owner;
    mapping(address => uint) public donations;
    uint public totalDonations;
    uint public goalAmount;

    // Events to be emitted for specific actions
    event DonationReceived(address donor, uint amount);
    event GoalReached(uint totalDonations);

    // Modifier to restrict certain functions to the owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can call this function");
        _;
    }

    // Constructor function to set the owner and the goal amount
    constructor(uint _goalAmount) {
        owner = msg.sender;
        goalAmount = _goalAmount;
    }

    // Function to receive donations
    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
        emit DonationReceived(msg.sender, msg.value);

        // Check if the goal amount has been reached
        if (totalDonations >= goalAmount) {
            emit GoalReached(totalDonations);
        }
    }

    // Function to withdraw donations
    function withdraw() public onlyOwner {
        payable(owner).transfer(totalDonations);
        totalDonations = 0;

        // Clear donation mapping
        for (uint i = 0; i < addressArray.length; i++) {
            addressArray[i].donation = 0;
        }
    }
}
