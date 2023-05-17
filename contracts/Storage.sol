// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Storage {
    mapping(uint256 => uint256) public aa;
    mapping(address => uint256) public bb;

    constructor() {
        aa[2] = 4;
        aa[3] = 10;

        bb[0x7aB69deBB8f006252bfc4F76DfbC84DB28aeF126] = 2000;
    }
}
