// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./Owned.sol";

contract Faucet is Owned {
    uint256 public numOfFunders;

    mapping(address => bool) private funders;
    mapping(uint256 => address) private lutFunders;

    modifier limitWithdraw(uint256 withdrawAmount) {
        require(
            withdrawAmount <= 100000000000000000,
            "Cannot withdraw more than 0.1 ether"
        );
        _;
    }

    receive() external payable {}

    function emitLog() public pure override returns (bytes32) {
        return "Hello World";
    }

    function addFunds() external payable {
        address funder = msg.sender;

        if (!funders[funder]) {
            uint256 index = numOfFunders++;
            funders[funder] = true;
            lutFunders[index] = funder;
        }
    }

    function getAllFunders() external view returns (address[] memory) {
        address[] memory _funders = new address[](numOfFunders);

        for (uint256 i = 0; i < numOfFunders; i++) {
            _funders[i] = lutFunders[i];
        }
    }

    function test2() external onlyOwner {
        // some managing stuff that only admin should have access to
    }

    function test1() external onlyOwner {
        // some managing stuff that only admin should have access to
    }

    function getFunderAtIndex(uint256 index) external view returns (address) {
        return lutFunders[index];
    }

    function withdraw(uint256 withdrawAmount)
        external
        limitWithdraw(withdrawAmount)
    {
        payable(msg.sender).transfer(withdrawAmount);
    }

    // this is a special function
    // it's called when you make a tx that doesn't specifiy
    // function name to called

    // External functions are part of the contract interface
    // which means they can be called via contracts and other
    // transactions (tx)

    // function justTesting() external pure returns (uint256) {
    //     return 2 + 2;
    // }

    // pure, view - read-only cal, meaning no gas fee
    // view - indicates that the function will not alter thet storage state in any way
    // pure - even more strict, indicating that it will not even read the storage state

    // Transactions (can generate state changes) and require gas fee
    // read-only call, no gas fee

    // to talk to the node on the network you can make JSON-RPC https calls
}

// Block information
// nonce - a hash that when combined with the minHash proofs the block has gone through PoW
// 8 bytes => 54 bits

// const instance = await Faucet.deployed()
// instance.addFunds({from: accounts[0], value: "2000000000000000000"})
// instance.addFunds({from: accounts[1], value: "2000000000000000000"})

// instance.withdraw("5000000000000000000", {from: accounts[1]})

// instance.getFunderIndex(0)
// instance.getAllFunders(0)
