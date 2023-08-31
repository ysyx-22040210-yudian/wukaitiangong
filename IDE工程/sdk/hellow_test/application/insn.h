/*
 * insn.h
 *
 *  Created on: 2023年1月30日
 *      Author: DELL
 */

#ifndef APPLICATION_INSN_H_
#define APPLICATION_INSN_H_

#ifndef __INSN_H__
#define __INSN_H__

#include <hbird_sdk_soc.h>


#define  ROW_LEN    4
#define  COL_LEN    4
#define  _DEBUG_INFO_



#define _REG32(p, i)  (*(volatile uint32_t *) ((p) + (i)))
#define _REG32A(p)  (*(volatile uint32_t *) (p))
#define AXI_BASSE ((uint32_t)0x10041000)
////////////////////////////////////////////////////////////
// custom3:
// Supported format: only R type here
// Supported instr:
//  1. custom3 lbuf: load data(in memory) to row_buf
//     lbuf (a1)
//     .insn r opcode, func3, func7, rd, rs1, rs2    
//  2. custom3 sbuf: store data(in row_buf) to memory
//     sbuf (a1)
//     .insn r opcode, func3, func7, rd, rs1, rs2    
//  3. custom3 acc rowsum: load data from memory(@a1), accumulate row datas and write back 
//     rowsum rd, a1, x0
//     .insn r opcode, func3, func7, rd, rs1, rs2    
////////////////////////////////////////////////////////////

// custom lbuf 
__STATIC_FORCEINLINE void custom_lkey(int addr)
{
    int zero = 0;
    
    asm volatile (
       ".insn r 0x7b, 2, 1, x0, %1, x0"
           :"=r"(zero)
           :"r"(addr)
     );
}

// custom sbuf 
__STATIC_FORCEINLINE void custom_ldata(int addr)
{
    int zero = 0;
    
    asm volatile (
       ".insn r 0x7b, 2, 2, x0, %1, x0"
           :"=r"(zero)
           :"r"(addr)
     );
}


// custom rowsum 
/*__STATIC_FORCEINLINE int custom_rowsum(int addr)
{
    int rowsum;
    
    asm volatile (
       ".insn r 0x7b, 6, 6, %0, %1, x0"
             :"=r"(rowsum)
             :"r"(addr)
     );
    
    return rowsum; 
}*/

__STATIC_FORCEINLINE int custom_sm4_res(int addr)
{
	int zero = 0;
	    
	    asm volatile (
	       ".insn r 0x7b, 2, 4, x0, %1, x0"
	           :"=r"(zero)
	           :"r"(addr)
	     );
}

__STATIC_FORCEINLINE void encrypt()
{
	
	//int zero = 0;
    asm volatile (
        ".insn r 0x7b, 6, 6, x0, x0, x0"
     	//:"=r"(zero)
    	//:"r"()
    );
}

__STATIC_FORCEINLINE void decrypt()
{
	//int zero = 0;
    asm volatile (
        ".insn r 0x7b, 6, 7, x0, x0, x0"
     	//:"=r"(zero)
    	//:"r"()
    );
}

// normal test case without NICE accelerator.
int normal_case(unsigned int key_buf[], unsigned int data_buf[], unsigned int res[]);

// teat case using NICE accelerator.
int nice_case(unsigned int key_buf[], unsigned int data_buf[], unsigned int res[]);

#endif




#endif /* APPLICATION_INSN_H_ */
