/*
 * insn.c
 *
 *  Created on: 2023年4月8日
 *      Author: DELL
 */
/*
 * insn.c
 *
 *  Created on: 2023年1月30日
 *      Author: DELL
 */
#include "insn.h"
#include <stdio.h>


// normal test case without NICE accelerator.
int normal_case(unsigned int array[ROW_LEN][COL_LEN])
{
  volatile unsigned char i=0, j=0;
  volatile unsigned int col_sum[COL_LEN]={0};
  volatile unsigned int row_sum[ROW_LEN]={0};
  volatile unsigned int tmp=0;
  for (i = 0; i < ROW_LEN; i++)
  {
    tmp = 0;
    for (j = 0; j < COL_LEN; j++)
    {
      col_sum[j] += array[i][j];
      tmp += array[i][j];
    }
    row_sum[i] = tmp;
  }
#ifdef _DEBUG_INFO_
  printf ("the element of array is :\n\t");
  for (i = 0; i < ROW_LEN; i++) printf("%d\t", array[0][i]); printf("\n\t");
  for (i = 0; i < ROW_LEN; i++) printf("%d\t", array[1][i]); printf("\n\t");
  for (i = 0; i < ROW_LEN; i++) printf("%d\t", array[2][i]); printf("\n\n");
  printf ("the sum of each row is :\n\t\t");
  for (i = 0; i < ROW_LEN; i++) printf("%d\t", row_sum[i]); printf("\n");
  printf ("the sum of each col is :\n\t\t");
  for (j = 0; j < COL_LEN; j++) printf("%d\t", col_sum[j]); printf("\n");
#endif
  return 0;
}


// test case using NICE accelerator.
//01234567 89abcdef fedcba98 76543210
//00000001001000110100010101100111 10001001101010111100110111101111
//11111110110111001011101010011000 01110110010101000011001000010000
int nice_case(unsigned int array[ROW_LEN][COL_LEN])
{
  volatile unsigned char i, j;
  volatile unsigned int col_sum[COL_LEN]={0};
  volatile unsigned int row_sum[ROW_LEN]={0};
  volatile unsigned int init_buf[4]={0x01234567,0x89abcdef,0xfedcba98, 0x76543210};
  volatile unsigned int init_buf2[4]={0x01234567,0x89abcdef,0xfedcba98, 0x76543210};
  volatile unsigned int init_buf3[4]={0};
  unsigned int begin_instret, end_instret, instret_normal, instret_nice;
  unsigned int begin_cycle,   end_cycle,   cycle_normal,   cycle_nice;
  printf("The data to be encrypted is 0123456789abcdefedcba9876543210\n The key is 0123456789abcdefedcba9876543210\n ");
  begin_instret =  __get_rv_instret();
  begin_cycle   =  __get_rv_cycle();
  custom_lkey((int)init_buf);
  custom_ldata((int)init_buf2);
  encrypt();
  custom_sm4_res((int)col_sum);


  custom_lkey((int)init_buf);
  custom_ldata((int)col_sum);
  decrypt();
  custom_sm4_res((int)init_buf3);
  end_instret = __get_rv_instret();
  end_cycle   = __get_rv_cycle();

  instret_nice = end_instret - begin_instret;
  cycle_nice   = end_cycle - begin_cycle;


  printf("**********************************************\n");
  printf("\t      instret: %d, cycle: %d \n", instret_nice  , cycle_nice  );

  printf("The encryption result is: ");
  for (j = 0; j < COL_LEN; j++) printf("%X", col_sum[j]); printf("\n");
  printf("The decryption result is: ");
  for (j = 0; j < COL_LEN; j++) printf("%X", init_buf2[j]); printf("\n");
  /*for (i = 0; i < ROW_LEN; i++)
  {
    row_sum[i] = custom_rowsum((int)array[i]);
  }
  custom_sbuf((int)col_sum);
#ifdef _DEBUG_INFO_
  printf ("the element of array is :\n\t");
  for (i = 0; i < ROW_LEN; i++) printf("%d\t", array[0][i]); printf("\n\t");
  for (i = 0; i < ROW_LEN; i++) printf("%d\t", array[1][i]); printf("\n\t");
  for (i = 0; i < ROW_LEN; i++) printf("%d\t", array[2][i]); printf("\n\n");
  printf ("the sum of each row is :\n\t\t");
  for (i = 0; i < ROW_LEN; i++) printf("%d\t", row_sum[i]); printf("\n");
  printf ("the sum of each col is :\n\t\t");
  for (j = 0; j < COL_LEN; j++) printf("%d\t", col_sum[j]); printf("\n");
#endif*/
  return 0;
}








