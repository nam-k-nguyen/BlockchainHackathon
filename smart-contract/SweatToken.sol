// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract SweatToken {
    string public name = "Sweat Token";
    string public symbol = "SWEAT";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;

    // Track the balance of each account.
    mapping(address => uint256) public balanceOf;

    // Chainlink's ETH/USD price feed
    AggregatorV3Interface internal priceFeed;

    // Events to log token transfers and price updates.
    event Transfer(address indexed from, address indexed to, uint256 value);
    event PriceUpdate(uint256 priceInUSD);

    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10 ** uint256(decimals);
        balanceOf[msg.sender] = totalSupply;  // The contract creator initially holds all tokens
        owner = msg.sender;

        // Set the address of Chainlink's ETH/USD price feed
        priceFeed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
    }

    // Transfer tokens from one address to another.
    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // Get the current price of 1 ETH in USD
    function getETHPriceInUSD() public view returns (int) {
        (, int price, , , ) = priceFeed.latestRoundData();
        return price;
    }

    // Get the current price of 1 SWEAT token in USD
    function getSweatPriceInUSD() external view returns (uint256) {
        int ethPriceInUSD = getETHPriceInUSD();
        uint256 sweatPriceInETH = 1; // Set the equivalent SWEAT price in ETH (adjust this as needed)
        return uint256(ethPriceInUSD) * sweatPriceInETH;
    }

    // Update the SWEAT token price in USD using Chainlink
    function updateSweatPrice() external onlyOwner {
        // You'll need to implement the logic to fetch the SWEAT token's USD price using Chainlink VRF here.
        // In this example, we set the price to $2.00 as a placeholder.
        // Replace this with your actual logic to fetch the token's USD price.
        uint256 newPriceInUSD = 2 * 10 ** uint256(decimals);
        emit PriceUpdate(newPriceInUSD);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}