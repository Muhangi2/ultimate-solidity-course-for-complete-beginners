// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract Calculator{

    uint256 result =0;

//adding
    function add(uint256 num )public {
        result+=num; 
    }
    //subtracting
    function subtract(uint256 num )public {
        result-=num;
    }
    //multiplying
    function multiply(uint256 num)public{
        result*=num;
    }
    //getting data
    function get() public  view  returns (uint256){
      return result;
    }
    


}