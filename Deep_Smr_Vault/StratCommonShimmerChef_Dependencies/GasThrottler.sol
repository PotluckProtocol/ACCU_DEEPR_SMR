// SPDX-License-Identifier: MIT

pragma solidity ^0.6.12;

import "@openzeppelin/contracts/utils/Address.sol";
import "./IGasPrice.sol";

contract GasThrottler {

    bool public shouldGasThrottle = true;

    address public gasprice = address(0x93291008cA6dFf5E6737272438fb3046B9dB6a26);

    modifier gasThrottle() {
        if (shouldGasThrottle && Address.isContract(gasprice)) {
            require(tx.gasprice <= IGasPrice(gasprice).maxGasPrice(), "gas is too high!");
        }
        _;
    }
}