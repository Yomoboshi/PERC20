// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./PERC20.sol";

/**
 * @dev Sample implementation of the {PERC20} contract.
 */
contract SwisstronikPrivateErc20  is PERC20 {
    constructor() PERC20("SwisstronikPrivateErc20", "SWTRP20") {}


    receive() external payable {
        _mint(_msgSender(), 100);
    }

    /**
     * @dev Regular `balanceOf` function marked as internal, so we override it to extend visibility  
     */ 
    function balanceOf(address account) public view override returns (uint256) {
        // This function should be called by EOA using signed `eth_call` to make EVM able to
        // extract original sender of this request. In case of regular (non-signed) `eth_call`
        // msg.sender will be empty address (0x0000000000000000000000000000000000000000).
        require(msg.sender == account, "SwisstronikPERC20: msg.sender != account");

        // If msg.sender is correct we return the balance
        return _balances[account];
    }

    /**
     * @dev Regular `allowance` function marked as internal, so we override it to extend visibility  
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        // This function should be called by EOA using signed `eth_call` to make EVM able to
        // extract original sender of this request. In case of regular (non-signed) `eth_call`
        // msg.sender will be empty address (0x0000000000000000000000000000000000000000)
        require(msg.sender == spender, "SwisstronikPERC20: msg.sender != account");
        
        // If msg.sender is correct we return the allowance
        return _allowances[owner][spender];
    }
}
