// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Sat May 27 10:59:57 2023
// Host        : DESKTOP-D0LJC9J running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top c_shift_ram_0 -prefix
//               c_shift_ram_0_ c_shift_ram_0_sim_netlist.v
// Design      : c_shift_ram_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tfgg484-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_shift_ram_0,c_shift_ram_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_shift_ram_v12_0_14,Vivado 2019.2" *) 
(* NotValidForBitStream *)
module c_shift_ram_0
   (D,
    CLK,
    CE,
    Q);
  (* x_interface_info = "xilinx.com:signal:data:1.0 d_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME d_intf, LAYERED_METADATA undef" *) input [0:0]D;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF q_intf:sinit_intf:sset_intf:d_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:clockenable:1.0 ce_intf CE" *) (* x_interface_parameter = "XIL_INTERFACENAME ce_intf, POLARITY ACTIVE_HIGH" *) input CE;
  (* x_interface_info = "xilinx.com:signal:data:1.0 q_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME q_intf, LAYERED_METADATA undef" *) output [0:0]Q;

  wire CE;
  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;

  (* c_addr_width = "4" *) 
  (* c_ainit_val = "0" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "1024" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_has_ce = "1" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_sinit_val = "0" *) 
  (* c_sync_enable = "0" *) 
  (* c_sync_priority = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_width = "1" *) 
  (* c_xdevicefamily = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_shift_ram_0_c_shift_ram_v12_0_14 U0
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule

(* C_ADDR_WIDTH = "4" *) (* C_AINIT_VAL = "0" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DEPTH = "1024" *) (* C_ELABORATION_DIR = "./" *) (* C_HAS_A = "0" *) 
(* C_HAS_CE = "1" *) (* C_HAS_SCLR = "0" *) (* C_HAS_SINIT = "0" *) 
(* C_HAS_SSET = "0" *) (* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_OPT_GOAL = "0" *) 
(* C_PARSER_TYPE = "0" *) (* C_READ_MIF = "0" *) (* C_REG_LAST_BIT = "1" *) 
(* C_SHIFT_TYPE = "0" *) (* C_SINIT_VAL = "0" *) (* C_SYNC_ENABLE = "0" *) 
(* C_SYNC_PRIORITY = "1" *) (* C_VERBOSITY = "0" *) (* C_WIDTH = "1" *) 
(* C_XDEVICEFAMILY = "artix7" *) (* downgradeipidentifiedwarnings = "yes" *) 
module c_shift_ram_0_c_shift_ram_v12_0_14
   (A,
    D,
    CLK,
    CE,
    SCLR,
    SSET,
    SINIT,
    Q);
  input [3:0]A;
  input [0:0]D;
  input CLK;
  input CE;
  input SCLR;
  input SSET;
  input SINIT;
  output [0:0]Q;

  wire CE;
  wire CLK;
  wire [0:0]D;
  wire [0:0]Q;

  (* c_addr_width = "4" *) 
  (* c_ainit_val = "0" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "1024" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_a = "0" *) 
  (* c_has_ce = "1" *) 
  (* c_has_sclr = "0" *) 
  (* c_has_sinit = "0" *) 
  (* c_has_sset = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_opt_goal = "0" *) 
  (* c_parser_type = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_last_bit = "1" *) 
  (* c_shift_type = "0" *) 
  (* c_sinit_val = "0" *) 
  (* c_sync_enable = "0" *) 
  (* c_sync_priority = "1" *) 
  (* c_verbosity = "0" *) 
  (* c_width = "1" *) 
  (* c_xdevicefamily = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  c_shift_ram_0_c_shift_ram_v12_0_14_viv i_synth
       (.A({1'b0,1'b0,1'b0,1'b0}),
        .CE(CE),
        .CLK(CLK),
        .D(D),
        .Q(Q),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2019.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
LaFEyfyxU2eSiHc4qUJXLjaX7KTgafO8swbLbiv/Sf9OhFdIYoQNqUp8BBAnMMGJmrHwHRPIf4F6
o//soabg0A==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
mlXdJI1KtaFJSwPaQOA45kCl+Zs7Sf5hrxI0kP6WcTyLd2NKmdS7WjYL92+NUmX5ohlTBxfnBCXw
bP34tk43opA0/w53wsRDvrKalr52U4qIncnH5uP1g2KjhJDvMuounm4OXBEpJPAVIPA+KVWyM0By
oMGFDp7HDuQS9BWgDG8=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
stP8wGZN/GWBaZ7TOUHDdRV5koenqQ9Yarp16/conM3fYqVjTvIC1AB1w0a62GvqHKWbgLYi/2jZ
70upYMBAPsU4SrgyRLzrAYY3XRzoHKxZxSNV2T1TK4IHsTHTO9yICsFdfxTjVNgY/fO2s9y9h4g7
apFddx11MW/vy16fWRWMd/SLJ9cNvLurnQDbX+E7hDxEqh7H19FtRhD5J5xr3Yz8AtG6NHGHohSt
/2hR+/qwVR+i6f4eos11uieLzKWD5ztipnEJxcQ8D7yBTSe1wD1OS39/d4QzA0dnqc4pnzL79tOq
98/jQ4TFnief3PU26yF27CNBOfL4rYVq4k3Wjg==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
uq63cCGdwR2xvqrD0Kn5+kP4k6mGbAdqnMX5UXBki043rVinooxiOlTx6jFk8zUwKK5DyUDb78yB
tLbc8dhFfMPPvgARX1Qj5GKEi/kDdXhkRULTixN2uQ13qnZlpbjTTBBgKUkFNdf9/dyxdfTZNEjG
x17Tl8xhv5BKHuFVdQ1tFdoEO4ScmqWIztFU8hwKj66993eZBovevhp7gCVGW0l43OB2gpgpGtOh
WG1WRjwgaklhgOBNBPaxKCaAvCCsrjpIFAjdF8Z1sRsRvZOQzU/xvg0uXLNaYrGgvaAEcJLBqhL7
hZE526SQfdNsMTg+CjKaCcUyjKY2dCDd51VpcQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_02", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hu5tUSDDK8dd7tbo2w1nHyVlm/1B8qj18yUBj2tfbXP9YvsDb667+J0DnrBkxtarPZbVaFA4LlZ7
pbgQdlYSTHuI8sh5BrdKXQ1ZjcDRHtnVoFEpitKE6sXS+RTBgglj8eF1iSmQIuf7zL6XOi+SlDHR
Bw6YUKS+Kh7mvaGqmcfDWkoafDYa4qLLY+DoNbtmMRInDL+ndEwKkgJWf1UrUrtyFEGBC36+rvYK
Q8kgejIrnMVUnepjwgbtz8Hv4eT4B3JXiQKYA1sasf2ZLPW6jd4JN3xtstpCSajI67LU1Ijro1Bo
ZVKlddD39J6lw1/TopWmrBP93VS/7+dEuZ/IRg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
prvwFCgChd0N0reFurzi25YPM+5HwkuPkdPJaOwKDiXyitC8zIymqwHzZqw+r3mjjCGFQBwubBQp
36Gy1U1hMtzV23LU8UMdnsT3ADaIzoIMs5AYqGAtzIivvqwcySVW+2rPaQ0BoZ5krSeoz7XL4Pud
DGBmpry8VjgSy7pwWEE=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GphCwqsD22w8ZM0lINVSdl7ugKtxyfXZ2O231S+2SMOKvbsghfMSl5Vuc4udUKKVvoZJECsrUeLe
PS8BqyZsdexqEAThri7pN6L/xOwY6nPfJgKtrbGpVyOZ5AWKdXYZQ5nR1NwVSGfOBy+yMVu5CFWc
XM8TaJAULlKKIDuSW0WR5kzZh7exU2hZoTuCcjRNFZcWDDCBPXPV0VOhyP90sfhQ0Qjfyapt7mbD
STHiaOneJ2/crycvetf0SyAm3wpe0mZH74+vZ2nqdAKZk6qU+UEi0pfRrCMFYWoEjH8GEL/ZTdzf
eU3RZPZfzJAbknTppsK3Qwj+/i8jyyhST+3f4A==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ibi++YXec0p8FC+j0Y9nMOukmIP81YNiI92V3vzT6kHfQh2oWxvjb9c3X2+Sh/FOcwIAvCV9BaI/
rIrKUg202CaitJjYGHvJi6N1RP+VX8ghgp39d4SnCvu1s4U0sRyq3FpcIX0n+Eic0JU7LlduFjh6
zBG62Cri0YYEQ83jmPk68X78xIPuWXk8i5A+ax0Uh4hY6pCahm59dbbMJ1t/sj+33IsgsMrBFO7i
SDYghR158ES+u67QWLMR3rsfPZFobet7mWaUUQ2HRFYlrmCUhHRbPqDnDXy/BBcBkszV0b5vzSBD
dQB3jzHwQibPFDQhb91SagcGq1tY7xCpL6QkKg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
B1pG+Hy45HhdEN9RzLnMGYuRgsmXuu3+CUq6tPeQn11kOgaTXS2r2gY4qiVAr2JkMdrh0P+kGU9h
g0X2rWE36QMxdLH/kntQwHs/TzU0FKNt1/pBRcr5gCjFB9L9uKWb+aucWzKC3omrJ4lJXr+BgZP6
T0i9C1Qz401mo6nScWb1/bcBaIe1shE9FwY3M/ndQty5btscxod6skZsUb04Iy4PrCXTpd3MzB4k
galKF2PHrJj4Wrxeh1HBNSvFmtuNNAoW7l5y93Ivq4N+p4b6msoUOJBeLaHFsRv0C5dU7e0KeCCQ
hlOKL2RDiU/Z5Goc7aE6b10DbxLf0bvPO+f3rQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lvi52MCSjqfP6Tt5fHDstMQwyQWEO3avUsOh9WjsqIi2TMGJ67vqJcPPDsymk1tlRrjZumWJ+RWG
BjujdRDbr8PzpbDI5ArOzJg2aUdpfkU0pGrZgj4bEtwzgIDv0tBe8uLsQG5P7GtKE2jTnzpYIjOY
Bnede12/pTIiFgb15jh9y6nLy0o0Yk04P2iNru8p50OJUywXp2za/87pp+bsZfXYdaiegK1tWfeW
XCcBQ5SmEvGyMt1UL8BMfnk0QIrdm2ZApDoDFNfZRghksaHHSMrJ+7lJEDkk0vjIzOSsCAWLrJ3o
VcotJMytE6tW9uSxmUUAaNsBZBvd5JEOjkOKFw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 32544)
`pragma protect data_block
eIplx2W6+o1KsRllkBYqroVvwtOEwr5GZtoeyZKnht+G7XYaJLXpnA8yo+jR69O9mIjmbYzIp05O
GQ8bPKM1BvwbQ6cebTog2Q0mmm1RUe12xtzQqgApl6mtdTUf42T0Ek6Oa5WooVSt+WW23W3YKGxL
DBxcDrFz/A3OvCxL+CvvghmCAYX2rXam57QI31ncwhYtgve8pBWggxFoTQ3O5XTYCSB4XA0GQwha
aBiTFONlK944DugZ01zdYK457/rwkcISspWvAJxkTI90Rwm/tP1h64+Uozn29TRk9vsjoCjqMMq+
25ecKqCOkxhc9xw6L0WYXvj9E1/cc+KxYwvbeD1+kteFIZggje6tK+D9ec5Xuc6uiP1kcbVaRc95
oHOM3YY4gZ3Si+gGjLrcYiQZp7fYYhj71n7PYvpOhJufVl4uOEaKhntLHnfFFpbRrM5N6WTNRJXA
fhnNyY+eF7BoeuCX3fdDOry46UvNblGJx2y0LrUFL65+cDKMP8ZQcMKFuKo3uaVU9N95/PwARJuE
eVnphficjdDng0ebCy2G6Nz3vOeWvM6oPFd7iJRNTQsKZ4KMg0gKZJ3cqimD9FLmKAOO1f3/YnDa
e0XPx7dZQEUUdPD8P1YFgJ9bRmma7IIfUoJn0Q9Hc6hBhIDwxniNfWbpHkeXot5sRkLksiQlwcha
9uNKSwFhGTcZNyKyifXfUuID6jDGWa9XxE+ljvIVz/k6r3t2h1IXV8yStRyTSDmNP0v7W46I8MEp
JICWgHHB/jTGM0jNpttsh0ekJ7YRwzBLa8HA7DiVTNjVCTv1ELDeOt1GB8EIyWz7xbLipVZqF++5
QE8qF7jyYW1uliZKbejRKmX1wvGuB4+yplYMhvvTx6b0Xwl964KM+t6w9dm1CeXTWjCuOsZXCvbo
Ri0U3oV5BGoYL+DSmykopyjW3D0mLimY1JGFS3Ye4g0AlLDRvdQb3Uo+z0+/lPd474pfP3cmIt00
+A9f/anEvumwu1gb/xVwlc2CGuccYp/MTVRimiC4Jb6fjzq6SXJwXajWJPr4L9PXxVGr7HjfuZ9O
Amcpt9+FZmXVOX6/Vq7SCXTqswj6FrZkpjJKBR+ejC10+8rgqQ/S5bu7LS6Gs8kw8v1MI5tjMshr
0pYDJxxEtGSA9VbIfRfHhgqUPYbem6t/E+aRRoTzeCCA4HtOQ5pf+rnBv28zQkEWu/ZYgd7dlCoS
oPclDZHKKZszCabU0O8HrUPTV0pQUgHGbm59HUDD9YMBOi2Ms/9cZKSLlcsFPg52l+B1p5gkYMmQ
Mx2bmHwWrkbeadksFg83mfIX/6jj6DmSo1l+epIc3GJ5GLvboHaXXIO+MKSEnQ9nTPXt+Fshhwxi
L+/pD8uD+evy9O5xXwSOC8SIyAapZ7ZYFfla7xF7Bx4sbJqEYEDRXx9speFxc3xdw38qOIx0MxJI
OCkCPMR8XkWQsIRnIeTJoV9jM7wT5EePQMO71lHFHsM3G498++Z/Htc2OVUVEZ6l8yJNtZcCoLdE
MrowA7Hie/d6loQoaM/PDhQTp5XZJahp6bJVBGPXRAEqn/mmXSOE9IcccWykio2Gk3Ho9ycZp4LS
JpaitoL1mKng7MbcAdKnEiDUykIAQ15fdRH5N4Zkp/0gpockmUf7902PKQOnmrcLxDbtxPLufMOH
bnJxjhFAKBWElcrnQc1M06T52DM6aij0Lk4tUepCIqkGZeiH7fRISV//vrLHtjKmBebeJWu5IZ4W
GfTuyjQKuJZJ9dF+jk78yX5tsGztBTnF/ShoE1olzC6vpRygaWYcJIrhYD3uPWGAoGRUIjGWE2fR
imzySi53FQtkK7HO9Zcvy4N/G5amWXSl5oojbHIZKbvZ0+BwmZ00m7KkFigRCDcXgAoWffruSzUu
bb0OFpPslYgoGnPz1N4kMIzhv2wTwUkVHSKXcTpwqGuHVar4xKpqETuyzOHILWczwPPHv+vfwztx
LBJHI/kRl4Jo8tVkibgWy8r+TQ7Pi/9fScI1612tsGo716NKOk5an04a5V4qP9y/j4//1gfkHZPl
9LMjTs6hGWw9RoKnvgwx9SvyAwUBsWu2iDsdyhmhtA1y9/eMoNjkBRkqWA9pRNzvI84IhEoPOw4D
oSY/T4aWM3fvMWHstqUECv4zEK2p83TtdQdBCC+SYTUYxExFg7JrmdwTCyKCGVY3N0hNLICIl8qz
7bZXfn5zWe0lMfHRCp51DVNlWVrDM/HvWlMBmimPFQuhpCj2TjGabMJZhrtChXBjKdMO4aAkqGUe
YMkgLEf+jTqr+2AT5WKGEBB1TMZme3uXFbkCEXz5dXtt1MiTaOgu8pmVmoFK2BXXCapiMvgrZYJ7
7aadmcTkPVu1cPObDhe3RXCRc5RWBo8zg7yUszla9dldtIHMglgQtEFaMcS0Qk/Mbo5HYZMhDtSf
p9tJvurFeLVN2Y16DdAW5Ygx8tQJc3whzQ5koHmp3jNUfzQMINf7J/XJD8Ar/490KpcKyhwoot5i
yHUk9b240tuRQMxlBbmbpSGASE7nlzhRC8GOpRnEWtESrcImnSOteHDe2B7LNNVt+bu+GxrRV3d8
7Ks3rfz73nryJX+rjNko6CVIy3GP2inYdPjkxQ8tM0r01CUvukAFj7Z1sfLZ9JONXfdzPUJjJg65
1ZOsYnJIRMerjfi3EkcnDzwiithl7yDNQL1+d5iShAgWYxzE/Fc7w+4BlEL9Rft9n3qUcNg+e1ba
lCgTYg849E4zYUyEzWvEaglIXKDV9y/xtOTuZoqFCCt95esokctR02UL/rzjrOBPWgJVfEwo4+IB
e+wFTM/bmb//vOU3LY7Cp1KqJ/vYmlaZcTbVNRRKTaq6BJFbZQWYUm/Z69+sj3ddP9hzPvccqJhA
Oog+EpDJUKHGPXYleYhCqOKqfOEAIh7Y0/ZzuddEp30xoS0bqnpzit/rnX4PXUAA6IgK8tTlzKF1
Y0xAeUksnNulgaWzWDin6/3OTutyIC3Ix25qYqdTsApoBaO5MKEtYXsEUYJovMzDqPEzKdQnsTGF
z8gLOxfWMTX//nYrYw35JoCkdQ/fTtU7kI9u9qih3WeQMJmQfTTrOm2OD5MdhDpOVaKdNOUU6uWL
WUUN1HUmHDiSzQC/5ic/uA2MJ25xRDDZPVghu+exxNB0jj2eqLT6Os7WCp6+xnycjn2AQv+mEz+I
zyHGI39xxjuR8V0SqiqNTjwyHvDuSVH6gWNduIN+dBKzf/Nkv9AQ47AsrEnkoFL2x/N5HXrNbjvq
IIQ5Mydg0m9yZ9nC/Z5j2p37CttqMvkHiWcMlm2OXqFNMMmDFxbR+CyiJSfrY9jiP0XYIdgxwIUP
4IOxY11qmOJA0KgQKo3jQT8eRBWKTjLQSpeeQuE1rVmH4jsmQ3eHm1BdXivATfpOz9uTkLfPblu3
iiBXlSHGe6lIrPv30nPsF2pHNb6BXQIYP1GDTe3reZ7CetfwANt/tunjr9IcoUa5S3aya87m1gjf
mHJBApMGtziCnx6ztV9oL+i1wwWCP+lJ8Kchy6wdzWVx2oaCNE2Uv2t321X6tSFDiiDN/MnVI6OQ
h1PW1cr6PhcRb9sblRpvBDC6zDdwob6vk6CjEKBDCGp6/HkKhx9jX1OEtKamX6E+1C/yLzdsF8Vc
JO1GoRvjcCkiebSWvOyQnQU+JrnEo7+IYtdpeUeOwRWYkgmqn/7sAJnn54olcuUNF+zcX7TUS9Qt
nXEaINHs2G4QbgbU0eXTuf6HWZ1qKgcDtLgbZPBCfXBS+aCxQoldvqso17ryHaLCF8d/TDoF3cQl
myAsUPNNfUnfD0kgI3xebksg9mz389NqzXNiz5KdCEUWJAChTK7hLA8mH/Yh9iMTgPcPdRNiyV6B
JguU1eTAfP2CxRnGUiNTV3cKxL1iNv/jxmIFum1eeLAZq6EF9h2sAnd6P8Bgdaj5CQIJ1yN4OtOv
0JvRNZShektU87XzwImqAZRXiDixXPPyqH+nkC/svKcHrT4y4x1ItnAQp+wGmB5IdAMUZkHV+hdI
6EK11tWDiasGhGrRMItTPHxYxFqMf/bRscD1TmPsmFYC6QOGfzcmiAiOxqQTp/GFAcQRCyWx2FWg
pU+Cy/TakUgOCZqdDF1k5CFpatRi0FY/pLOVEE30GsXCR+Q7TofTdCjiGlCdLddWhynxvrxC0+Xl
KYWhBeRjl2B7W8Q15ylXw7eS3pmF7+LDZA8MnpEuVq7B6ifHQwWOsNpnLTbUFMbcTiFJC0gbqjiq
6VdVpJ7knYwN3q/2/d09n+EJF+QIpKrbloC6ZXFSiypS/7WCF0z61bl5g4OJOLyXphvaFYgPsPT1
nHSxy6ra+MNk+1/ydeRA9B7HmcVsyRpEzSY7r6kkJw5l0L9eomObboAOZZnjSBzqC3ld1zUO9ujN
QTriUKXISJsRhlAMeUbaVv9zPgmMRTz4CuyxpBpTr02ot4etBgEpfkzqCr6vu1/nCazt84ncpqnn
ivaJfznFYkHfwwRngOtMUTVne4GriudJWvkL6WdLK2x2QbSFaZopoLR20rsfT2OAvjXzbmdO/zvY
BxhRhgWLuj+6oG8C45jHMWsV/jPjERH4KCNhDFqjW8ytk/Z7aGF0cMIoTrg9A7Fc3ySO6ua0L6vU
GJKEudZUbqT0Lgaz0NyqOxEyv1IjA85T9ffmqrC058BPuTxdSL0EWLTyiZQbjjRg0DQx248GFT+p
ToGKBLQ/jI0TKlGcuQv5DpTNjq/GQaQm6rW07/CBIbmICqntFY/ocTpcHYgZSvzgbugDOoZXv1bX
xwW8UuRoUFy++7KEVzMQ8sD6sUeFXuI4CCKq50Kdoli3VRRsNqXdRNn0gDu2GHoPG3I9z5/x+GKq
SyH+fbTCF7bTJVKpzhgB0vd6B4Id+ai1DkN105mhn0suJc/zClExwQM5nzkvP7LT6ZtehKipGswo
H+dOijdeKf3vEFhilSWQLhhFFWEbGAjkQsLCvMlUeC+n1WnUn/+wYBc+9rKBnwJ20HaVIGa2o5Vf
nFZJ6FDBCEWRA9bgU5TPQyxDQFLGT0idRBBy/eUsz3J/bxbMW6fAckDBqb/6lxf1e7lrRRrddLwb
8VNuUQM1bDa1TcIMtjgldLF3A2aMFbiZgJ6JaLJ5inT/Qsb6dR2kIWG1br8j2NrHryCFfzP3COk8
ORSzlx618VPUO1BCu7Mys1EpNmBSAWvA3w2yN7BOshtYwsOIKncBS5Yf8JumQKUg7yK2XTXcZySh
WgRWt4O9ZXqJWbFlYqgLutroUbojO+YgHfwKogfXOWo3/CVmAYbzON+uQwoGlMv6AFon8iPtpiZT
6ZfLzsOo15gEVagNOb5xWY+OEaFf2ZMvg5BuEI29R/rDUp9UEVbUIXCOAwg+LmmRz7Spn/OqO2gj
CrzLOQaYj7UfGt3WeOvIhFO+8ivGhGnnb88Vw0Re1dImv6Q8peYrt8yi4wuouR0nl4di4f1cfIk2
EzQD0FyP79UOmhmd624GF+FxbRVfsJRgY2zhY1u1Yr6CfB504qijQDR33gx17S/ahfjxGu6CKQIJ
BvkzVC+2CytvI3yVX4LiNAyIoe0y/HgR1FNzyj3mKRcl11aAH28q/GNKeQ86b6l1loM/2YoelH3x
bd6lJRG8EbN0iEipOml6wHX88Z8Vc6owBR28PxIqGQUTq2+1QPw6Qc+FnpPLpaQ3Jhh2SMTZzd72
Ch+EIQ0OdN29IeSEhWj66J+r73g1DSeaDnhxmeBroB9DiK+wVthTnhUP2UO+JHlMhuE/9qoIYfyC
8x5BQmJFeqgZnCkdOuiexAJahFGQX5tugbD78K6yA1OAR2ODCxepo7Yq5hBi0VvaQ46+7yZ2ocOW
Ebw3bT8qdOVUxUwZXb92fs3rhsfGl5OWZq4ZUFyCEWv2P1g7ArADBtWopR1UE1Rqbo0cUUTc1/5h
7Wd9Gm4SEZ8fbTJ4WJ+KLwRteqzYPIKhbB9ygHS5oCh+25Fxidy1rA8EPBdIwucmhMiCZaP3pMCy
jIdwBhRx/GGvNsevQDKxCwtjPL0hSq9QTxwPfI3URVHPwBkPkLVW7Xfud3b+imfGAqRAcLsBtDP7
wDSlKKQ45UUWnpWGTnN9DarsgQniKCz+NqTJgg6IMLp5h9/MtiS5tzFW5okAfIPKUryyJ7D2q0hQ
7sa3sjvU3vv8E1hp51Z5e16rw/8/NWgEg2LplCF3vHdBwTzKm58XQIttwOtu+Z1P7rMIiqUKyncs
vC6obXrvAVJGUs7G3I1sDlFcczY220DzYrZrZqnUF/OwcWmdMgdawPgE9a2YsSAB9G02X+5TIP5D
f9wLkT1YZZAAbKWJqxjhruY+3FyH84duVkLqOmr0YRAo07AzJC88mWDWR4EPQoodx+y5+f3IuQJB
doh+xtgxBU47PmU9f0fwIGjHhkoZC+axqVXw4smPK5ZYmuAfieWwWY9NzHqfZisk6Sv8bjiySOWl
Y9bjFdxaZg0ja6+YhbCJe89dHGJ/FdOgxhE2oQxCe6MfWh50L3Gq+CvihuASmQQMa/TgNMeSdw7n
wvrZIpwQVKO3SXBakwG8bc+hLkGtX25NQUcMuhgl8wXftH6fubcoSTFR1wnatZYhb8sHn+Sg631g
t5TwX5koDTQQEGZtX1+wZgXqgU1fnb5pxErdI7gcD9JvkKcvQPDAPQTUP0iDEmOCgH5Mc1MFm7/1
0/2xN1nKVqp493sg4ohV6Fzvj/i5SmTNbz8nbNbbzZT4HlcdabzVtAHQS/1jwYwc1beuET2Y6wR3
gveuVd3FIlXB5x3Q6J5HFDfyFRp7QFNQAI1JPOXB4nPBHPBQHR9Sjqj+yIYJvY9CD5xRxn+2uGfO
8e6ElLtSw2VhdBHNDYwwTWz/V0vZU4RFaDbi2uFukMvU+/P52rWxpjHSW3Wy/dmVzcZOb+ws91ak
aPhdHGzB1BmL5jlEhWgq/mZUoWQokvadU1qnDOiVPozP0qNC/VpTizCVJxQZdh+9jSiSkrjVUCzZ
zgu1sJhajuv8rQHwJQjXL4i136qoQf+lc6nTUG/noZGZ/pljeVTPUojulu2JD0OrnZzEQIm+mjJw
a8nhjzex3VopQ2156EqhpH5sS9s87VoJ8qgpLP0cN0Z31y7sWv3fZcOF5/YkL8EjknGgmrn0C1cO
zTzAFtbdnhgz7mQPHohrSib46r3uyTWFVe7HX0ARQhoKs1ki5Q5UoXZWMqvZavHgKNNA/E/jtMI1
ytVAOBdq70MCLNORAUDAKBvjwnPdprRZWuvYjX01WLTHy8XUbf25p8i1PWfIIYimmEEVotUAKo6Q
o65E8XSD9+xjs/yzNR03fXAPRTo8motoO1F0paI/DZBekEsu5o5VZGmFJujCjLVfyGjFzsTPvFyL
DSDSw2ux8/grkgnfZwZo9pttv0ggy4N7Drq08l3RZol7emraLa0oULFCtjUafd1SIkL5icvC3Pu4
GgXBPXZ0YZXZEiYPPGza6mKPb8LbKGUqnTA1ZsNJ1rDDnggXe0t628fz8ejrTrJnUTeXzo5PmosL
lcIj4EwxT6O5mpdraSLqLB1D7WJR/1JUzCd7ZDX/sf8c4SttpyraEV22a08G/s7D4CdnyUXszwxe
agYlaSJFElYLVAa7c7V6PjwP/hyGQFcFSDntuTEqZ5duhOM03FNKyk2xf7nNRjgfRCXq+oLeNkaN
aarPUzNqhHTdMUrfRIejmsUZmQOpiaTAEKCqZSG+duc41yDPNTqpT4Neyzus9TM7lRxF9bRHoOrO
rqtmW6puTl7JYKVUL61NoEujWHQA0AI9GnkFFs9zxfxleaYEeSlxhrTh74ynn9BrRQVBkdJ4hXvD
Qoz/iXm63yrOt38E+JHf9XNWCeZR5zoxVbZiyf5T70DKyUGyQUbkR5r1Sc/Y+A5jssw+orF/MrT+
Dl+JEXx3ktw4cSvmAjUE8MKZUbisdwGmwbbJJw6lr/fhDmYBUyK0dHv3b9z1Xjbg1DjOszDg3x1J
pFcf9YDfZe+MORqBwPMi7l+O9Qm6SLmitWq52nPoZfTSG8foWaEwNj4irqKu7NtwgPf2EtiseVkY
VwIzBAGpZq/I0VtKlywrxTL1CaWdWOblvk5hGmViLpC4brM6QZz+PBawsgRc9FoXoySIaWpZMNst
Z/Rtx9F8Leez0VmNg2oPoncA1dXYnm1n3K8OWZUVnDbd+FtXfUgoXY71odJzU5ogAseHyB5XYDG4
tfLK99uSsI6X0jJHKvmlLH7yjPWZbO0dZnMVXe4SBd7mV6pumUFrenvOQ8eJxJQrtlLjfUy1kDTg
2yNbDNCxS5C6wFwjY0jLMpw1magFtFUGWnqrr2TCHo+NtH6OpXfpsNcQ61VE8hspZsDDts4h+Y8F
1RkiPOcWa4lM8By4hgFTyxBhElBg6sYDfwtZUq5eYFYwZrU8+QqmPwV1iSGy8XiYZZgfoUL6XquO
iHPl39CVVeGdVQLklfDsV9SvRbt/RSW3qE4lhZASwpJrG58phu1CNq7ZdHYyJC33SzLmYaeGKmin
SoiYFgTQItinsIGoJ7SGMxUndAy4c76QScnjBiDa4cXoNrAibBCMfxvfXhUBOAEgW/pnSlWitYYN
+oXGCFeyMI+TRnH4rLCfSxnWZkBOfFA0ncZaQ1Oi9nK0HgzU23hspS9u6c6hkZXydZv+OenTjOeH
beHjdK8n1+XjnHtwrN3kjf2Wq66Aixi2T9BvMTivV7NwiSfj73lASQJ5+7U/dFNy7cA+9dhqSxkX
GBMY1I4GusQrTH/i9st8LWjKPOux97p9GDKW3BOZH8KHfjRm9eluzKJBxEsXgruZV9V2xzu0r5S9
SnH1ikCYb9gJZFdOvB90IDO8x6U7QH/kDeoAfLsFhTXB9GvhUO/xLNLJcgBz72Oa6SgFhnyjiauS
aElmdgvMEajYlq4KDZcUh+SUd/zV2Fnzsv34HxdDb1AJJbVRy1RLxqt1m/CFu8csvxy49KZ00eLR
k0mSGOlJ0AMggQLBKQnjuslAarFGwJSY8hXY9WB0dTSwjor1y+kexEr/RHbJgA/ELMHTYawRmtae
qmkHi96YHsSMje90rX34u+zlGEJqPpeE4s7goVx8G0lEC/dzUsPAGGBnjHvls/G+p1atZPJ5mE8M
WhCtdCQ7A7SEg9ySNJG/5Tk92EhRljpANkX8jC78a9k6bNn8KOZcd7Iwq1G1g0gK9eDGh0XxKSP3
9Bwpo7ZMoVk3Gd14hTen0QxLpckOT7pvzdwK40mZsuEAHue1GIsYRWwVWf+JToasGRRpDEk49Af1
UZuJzjdijSrwucQxK23xQ4uBvCnqfCCZ8SLUM2tai08wSYa62pYsNMhGCR8CKXyEBSBUzNoXgNoI
7Ks2onTZ9trvYcja4FkWNOfnINMvTPp0gQ++u5gVQrL0J6afYypP/VmqMA/MRM81R/NPa2yoHoR9
mYEUIfI74nt5tk6vQG+6Pjqut95HqeEumVEJAoRmMcMEKvMO082ybjoG1hSxB/R9q41Jk+H0ubNi
8IuLYwyOC6gw2zwJQPis8nC7tM93GgXkMZ1+ovLcH3Cjan1a5HNH6RtvQzltZGpn2p5HJNQDLFi3
DgJKa2UWOAST5yAuCdEMc26tGRpKEjOen0uKbMhKJwHFBuv2YKy6vMqnCfNwCv/racFsNn2iho79
cFYc/pzxsYolzWRFM3e8nAKD2RcuWWmLPeOBZV/BOQcnryWNfmvtnZsIJfsoa1FuXnNIqGLvbjDa
jCxD/oKrgnpbeKuaZdyZSxVgRDyJxX+INGypWOz1lTj0vzPHeXQrqPj97Js9tMHZjoTpbIhnGWLb
8+QHpeV9haBb1IJJWSgwg/jcsGtCg4xnsTBCJXFwsG43PFrhwx41XKUg4duOn0EnJklhAbIWeEKF
RhIWQ0yyMC0GA/lE0TjcRbaLAJpHR2uwyKFW9dcMmFNIGERTX1fv5t4QnwEfsKTuIZ5t7LmzdaSY
WPAY42wyUx7PMGsCkUpu3l28X49MaDgg1KGqvfcLq+D7/edYrtblAi1rN91Hk8CPsm3Rx+z7bPG1
ZeP3nZwwnidKivdS6HDbsbzLmQQ8nxDyKhLjkgPEK7Fw4Gsad9VqRu6+aM7xr5kf6BrIbNcUegvb
4joPY7eNKm/INNQStjj+Syod02eiUCoNXjKVGGSO1kdeOo80ybo4NqBNqpa9T2oJLG8sDBAtZ62O
GGiuaq31Ydiwdu6lkTzGEO+NHUby9iYDOX8JX/EMJvagKfIw+eMPXW17ASEwfelq10GWcXz9iTtX
QqvVRWDahQukLDIPaB7QsLDHlJcZrdtenFTLRRlzzv7XeTi9ZjYRvumhnkSb5vqHGs9APoSY/vxg
eUwR0KKRSXNfoHhwUB9J990+P02crk10ETbONcdPsVJ8v97HfhkYQ7OhWxPVTEkD0RB8eIndatii
ZPo/j7p8UrHRM1nY0swb9EeeTZMTlprGa4UGtAVxt1ijAgy8L7k/MvnR6J1Hh8dMaIwgCWqA3mDX
45mWCbqdEhyNIEijKaMJQ+pBx7Q3hWBLC+E9YqWmfILyuuFUqwtDS+pHthybngJPDBekFz2FRYJJ
CMrRLofW6gXMxULxFXoHOUxDPfcY4CHW/TfCXqcYxJVkSeqCXN/dImColvrlO773W6urR81BpLu7
d1zm180N/SecY+JbShpmm4ZrmkcZX4tks6Pap/bZ+nCWHvNM8ZXbd+Qwvp6K+OCkrGf7GyHcvNNa
sy8j62Mys4RTvzGInMta9xfpykw2bsJbBcrP5c/7eW4/2goGcNsMnGGc93YJrab9TH4PBiTUli0S
qTJ5gm6zD7lvRtBIh7lj/qD6+Be0MddKdWmJEQSiInvbB9HyyKr79B3Xkuqgsh07UVmbLmuxho6y
gXAnysoMV+JS7N2ncFMTGuc9/kbbRWj4mhQPX7DgD1D2gMOjhQxzc8hvzsulb172Xv1xzi+OI5rU
i02K0NvnvDjVehLbhI9wlPAM6DVNJhe1mzw14j2z9rkwySNWjr+K/5nujBx2cAF/cXCe4odkbuwh
Yo7GqatGBlMoxUjaELUYf54tXgcpnskYX4blrQdTGLp1rOzXkma3sMzmAnIk3kFqexUTHVg5wspz
9vHCt8APo2+6HA/IzdCiJdGHXwu1L1/oclTLzOzsVyjJbOMEjLuLvLa3H3FIrSP+CW8mNJ1rN2oB
pGRRnvqPobt+E4p7tM+0vHwlFMV2zCFZTPrBzinQcE0sBCuX7Wmv+b+paMs7auYYC05jSWq45NnX
6iwhMezcwjsSY1iF9N+3kLnfhPcQgmF1bi1yhQD07e0YfG5g7Sod6B+1O3XlI5ZAnFqT/GSKV+mp
Fr7XBl8xYioSQYBkQ9eoxElcMqL4QmvJfWnJLivBpyNHNjkNC5j6tdGgcq0yWBbVsP2U1XpeY6x1
/LRwN8n+nqpfhiCZQfr3eFLy+Gt8OIZkBfb9ek7K9gKvACs3RQeXXtwnX8CksfItnBe42PY37ylk
ePCwlmGYL/4Cd17M1LqnrIFP3EC77LvIrk5lE8WKV9CIs7RCCFwsgijPhXwGh7PqzTRSe5vIffMJ
KIk0XjSzjKAZC7xcGQxcNFLyPrqoKppIxTQ8/2aIN4bqUBZI8fSk1QM6xaeY8KxOvyUQiWEC1BKD
8rYQLXexJcFfnkHqiFuwU75v8wVoeut3x8qpNV/WZmKeZMaaYEsMIZ3zuHkKagxEXYoH6jHIgUBv
Q8tXo8rfrSLqiNgp/XicMkr1uJ68mRo4HDRNzsplR1INe+lRyrrye7M3IrDEfyRbN0pVEQuT73ck
4Y2LVACdUjCXmYGFd6WL407bus9T7jOvwS/jQNnE/hltMTnKPc1E0EHLzji3Wb7cTQCV+FtUSBSq
qzzg5AHr59WLh5Sbzf27wV8vtLHENpvdNFHF8+aXmNQwHQrU9Vk94b2KGWl0m86nV+RPyzjKRTZV
UPAJYQfbtDyEkZoVlQzFkzy+1/ORVQe42YL/l8a8byHGNb1HF2mwNmaHnEMEiYvwi66LtnbDvZPJ
4Kqpb724PcRoSRSXSZsLWQvKaxKiJH9+pOTX9eynAgBlJv/Du1YF6kE2R5+p2q585fCLBYxTPNVb
EHpa/81diI6jI9vl0z9gNgiRKlaeKsHAT4frtD1xr11ZQt9sMEJ7iQ4S7E4vOfyduosiv+7O91LE
69rsbHa9tv7ZUvj/h+5U2HAtgf+OndjRGBxzL6xT2KYbkutEL1zdsSsXQlmbIQtCT/rYmdwkGeTo
sO1T8J4D5+dI06ZJ2XCqoaoBOCQneKaTgplVIIML0JpvINKmSf2EcifLuDCpIslJeNDRBlvHyt0k
K9vbCRtNE3kgbcvLeAbdEb18ccLuuAE1xhLeYupqBK6Qf0A6m7ofPtpB7q7dKFcYZ6tI83NVUO1O
ed8wQnv2zfLGyXXLVUbf1urYZiKhAQC4nB+FDLmUDCbnoZ52p1WnGN4g5hEeGZQRuQOJb4uRx7Qg
YcQmWAYDM+9+qlDAFa6QDW06PhBQ3USfyEebe5RsOjxRba1Aya4pw8vQOd6N38rCrat9VqsNkRgY
tGa2L3n9txgCiUQp+dqpWhxSq5hxT/NbWW1NROJ4SSPFgYv/EG9jWnE4vJEed51AWfv36Sy03Uex
+pEEq7QT8UbG6+/02UxDPPmSm3k8aM0lLmH1zqXfA08CsMh1Ea8SnWUcUUDFIbuL7Q/eMZ08v2KK
mNORLjg6jUJKQfM7dzK3oZx7X2OqXKgSF2FyHNMWbFMktgm4Xn0w8KCIw6N9KKPJ0nsFXFIFjR/9
EPpnSs9+8qZqNZbLY9vpkaDhozG0xqvZIZm9rmQt0PXv+I4FUAyFTmYVJPk1IbFrKB+uvDAK7TwF
aBLEblvV7E4BA3XCyV01nVimgD+YPm84+lCMUlWN98Fo9tIzmiHreY3k2hI2NP+AoW5ONEGhtU6B
8H36UQXmW2VCs2+eMlGNnsQIt4lBPw0tdc72LyvTBnFpavN4poJ0rsbvbQtv1Ws+jdMA+DzJ8tPB
N8MxuortdIkZkLdRFSHRQg6N4KjAUY6zdSkZ2h+D7uJCgd1M/emVNih1L50R4UPEgtL7wn7kehGS
u4baGYN57z6pzte62004tw6+11XcMXv9MgY4MoxHmTgTwCgyJZWVCuPLTwuNLL4WdEu+y5H9BIaR
yWRx0Cl/QJXntqXMHnri/80Ax7CEPI2j+HVKej8fRbXKdKUnoQYxQWJ8rdUDSjy4qjOq2SP+k2+i
WiFzEEqvXGZ2Orujs2V6wQ65C5Rm8U3MsTCb1zpkGSCTXBRAV405uQTsE7FCmk2mNv+0Ne+yImLY
hrKwaIBHfR1Fv4kVc6vfCQLAUp+NMe24N1X3Bfg7YO4lQalWNV0BVTk3TmWAEzkOQoxD43ke/JNo
JlSNbLhHJXaKQJarxJj+FNraUURlYKB2q0QkiaZPuaUjMZduwWskzklfwXJUKW7wlo4mXGhkd0I9
+d2hmArKHBFwAsc15pC9rXEdgS2Rjueb8uJTRv9OWNGj1OjgYRggrBjLH+dqwT8EpK1cXif0/Z/q
NrHV+k+Q2zzQKZimPoljifDRw7EHGw9Xq8K45E8wjF0ZE/7nLetLGSiXn2nHHpMU4YIKsUSoo/xf
Hits1w6dRGEV05iYeQJGPrsGMo9D5G9kSn6kU+youuZN9zJmEhmBeKafhXzVoR8TrvuGiVAY7K1d
GWqjixx163UlKvyjpUzIc71kSmYwbVEBN9FlGRrsAOAErRAR5VJBVE7MuW17MWaMGAnSUuZmuyuY
Vn2jFJls6dvwEedlEnlKM3qj2GjPvScEKFEoawyo9eF6Vb5y0LJhwKwQ1zxoDzqKpZ74omAzZNju
W3dlHTY+7HHh2PxBkFUaYug8i5Uhxb6SI6h2dkGIftyHuROsqLHK+m1ybfDFDX1Ie2tiQU6cTSc0
KJgQYFvXxe1Ttnxao58nVam1nrv+AKwEuG7bTV5kiXFCYTH1H1Se0iXMtLpjTN8lHt45HUxd3K17
+5v+xGUpWL9jAuqZ0w5EQh/SzMK2dBMqf4FzdbcMsZuuPP7KIGU3YtJdWNj265AfsxmTzcq07UFi
lt+xNBY3xW1p8uetBRKyCoAAObq4sJdWYrjI5upqUfxh27TQmUDIQfudTHoKTtTdciLnzlgP3pC2
97GZx7F6q45EvjPbdYqWUbldykaCwl/jETJ6VkvJIS2ze63NCE6EArpBkkWsW3YaeWPz88uEZ7FK
wWW0vzxpvYnKnDT5FkCGRm8Rd2/M2XTYxzkZU5DeF7DbY0BBRSd2kWHYxWm8MWUFwLY57gEcUZ26
X+t6xFPY9cC+qUBPLSWfN2uIHL6dT7u7nb5xqhzB1iWp77D82dnA1HIYW9k87s3dvzL1QAYsX7xG
dsdv7CCa4WjaC13joyVL08gbzp0lAobv2k4YPFSlo1KRtU28Fp2WRy48CMcWjyYdKWSTJjjf+oH5
4sOEs8HtGjsh1pAnOELgxNa0ukqS0sb5tNwNClzWtRDVO18ylMl9kuOBEhCqjpjbHL7MMr9P2LL9
9yB3SZm9ICgeU8Dqv6rOyN0xH60PutdcOgSfHeST8IfDnYrHiT/cQ8krqhIjDf+NvQFjsO4Sugj3
HSkcYuFYTSBP/9+MnUoQx+4j9CrLMqfnnQwB4AC5/FWvzBHrlp1L6ZC25eL57KHklEN4e+8kSji+
HhlBL/TLUUaKBm6Y8AQOjV4KWKS/o6PRdhtlDnMvvlJm9XiGP/ZHVexqIisN5gvdIdoMTDsPMR9X
IAfiqefSxQGdKmuMky7apOtda9/QE3rWmHYypTiBhDqhwRNlTNLj5Y1AbUS87denXZWb1rIldnge
0GFbT9SOFtYd1tfimRLu0UnDxtB+D/W6oA51DHUrb0tWNoz7Garo5ab5WD3Jb+hSUhrW1Ws7RKjs
xtfeVRO527MHlIsDtICJMiFVsAQEaJXo8iAMNAlqsiEzq66UX9fkRO2i5grEzG/X5gb4w9MSYUl/
d6oS10UKaLfGmxMPlhj5+0e9GMgHvlkooTPcTooKKueer6SDgOZXl7SamLaBtQ7Q+f85stWxG7Vw
EasYmnNDGF8LxGPPXSF+YEQi5tYBXeiKxyfmxywqggTwxP2OExxlD+mXYMnMa8qiYj+pX/oJwB0/
k2aYkAfxr8gFcP1Q6NBUV6ak9SwUOrij5NM+e82KOtXBQIyRVCm7IRYuKCxka1SDwrU7bdG7v0Ud
A9z1s7ZQOyb/uNDDdFdYYFJiL8xwjgy7vJzjUSExAInu6fVf5p/RiXiSqN7Wm3M3jsujPkCfgwtQ
wLU+YxweTDC9a49pgMKKDQFGIQwhMlKDASrXe7eKCWNToEDB8veUXywwzwatrHTZGi8NXtV/COku
pGQsseas60iH28/FzsMFi6HMRHuWm/xYdhRWAgjaylWHV49rDxtUk5/D+k0ugsjMFFZcD7saQGKt
oJ6FRm8mZz0C8R3A61bTR1YdR08srK+xvYenBwz25IoPH6ybn1/SPgreDF0JqwLI2+yhZfz7LGm0
wb/J3tJNkJuPS9aba1LBdEfDP/QQa7R4+v9TbZBi032Cs/8iGW5LBUUipAdkI0o6lutW2AAhhIEq
l6LOawyrXpWMqykHk6yskfZTkm/KQIZB/h5WeZaBxrqjN4tK7gO83x/b1IdFwBp0THNDlwWRe5GD
4rZn95l5nCj/I4u8c4QxwYYCz+eu0vsK4cb6XaDdDW0Ws+obsAxFORNPupDUSZVbljqQYE8dXq30
9+bQpk5ydM9gfBupwBWgCIDOgCxNkI5WxDcbr2G0u/N0aZ+qxEOvW6yJo+K3P+8YFS3V4oK+hXcC
n5HEhQsNIhdEbvG5FQ2oIij/E24Z4ZHbabVbUEEiMKniEo/gT7c3bynFpFu7Gbu65PKLeyqbj2YP
hANo1yOYxRRbNIeNfwK5FwC18MJj3rvA5YQCvCXx8E4+iWLXvXjUABG4KsukiQYC3smnMKUr47a/
HK8T9PLLM1Z+NZGn8sjshl9rfeMMYfZYVc8ZoXL9jT7hAUM16DiabxLCAu7clmGbeqx6f3fXZrIA
1IBJ3VYEAxHkDKHLshQjfaCNduiLKnnd8dVlBT3ZlLh4xrCBa8l/Lo+bGXUuBQJjWSJz4FcrLsar
2bbVPsnYEhTQE83MGhFfa+H2CCd9o95EsQbmi9j10ll6+wcF2cYE1oOpct3kIMD1qBwTdl/2X53M
EpFcYWe/oyL5YJ0XJ4nB340oNz9BibaSfsVOP98rCgFs3CTmSb7Kcm7roC67nbhZNq+MsLirSaKM
zq0vMaRtpuNhSlyRPpyuJG4BhUnDViG3bLnSVCbpftgcMyqUpQt94FV1docHJrZJ753wASxyISA0
AjCXNU5GNWX3Jo5XuI8iFitWKy8vLy8esrRj99Meq8vWpE6aDXBQgDbOiMGJtTI1MdWDm9hxdc3/
N+FVRt5Gon5ru5D7xbOBiGq7Z+bYuTOtSdOwYupwC3+a5kZzKxEsyU1UV8e93xUGE+u77n/nkcm6
3sggwAJfX/sfG+tZ7yKfzPumyWqb68Xy1AyEpnY2OoLAXxZBpEt3/aheTCNb0IhUfzjO6Fh4xZQD
Ir4ytcQ3kjOwdSZ6pDmTSYzDCNDWMz5Q4i8QJ/axgS/p3EXBFzeoekuBLmrxAp8n+OBwGf12t/gZ
DhugzqEKiWFfhKba7JFj8RdxhoAm/jDF9REIPArwuQo+IArWIEn+SGFzEV3jQ64JZ4eafghA4P1U
l3NkG2tqSemj1hRR7C812IUO3ndc9mf6Iv8eAfTtn4rIQuUYHucjDjmrthBAEmpip5OwDw2U9+MR
o7C+QasLldLgIkUNjimGXg9vTex6mFnmy3gl/ZOjeinSpHng5beDdJSjDQwuuolcYI6dd6+iO+yN
e37Wqn3oxLu/qZR1bneA1JPtiWYDCmwGst+4SrBsNTa0Iq/ONINhLDT0KigfTxSRToZYVax6Gy52
+lOxIgbd+jAVHG5ZmV+B5Josl5bteLWC3AEuEzM2c4+79AjHBrZpY0xlmfF1Nen0HYb8pgnU3AYT
zdTlHm4aHBtD5M74NgqtUQ4drRsVNfoHRtB0Ud8x6hb+VBkGc7k8YlzxiZLdqNXt1COdjOcfzvI3
rKEQP0uiajOm6vzQmY6bXj8pFTNcOOx8pXJaYA1z42GCn85MCRMcS3ai8NRZ/7vm76UQjcNvAT0x
ABjO9M+8UZaXC/8EdByO6FLscfLTwbO5ujoshgPKiOn7iGPTfcZ+WZWPUMiOhXHxj+GOBIGLra+2
s0QNvcIyAxrfAFMTJUBXzoLHqWHpDNmEhAcOSU27MR9AFD5zSCkVl26ZWegM5jaKy5QpetER5tKR
KepG8QHmmk7X9K4HUZLhrxhFg+f5hH7Qkn7l8pUF1VfmqkkpeN/fxy9RsyVU4hDqtmBiGJ43LXcW
Dd+DM9J84hTt0dM6pG1LCLrnlmnKiXVi/vlwx1dqj+KITPfwxtqO15BHNpEjddD6Eb2jyTsrbYNe
0zU8nw8xSUJM54YFwEnAIug6Lr4kdUrSQh7gAExQeWDxPlxTccor5sYUwkNjNPGQC5H1wAUuxk80
Cm+iBC5yOA3Fbql9SSEBBsTQ8jAKHf13VbWKKcaeqP+U9BLjAW1G4nvxeiAKGqa8aQr2IiNsDcz4
cx5D7NE6ldal8bCQ45IkIdVOyEzuPuXy4UbLzMAkDJUVZHi8b3zhXxFnppKPbHzgyelhzFFTS3RI
h2TeVhHZ0Rj7u8GB/Yoxx8ouu6ErxTXg5iVEOXbhZBQ1UYrBW/aVv3SqOgbOyksK5OSI7gikp8O8
qpwVbM13dWqFbqatOZEwvF6XDT4Vju6psybvOQ6AuA6/xUlTNNoivv4zBqJpoE/dxS4cghJzJnyC
GIJ4vxBqJiJvqCuGVfYBKqBQwWC5Rmzz49kBW8reUtPnA7ezu5hzsTVmFlNl17mEJs3Hg81PNOGm
rS+OGEaM7QxSiPBvqESYYFGluACHkE4bBFsXsymXA9oJccU3U2EK6wF4pDmMSCdMBxQvdsNIj+PT
zr1jjgyUlYEOV6xQ/mFb2dFI82uQrT7PafqhfRnIEbt/UxkgfUDXtTUJN4cleKdGVg9Q3jow0xyc
ZyVIg2t7hv2ow0yVCVeXZsuTUnLIK20iOSHCYr4dA3tiEe0o5iCZqcxwAZ8F2n1aEMDDZgd875Be
2ZL6BzLcVeE/aqr0uzZ7xeRoDKgHigTn/myp5O8vZ1SqDj+SPMOtk18PFEzog0oaKQlH7YfEWtR8
wbtwJYuayE7cqui1cVYDH08gbTRs5nKZdgktGJyj3j6C2EFirtv/poCl1vBjX6gKkpcIe8Innaac
Z476FEnOkRljvZ3we3X/SvGtX9VET8bd90HcFEI4WfkPdXoXFbqAa3V1wPf/tTky1/HG3FqLpT10
UwJW3zbq1nwjEpxchA4q9fAk3hWw40GmJgTTT1gR6Cql4mVPQMsJ0kYs8I6NC+ZCSN7aG2XvHbfT
S3RTGmmXt11KxmZ7YmghlNtj7cSOo0YfJ0wJobA9F5Gw+MoleMr+fvk8CajaP1LNKcH37SLs3L7V
KeU772iCKwsiOot1JQisOgAV2Xfs2b+HeVfgVZGnZO+3D7kkLrI/hjxg6J1x9Z7gqpBdBK6uLv9R
Nnmtu9DHM6kUlEloG19L1fkpeyBXK6338noT/HhmCOmlRmENU5vhEMdHhtgxjMihrgUBSaAjL7ne
qAMIwzmv+Xg3PlxH39jysh8cd2eX/UZbRRlIlP3q/zalribyM0oOGp50YlneK5AAOC+IoKQkmbVM
FB/FmG8iJ0q9H+ixo5X1Y6Zybe0J7Zewsx8FhyIdBShzis/5LJU92YYO5REWWceSI3Fpkqn46L1p
9CWq+bqj1Ig0HG2wci/lK36VTxTH9vU2Ujxv1havBhKCZIgvGn0Fm6y9Aeb1OXcOEuKUVL8pyspR
klXuVVqaZc0yc1DHFniUiFzJUreGr59ieH9Y2U2SFIec3ZNwYnT0YKCzEfTGgLO4IvGPk9FEbUfh
e9g/sI+/ZZqsu1ZvnK4eE1g0wSRRtC1wZS29THzheIkOZjsfSZ7zdRQ9GJjtXbumzi4YKL1lei3c
dBrKsv0PaiZj/wBuP1UZh7G3gMedCOVTJTXvjJTnrv79SMFAq0HGvzuYoL5JYn4pnypLgOjPDM7P
UJ1mYGmcwgoK4/3ldY2QS6b71BlyaROT5JQwcBvHyWxHm6wwyRlpAGBUxijBNswIFgTM1a3k4NbR
8g3lL2x1+3b384qLXiRuN9DHAWflbsadiDPfTOEqMojFh9IAO3gpvQ3u6+AZ41xDXeUqUw9G0jyt
qnZH18z13AK7iINEdyhJfUDaFFwVWbXYyBk9+Tzm83BrD3WKMm57syNWgxoVGPsFIi6tLNJUdI0p
x6Ko6vaUMKZ/s41x8ur3Eqo1jbbfK9f3PtAzzmSaFCkG2Z7YbNLg0HIberF24wIu9UTd+a161r/S
1dNsjRzPJPJbRaVGAONVfrohIdCfJd2DvSSSInMF4sFaSSvO18le5dMZgHUNmgpqqwS78ZBh1xTN
6OaHcuFW1AuYFo5VUld39xz4gf+avzC5R0kDfv/QG8NzzaXDZn+6BAJABNtHMUT9RD17aNZDQzG9
1A6FizgDm62KLiv6PgOAwLNNgHYrCfSygR2U3vD+sA1LUlr6bp0CANC+DfiO8XHDA8iIkX+bzTAb
YXEP+dsRI0kXx1hxQKuQrs6RcuHARfG/m8OKBhIg/z6JWsPMBxaoGtIyjpwlYbKJ45vScWS2NvLg
alyR2amVUmecd9B0Z6pIlyKU0rBGhorhb0jURKw+cYlnl20pyNWRcMVRQfqMtmE4+0QroodX6Cai
Ng9XzVO4ZOsm7YI8/i1NkNd0ctGxiYtLGKjj8MJ7kX2Yf0Z1G7pITOc2CQ1jKEQ4v/TX4VlpYaUN
bLe0HmjSH7nqoleMPYlCjGxiV/6jDfAWRw9P7g8XIgcCCb+8mJ2PqKOC1Gsi7CASKQHPn/hhQxyo
NbSeZMY9qmdnl90SEnaftPq39oTDx4c44/4fwLegZ7Jv+YsYn+N8Yu2Nji+HgNSKxFv0vjyBOWfV
/Jc79C+knqfjVnrqLt9ZsJHXBwnFz4pvY+Z6t+QgCUVUzDIzVq/28sNCFDv/TcPnGEekaQXEa//e
QDHB5WV+UVr1ancuiQY+WZwyFjoUDGg86OobHHIv65Pws1y6FJM9nb+YFPaqUVltLcs9w5dY+qa7
Iy01WyTokyk7nyD5uxdufS2YHotWgFSB3LpPpYdoV7ndLxupNBy/lVCTbAwOdl2h0gXvFxHI0Ip1
0kjeeorkxOMqFa9aekfJsZQlrz4/3ULr3I67RR7HcurxcB8dwYkljmcIta2um1Q+6QCdvOHtgXO1
XR1sNqt54VaD4Ww9a0bLFJzj3cc7p3+XT1AVLqM/cmX83srSSjsx+AkVY7PMr4W4edD7Ss5b0iiX
h9oB7bvDbTBo+XsdjPmXmh63P6bxf6VLdxsA5IB+IlPmT2YFDnaxczJyAETcngHKNjrNqY620UNl
5IkbpQoBxyxiFMiMOqp6iIvHO7/6fXGACrNYtiisVibb0j642G+WXG7MFec81Ie2gcaZQrjgiF0w
p1dvcPzVMQ1aHMLIcYkw5zM8ngvgSVFsFn5xXpRWJVIeoYL0GP/jIYDLGfCmLwNPgo6AyjL1FPhm
clAzj8EulGLqTRY+LwMjUtBL69D+rz2K2u5a3gZjkxQNnj1aUxSM4Cgbnm6gkfKQPnqZKFKh6rSN
ukSkx9Zkbm/0/5FGqNI7WKelntnp24Ro+Hemi5fR71LLbkiEOQPgYL3pnN4xP0DfYOzsvdwv38Gi
Tbz/HHRnZ7yXWwdThy7lCQVij1VcNL/cZkFo4FYHcqJu/nU4mRiAAqr2981Y6/cgkaRMfCTPFoPZ
yf0UrDZIj+XZVaOobqev/KM68rAgUAtjVbVyJtBy+JxYd4nJGY7yj1t3+03LOsL1p6yeicGkKf3D
17WU4e4+5qj3DynPVkT9Z+ECPu40UNLhFK0fmWeFHaxUvNplYUXdlpS4kMnXk/ah+KvB0l+M5rwa
6vzZ337IQ0rLMmuN4JXbCY2zdATlLUaiXZmJo2X49g3sO3iVLqG8kgxibXk9xP3z/puH7ks+G6Ev
M6e8Pfj9mfv73B14fyOqzXv7ZAonhYE0Ibw9pNBw3RbNMF5NuCV2jIUgo8gqqFoor3x/2jGYj4zX
1dJU+pP6hXMnDAhO5DR+H8x15LdORVzHXu/vLO6yqQr82dJjfTJK0hq5SQnDuqkctSyxsrWA/1KD
egGesjCr4aa4y/exEVj0zfM26yruIfa2Tnl8KYCcQAzcyWNbxC55pThOX8ohLMBU1Zr1jDHSwUxG
WX4uGZysJsEmRofuIbUzrIsUdbDAxuszT3otefnp7a4U+RjiUQrzpv3VSoah1dS5XkzRb7YjwNzr
y1nlzWcf1+Vp88+JYd9KmnMF1HwNHgHLgufZO6CxgOYNhDU1ywk5NsyS8IWpMfbxI2rHE9IGAOB2
fGo6eDEdKKw7MqJZnc/JlNb2mZNsbU0lh13Bb8QcV2paoKQ1GRC+rjndW8eahuqKLeexe3iN2uZI
vHeEjkc3waaUvnl0vBxCf4cc+pan5dPFuZsgVO9mEsWa65N7rRzAihSyWsg54uK+YB8b3Y99zXQZ
LN5v9fdloR0+G9Dl6VnKKhKCnOalixTcu4zdPcuHxp5NTOJJbcNchYOSCfufEe2k3iKqMbFvoIzR
2IcD1UQNmL3ohzjP5s0S9cesytpSSp0qgT1Vzy9C+QCEqg2eY+8My7DumJfo9LaggdWn81lpOKta
nTSU4s/PX2vOCxs7TK1sRTNje6yblcg1Hzlr3R+Nm/PwH2pP/6oO01HXAYCE671N2Tx8JV7U8qie
+r6E2pAnZlMOkxPnCvFOtNCumpB62g5uJ0xHXHLfOlCyTXGcv3sCmdpAuN+/W/OrTUZir0pI8BDE
gkho1fsM7zd04IlX3boqOYj7M3C+qyW8IcTU5qZtNR8vvcq2LLPF6snv1pbe1zi2RAsOuzbI7CGb
Uzny0PfUzcHMcBeqE6vAjIKs7jSu5z097nrPJafHkqxK+zgv/TxkiU0L9AGeWdfEStY428L+GT6b
Jbb75qYAaHzNjBYvQo/DMaQcbhLrjdod+gC8zLwV58/1Syhf5aaTo2A+icP5cjxFgRoQzryZyxw0
GbCKnQ+/wAi5hMBMwRrHAo7VhcaDzNdU2IjtmEzJaKrtQBN/WjjCGxaGEwnQgERdakmaDQt/aFgv
Rvk2A2/hYaviGOX4MT79VVnuTavto1v+nstifYedXLV9lyomvR7+BNOwR9Kp2Zkuh7T2l8Gsc6Cx
lic14V/pYY6Rp/x6DQvTQgapg02EsJqvabFWtPGvD5MfNhSD9tQfDjYF4gzUCFx7BBajgBWAWMn+
Vd1Kb+qBLe6ChdUGGKHm6v+YplGCtQNWrzMzZHxwobXC/dkl/5sdJUNvlZbO6Ia4Bqv9w8rGaMgA
xFjt10air6KJPDCQ0Vs9KmAxu+JFRMTlxnE45Robw7PlS+yJ4CBrK8QA6rOXsEy6zyahT9+FQOs5
/Xc+KqQoPwQM2CaPB6dj1js961kChrxkEapRVgwnqkigBFDQoB3+ES4EyLT+/eA5+llvAvWZnHgx
ZTIa8T5oPk+ZN585dYO3l9Pg/6sRpxspQTwN6jeze/1unWH1Nb2hEZDn4WgK6GCVQ8BRKrBAyTUW
zUoMWH3/K2/3LBE3HMVXPfkemmhIm9wg2sIg0S6aJsiEP83qCA52s5oc4xjqKolyQvqOy8wb2YFj
9icMljEQXINXdIl7ua1izum+Tm5Pgfa2kNl5ZsUi1Ftr5mTN4Q4E5rEObMqk+mt3B6PRVsk0RsNc
/WdubC6wdy4Rnc+r6WVG33o6Ue6BFd4BuIaacwpBzvYUPM9g966XzdZ021nLD+6yYP2F/ZldNOQE
tgaafnMkwR5iLJ1QYclOwYvHs2Wd3A/o5ccxR0LGUsntKS6gNSSej+ooDcYtCxYCUL/1GNT/9JXh
AFaYoyKI3NYZ6LOuVnQ1am3ojgVFH3XVspod6BLoNutwrBO2kY4RA/dczeH/5FXQAxEXygBduSve
tRjm5kou4JgDaE+EJcLMrmw98x1i+qdsezVCm/3Q5xIoWCQF607b4Yb4HNE745ikxxp3cTZaBfLw
oB7X+YkZujYyJcd2zi/lSUkRPH46fRSTc380oIcEffmDQI00YJqQfPoLDDl1OD4jg1fIEzLyfcgv
0aA6YhjeMf6OKHikvhdr2Z/mdZHj89KMMyCejj+jxJGSifk/l5psLRIXvCVMQi05Dfa8FpuRjV9H
P80yJQG4N5o63jkiqhMYU+mkrSJp9U22u6l8ol485gmQmsJEzlbbCt6sjG5PFE97qX+2EirxCjTn
mi8PzvtA5nHYSGqoCqbGw6KTZruNPIy9DdsteubTCY2ELH3irtoHEJ/NAp9Ij/vVIbGeuxlfKjBE
1nlP9G2yLoiIMIQ9KVdI5XjC+qT/C+Ken5cQRUqtiElEXfQh/CcHjBUg0KE0UZqbjY6IEigsH9cw
fwPAXaLqTbmhMDw7gN7VjeVH82yfOvu0UbfPfuvmch839IJeeQ9TqfTUvIL5nL3FQQDwNypajhDt
x/0IRuSfyLS+Y1hzGXHdcVyRIE3hwrnGqSSTelo2obXbHexEQruPBQCwqv29yZ7Hv8SJSGntvZe7
gKQ2JCQ9Fdhf/4VKICJtzk75k6ZpcFabZiWsTXvv8JO8eGbflc55h1nNko+ijQFbvofZtC4e/yL/
2NJ8bQAi9EpuHPKSvOrPEtENrvGkXs9+d7wulH06V8BlzdV4JJ5az5+Q+Lwkq7Roe+Ce1nBQvAvV
uWqL2rMZSm8hJ7Nz6omsOvFdYlXyY3woMYru0zwCduZLjbb4m31C3l2iMOx2WEGtCQ1/HmWXvJE5
WcTeJJUyb+2rUuXn3HSDq44ZCMbPh1m0nqv2WNUi2BshPUJdg3RxbdEfslaReck+H2OrojOC5f7y
7GA4Ey0jDywg3ZaFf/Tnwx9PwhM0i5aOoj1OO2TLB5x6FxX1j1M0KeRkdqCcpB1rsKmWgjXALy7Q
C/k41+go2NuY5PvgdDzmpy7MZ0wgGmnc6Pwwa6/o1/h9gQIL571jlW3QgGhI4zN2oxCvXK5v3ZTt
Yjj4Tiu7pmgeX9PeGCEU73QD+oeTrQ7F83f9NnM1tsks5UkmBecUCE1ouAJcZE8X7OQ3DJanbAvH
bhn8Xw51+IRe+cG4A/6E0univnXF4iUn/VY7tszTJmuptbL8k9rOrnWqRcG8aqxcHJS8pdIlj0Bw
snKmsFpyN1fm54H7TFHKLQx4uwAf//VEOYJBi/s4hHc/vcIHZRlM0BtazC0xMU0/vq4QKGNjZiyV
aCasxdVnIBYgOglPVGNzf125IcQOkrePgFxEfZYA4BCb6drrZfSPG6PvnJOtUySSqDISrKhFO5c2
vfLo0c7mbgdzZw2T6yYpVbzS2lHBp31UfVEchrueFkSr6wPZN8BRpK19PrOJEqo8dfqYdf+abl+0
xxIgxTWG3b2zGmhqTHNSmJzSSNEmOx1gpKa+JuFPqsnbXEOAGX+uXnfGdwHl73bue922zFq3cu6A
Xdw97Bg+tyZciRJ0DVkKvpgOE9lgWER+tONQTJPzFAKQsB4eezHZ2Z78RFyi56eIhMnUnxs9mmLa
oSVGd/2+g6Ov2H+UQLMoLvqxfYpIPvgqvc0E10dG7XOP7I9bA6PnsbAOkbuV8uaq7G44Im/LdE/7
0kMcvdvFUHwXAQYX4mzSE+N1HdihfVV6cH/qHwCfKxcHdaxjgMT0W+KMmlFeTq+lAudNRE8IMi2w
9ir/kkdLmyea2M/rwLRvErCEQf0/sqhIYzHg1WCFQ46FsKpAmQMM/AAoz+GEwXAW4ARLt0UJsnZR
FirbETV56uSsCaEDlwGCxFQHC9usB5TFWdxYOQX9sGL9Obh6yDND258pceJT8lCW98Z2z9xdGowa
Dqe3kyY/kONiYjLlcxMiRTRYxgb3zRtxhaOGswEBAAJon9EGqx4/wcPUPnUpiev2VE66+piUywTv
M98EB5EuAtaqQaUze5BFOVvtmByQHPzhHyLAEoh4KJ0wPkNC88IIqZttCBFYP1Ku3ZFYrgnYnEHs
fSLnyEnAabT6DuVBJwIpyqz6sr51yioXmgETQXKc15mFTIaZkdT8JiluFIHJt0FnVxgvW0LMw9No
eP0Fi5mMHltNxqwJsJEUY6gXUfifh9xv5blOFmoiGxFVGX0qvGLypj6tJ/dGk35W8NdzJOAJVMac
h5nlv4tamelW9fIAsAQHkvmQEVM+KX2VnJSZS062dMgCMrAF+JAX4y6lTvn5d0X5HUyoDNiLoxSB
qApxRMzm/1Y3FwTQlNVJZ9qGMFd1s+xM/0oFu4/HhIeOF4qkN+c5GzfWLbQHoP9wR3GXBQ6iywsQ
ltHuvUA2ri93h1+TehJzi1B4a0wrNASKNJMzhiXWij+xGcKxi+20LFcRYZFacdAF4VII8+9I638n
KWI52Lj7oyrRqqiSgSgJqfDz89CZuCz4SXY7xiCRBsjBVHidGC0J7bs00bZ27fC2AKvKASz6kaeG
QLbkr9HGAROR6UBxsUErCOp9ZTC9SaDP35COuk37D+FhBUAByQ70WOdg4XlbajsjVpP9JKHfNf0T
ftfk3fA9thKOCpDJlnLtkQqARep5xZYYVlbwmrTc/zY5GO2dzuatGzZwbAPw26TrrnKskFV8b+y9
h6XngpetBCOgDhjuicP5p3nrZNo+Lno5P8YLteily1TCF7FGDzZFZWWahGjvmIEX+SBDcRUQ/gWW
rLIlvuWThZWRfWl8ZIQr7jZ8E7RLuBl7/Ag6Kxni60llclmwyW3W0zMmO8dlM9s2CjkkgGX7Y5lA
HG3jouHVy132BnwjdkRHoDpvz9NESQ3vO9tgdVSshaZGKIJg+RPuRg39ON6tw9z7H8R275KdLgHc
07uFiCxDoPbZ+Hu1wUjVdOdSjCzwzjVNOxVetrH9NaqlqyB9OK3iAvUYeIp1u7B1NyblXh954R4F
beOjr6ZRNzwUlK2Y+DrAYSv3/hPCVm75k59K5f4fKu/SXjmqZoMGdotj+JKkqtkF4tNYdj2klG+Z
vfEeZcGiqpHUNevNnICE7zjV7sgNQryPFbGH+CfO3a4Mdz909mp2X5WFPYU/7KoIBBa0YzrrHp7X
94IFPkqtV9oNGMZNuCXMvkFSVujvjoR75TdaNeQYv5gOWcWfbLagnj0U9V9MoiWu8ELfc/bWiT6Y
Q99flvcMxtugAO5VV571soqZYfmaI+Bpvo3jV/FjBOPXukjudY47yplWfZ8qBP6EJIUehRv9LVYe
EN/q4hNNYIwddSgJfCfHdw728OPiVI9C5/4kIrN4JM079kcrQmpAYU79SiuaXMS1n4lL8R/Ejf0R
pi0mw6hVOpdHxTBfmpxd2dJbYxOMjyE51e4klih/Xqf5JQzlSztrSeOzymML+TuJAoinISZIZoS2
Q5cnDfcgXB1fYbG2VL4xYgH23kTM9az2nIJOO5QLsYldX464hMjTtoxMPorm4E6wBSjFGG+EbNKI
jKyN7oq4auVlbFPcHeel3Jx/B706b09WeIsx9s+sZNIvtoKZ4DAChlAH2QSF0zjoO3jlVB257eFd
CcYiKoLdcClApLnTf9/75iUxlvj9UkS6RmeWmWQ+CqzLRK/0RbDJEw3PkQArTq50YPtJJzMEdT69
RB+nSRfZUWxNwoEgfbSQud7YxgDDPeXuvyyYjpiyygiDDPoQWYnsZjnGlQVooMUlRLSdsYPExBii
QhzkkFkpXuK6EtxHn/38xNFGwdBJYyGy+dWo1KvF9mCEhb+7SZY25AlOVpDThHDngj0+PXnO/gt+
/pd/AKm93XDBUsYFYXtWA1dR4hRcaacZHuRWPHA1lH64TAKBWvL8DkwEF0HzEwkjrxDTCbSeXBBd
yFF4MhX0nufjbCDyrCwkdrIKnMq8nybsjglDTZAU079Fscmzge2TzrKTdrFU/Cov/V7Ism8qC1w9
xHs/2K7MkFRUySQ1n18E6l/9AVenQiSKYVMd57PgqnBzFpYajpjUE0vU8W6ZGcUGnpAkfq0qlAUv
aPVThM3e78VD1wvnx39SQNvw1CbpYwjj4YZlCWQzz70c1ROyebYg5FRACUif9ok8NMRlcE5QrRql
oVfU4ccCe8EN1cSckBwnr4glgd/r0/mrZB0SOetROSfjayoRyfjVyDAm0qHysSZRVqFi6T/FmhzG
zwexE+A2nLgHsl2vcBs98kl0F9ppkyexMR6YQ33+3Hw3njnoBtdaUZS6Hn35+u8/wvJ9awePTnsC
XG9FXFgOxGhTJq3ORoRj5HZrfktjOHU5mWH1tKyYkfckaKqlADwP3RmdZx/rWFeLmp663cE+opnd
THpEcs2eXQejgoCNBSiNzfSXWNtnIh2a3OkMxmcl9i4+578ZHNLtNmMVrOC7VrjlsY1w9fU7cKV6
UnJDVRC5ZBqXYV96eWXkGoOBerEjx6+UBKg0KanJOUWeVz5JvSdiRmmy6B/nSMi4shHTCM4M4UzM
m7Sm7Sk5/aS1CGnrhjNN7wJLecOuL/4fOAI1zjhZdZjFAuK4yeCRAhZoRQEiTHKSrf/XyAPCoOec
8RE/2kogxegSInu2loLHTTInvsoJtfjVPEituwWRNtMEqu++I3NLbHnc9sRjHsiDHqBgKwSL2g/k
vRorUO4pz6DHtUL8f8lbmFJ612YEBmdF2s+jYYAjPIDa+PJvwf+EpjDMh0c9//rVN5SpK+ad51R1
EcYhtdj3N2/+RU7MmQ/lOvkLxfu60QJK66o9nc3r/HZDHN3x+ND+k+QlNlJbEPngjzBEymRwItWK
/yIGkSVZt3NRnvijYywMUWUMmxnPTK+lcEPMESgC+XaWwx1iGJyHrM95cnP3w+CY+mvO23mXzNev
GDkwBnUVEgYCdVQOvc5s93zFUnVkTwEZhfQBSjCrtzZLCrVWieRCbflCzwLBljEJH4ONSJPjDNpr
dxO+qr6b4oeJl0ML6Dz1oYdcM+gI5L0tnwomgS1QE//5aZyVBMygsvE5hDHH4dNU650SgPuWBXEr
HvNu+xMuK5ebqg2y7td3xZlJIr7iV/JR+x+fTzb7PPVex8I7WcUoK/Z1Udg4aMqaopOfQdNFsVG2
18PgJWRIlK29E/ykGnYA928tHkA3U6RZecZV1Cfkd0IRQ2rqo8sxqCyDoKlgFVMtPDrn3HiO0KQa
P5JFkhKaQXIgBr8fiN5gO460LB+0nKcu9O78y/KPcXqUjONcRL+M1ejVE8Kwk151GSRgxhG33M8k
eqmwSndSg3SV3ck+kIJKyYmXTuBYihFfA3lvnje1AMiU9c9u+y58OaXN8ruFjL/J4p8ljwsnwi0n
idKADEgWvvoQYStJXuwooJxfnc4WJ11DeIxzH8uh7oqcGrg8Ru7OOKoC+kttuG0BxIKngS4KWGmV
+0ZNNvKRenC8nVPZy6mdgpddN0NOTTZ6IigT+uH+cZ7tTpMcmMHbDnFGZRIs9lVHD7c1iX1c8JWC
uREfUMDBXUCHCTqGcZf5+LmLjqEPQ6iuLIFyY1nIW3QupgLymbtc7VDHYMMl+Bwnly/nzWAnxqVX
nOyBklCRg6S+WLw2eR3JYX+XTYK15BlNwj19N917ylkVUB2v81wj9EuDS56X0IBZvJ3GSy/T0wHa
XLVti8S7JE6OUwGUMsJ9eD7H38xtGaPrcX7s93NhMu9DErQ94Xz6ByKH9FWnTOg+8AC1pBlVRNIp
kR4dFTsvJmm3GfpGUJc0YTy5/aCYfzscaAhEfypgbWjIDp4cklBNTlCHaLeuJ3W8et4/RsiBP4fw
xPCBf/5JGWCeYIpjoUayx+CSr07RS5ljP8OrXmdO1ZnYHxQQTg5hEEahkdwzSrjnpo6N60vVmQQm
BkF+gTXDBgNpSsYzB2feXyNm/iZ2OI6Mt8E2/tHgSZKty6h7s7DAWk2DbUnBLoLbHnKaKA70Lmvi
lLII+Inck7njmZripVKzGJmMtufPW147gqZzwT4z3VJOf8C+gJEx5dtDDrG00Jh+4MfGAS5j7oOo
pYsd+UpRS224DWG+6/uuLLKqDYjqvi+7JRNcM/RhgfKhKXGGjmimKniLM3I3dcL4KQt0nOIFNQu+
nVD7hs15DjP6KpYcBEKh7scUxONOPY6/ZlKVI0dblulhoxiymuBvsMrXFGehLiXQami0OkfmJpLH
kH/LVC4UNE3tujzqOHoC17tEDoKcOxyKhwU4Nvj3vinGj2zwP8Ts4XLnwBu5PteVQRyxJw+7k/ni
XjKv7KX580pv2zDi2OW/jc06MWd/X3EPFfPlN59o2h6uND13SKpy21SB059M+Ky5WRwK+ceu7WFv
QWpjRg8XVi2Py2mV+yKuob1dESdYVx+Ux2MW6nAGo5PX/MQB3C2HMWyORjmhURa24nyDUkzp0Yz8
LbnPpStWCnpcBm8a57Fo9bRi/YTaavBX9wNzZQZBt0haAshWg0TAn7mfg7jabvPNZ8512ThxptgX
wL3mbI9VjDdJPBmc6+bsoZa591a5+xNvlUT6aGTVGHGqPENsF98kHdMUEFchS6CyKbbClMDEaZda
54OzDrD9EcOndckPjbIwbti03n8P9Rdo8XZl0zcFfe1E9GuwFjJQmNqV1aFMS23OBxsNNA2TTUop
A0edfB60dzTdg1o9/1v7QgRRO1ImzAOszvD5Kdc2B0fi/pQXIj8KYr+eYYeXh7lHRcACjCqShGNj
X/ucxO/qwlBP8R+Li56xQc6dwENp2PlPPx2ObZlgRLDC55rEf6NF8hKxNKtFyojJ60tZdkhP2vdh
EINqdasH8eId3wIty/8LQKfgPLYijv3WJqYPZCBDlkHBSi7blH5iwLS94dOLaTdKqit6a2yRNF0z
ekgeX/HzrrT8xSreR+KeOLLq/VVl+sfAro/ET0EH7W0tLlL/AypZRPz5jsgapqU/FqCEBnPbVx6O
xbhV9OoqGQaWmuncuykufR18vPAMDyoiNcfHzUHqWqyBL0MMiVyQAtRB6+aWMcXtl4frjWG90uhy
lHOAjjfFowKXcidCbyXnkYAOk5lI12bBmPCJu6028E4clynw2HGdP2OQat6tyudxu8FFFB2638J7
btsCGM9bXLZRKk4h9zezXRl8Jbu1/0AByUwVV+NZfqweGfEu/JK5tx3MYLZ72U4AdaW8dLF+FI2z
W5yyHSHpQZs0daoVnn1k1kEFuFrExrZisV1Fl9t142XFhqH2FPE6dLElJH18TXKWT/w2GkZCwEz+
rTMbDzrojUSB3GBT9/F5Tfl+92QH9mTeCwPQrcdBtLt9pU9Dz6qvp6w1f3l2iqctDIt3Wv1JXLzX
YaB1fSiHhViygwysL2CREw/g0zJcX+6wOA9gZYyZ1j5XxhSoQzRfAOed0/DjDU9wBt1KQvYUe/ud
QEN+tjXqCAFHwD2+jG0JrP7SXzTSuYmSm1whZ9XouFyYeefszuocFKIxqStNdIiN9AEnMC1WP7OD
bTVvN6Qe9nuav8XhDIXMIF/1D99vi9pp6+o/I1JaH1NUW24MxjE6urSUvIth1Q3swByobp8CLvMS
2Hhyo9CumL07wmvosFp9Yios3xR+v2hnPCYCV7OW2kghlpoh3i2JMiHWVhLW+L2eMS+C8kPrb2SM
QxpjrmEnIniXsMYejHzxaMfnC4HFelsudndT6c6dciIBgg+8nJPoCJhD//oq6UZlruQMc3xei8Sf
VGU+V/aYkDr5zpEJ2OSv/k1JkAYQs1ol0esHIprPJG0ev0t8iunzDynlqrgMRbzmChHmgzCVjukk
iZIrFd1fuNjDeuNfkdBoDeb2cwxngKjDKjcEdPIAFgGpgExc8lMsOy6xARkxQ1ikgHtnsp08PfF+
1moUq9eVzcbBIEmHHEWTIV0N7uj2nZ1IAaLbdZqMnMG4qFdvnFByJcTT+1+ZqAR35KtP4P7anNbZ
F/aJGgR5pEnPFb5QJoOrypxSIhvI/Ppsz5ICl5KCqpr0hqV1xjDw8RGidNMEooKvasc82ou+1lrL
Glr3CdKUZSv84TY0NtbMmIF/WlXbgovTgY8o3w48eWmZH4h/TTI2xaoHdT8q2Iluhklj146BEmHt
JXZTmKggz7AyMkWswwO4SkKnNlmqCyJxGegf6YGYUf1FFTjMzB1ZMrtKajtaf2FV1mwJd43Ohgh1
u45qv6DRlFd8Uwahdc1eyyugcrFBz3CWSVdz5EYFUgpoczpjIjnk7woGtF9v+gacrQTiZteYeWcz
2RishncM0pEBa3SIgcgmXuG0qOJqz6iUMPMkaw8+hoU6XhwapAAtFKst6URfHFh9aJEwtZIIdOcC
BK+Siz99OvuzMtlVExynhZvl6c+UPufTN/VIhKE53r7llxGsFT2krTeTDLLy40aSuG7oIFJ1LVWo
zBrAbkTNpPtpsTv0zSpMg+peiJJEiRGp9BeZ2UU79jBF9BMzWbJQuKU26Vn838iLgX0gGibVpyH5
EVgSuX0Vsj10w+ZjvwDowQWEVBcLRID+wJdbGWFDVo7LaQCYKJkse9GN+nhcsS/Jd5YHsh/AqVfL
UN6rJk5T5MU/gsML9lfpxgD8932xRmLB9sb1iRUEjDkJKMAh5J2+Nsp+iiPbpuomVDlIIoNLtrTe
vOm3XJrhVN2UgnzLVWPzlWG2GDhOzWEhlLcATS2+NXsvQyP8fdKO/WFozVx8Bg5isUhrg4qni+Ky
MK4vLOE2oh0IE3KRyrQbK1fNdkY4XZB9/zNVB8fKnV0E4+HAU1kevRqVjZ5CgKS4tsLJX9T31wld
KEDixHwDGnSMVdzT+hmj6x6QUPKYL6RuOmCZEjpOLyYechoFuxz37N06MESf3+SXfUCGd4Fi/djv
4iu6csM+zKVaVmQHxNTCvRtT5qvvM4bPNmQQjGZS5df3ankrn5jJdXSDkRsdcPeRKkfcT+/9yxQ/
JhXeWcBGmhVDH9PhYld5OwBR6pIYT52yklxNzi2k1qmdjgBkroC52D+K43JdVIHKHds6dsrc0ZKU
2ppxuYnvtlbPw0O/mYl/3WC5EULmXtKePw7Gf0YLBW1R3LwqBjezNX53xhJ20LAwPKpdJbFC00Cg
EAnFLENprWkH+dZqQgmn51MlTJ6XkOkYyBmod7C20T1w7Jm6+Ir5AbK9Spt5Ke8MG+UScEtCCCGF
YUOgC+72Rqb7vyM/seUM23eDDPm98oI5IoenZFUtHo46p7jJR2d3mG9aVeyN5WcpvZiYE7gcOfzv
bnHfyB/KGVNc+WvFzy9KQkaswohDuh4THjC47qQdE1I9yHH+9850xSV1I6W5HGeucAjCWnn8CyoB
k+OIzBDZI4k8ueoWFnmkfxez16oZstyCMmrrFUXjbIcdY2V00n4A0hMX4yaTqVyktGUTYolML6lv
UigeC/FGekEXT3qI9DifsIguFaXTXnfQj+Yx4JlhDPPIfAdWNXeza/eNGJyEHZjViSRYdHS/LNHx
neca/gWM24dM6LgCEib7+tYPMwqP46WH9DI4y4dDXp/P4BO2ezV7jnuhu+Vptiu6duN+2sez5Hp6
iYVL442mOE9v5CiF1YHfHvnXM5IOBScuICfzmZBd1DgVkM2PqVoI6veDsNtPnMqedZBOwJ5qzo81
r8eigGrHUalawfGoplS5mb4FMA76I3F2TN3+OGbbtOzwdl2HT+TAftzFEK2d6MYVgdNPzcz3AtNN
ZFyKpBDjL5mxaEvnLe+yLJgLYaixmx9PnpqMPg8UR6JFaGRDv9wNe3oURoBfB5UDRAbyqqByu8Du
D9wwKJu+C1ih0nM970Zr2oysmfpugJI9eYVO1TW2+S7eM1KpgtGUZYKS1lL7K/M/yir7Zgf/ef3F
GR2Rkc0wk/wtz87ZNd2reTewDQQIZ+g+euyoVy+Cta/rEoO1C6pre8VFMNylv+pY/leCGaOyHyy7
yX0Ve78moaM6/ILboTAibemoFdhrrQx1Jw1GGsnGbItwg3eo8VXHozxOAZu/lFtGVipgilvd712P
kuSLiF9z3zAK/JcSeFCLGTjhKutD1OSxlDBUDH6wf3n0Vue6XfaStkl4scwymHGi4rITN9i4hrd2
R/BDkBhOV8rck54msRJi+42XSeNZP1WWvUnaFnzfDMnHoucH7lftDtlwOfQmwr+XJtBdXsrtWs9Q
aViChnNtGnB+S+WNtcnZU/+1if8wM7B+e8EUubsCjVSVNWGQ2snG8aK/8amsxwGV/21tSDa0jogO
nnwSa00AgS4pMk3Yn4eljy2zAj4ALkWl92OksEGH+A13m+r4pRYiEHK2gulxUeMYJ6sLOtPYzRa8
sk6hKtqN0OoAK9/RbOKYbPlVkc6ry2vwgUVQj/bUeWXubdIZ7qATQkzJqzCj5X6ScK2A+a1vH5ss
xQfKEq7IiOpT6pIxdCpv9zai/Pyn03+jpxMZpG+NNbYoMrZ8pJvkmnwO0WT6BoiDwi5GWuj2untK
M7Cgq6APSXuSdjripg70YvzvZMkwKv/WOzShiawcQqyELUmmarsmheyiPb70VtOPh2IMItbvHDeo
jpSB8sBhBHjyn5jPZm6QWmZsZWJiZuad1YiCkDRgBC5oBxpla/a2HODhYQHo0l2+U8yZ4S7n5Wfl
tHbk9I6p8WP8w/g+LWP7W95jN6eUKrWve/C+1sGyZRo5tDYoGYAsDVgyy0/5OqP13hZjoMZ98TuU
pKHtZ+9G94+Md0Pa1wk7Lm+cH7qWInq2iGRwef4RXsMc5NGxRcpjXxMexeLHmGuPShKPaUFAKRY9
b6OY9LpMC3Aw2p6UdwySQgAUUDgQR9n9LcVCZ2VviV+Pq+uRgGHDgkZIcIibkldgYWJ6X5PdNREg
CDx/51Hq0uj3IyXC245QEWa8bPeSTe9v6R7X8oMD9XJOywjFz0vd/N4QovuMS7/6U0mOqSI96RRI
CkpQs/02B2v33VSL21F1Qz6CKryxbsWaSU9ranJP4udA3Q8hd9x7c20Hb0fXseYvBgJ97LWb1oNR
lqRb4yzucREXo1+hsnl6MMCa6wOjzspLISWFKophu7ipMTCjX1cN+gwiqs7GDj82JsNKMn+TSCWN
N+eVyiSFcrgaElX7JYs71eRqQNf7w96VZ/E0YoyfLQP4mdNebdj7NReJLm3StO3bh+35+RlLo0Zm
up6L+lVkMadrq8EEApAMd2VnMeSHgAjOKTDZ6XYnmUNg/jP83ZgcmwfJM294lQWrgL9p/J0G7cYR
j+2qwn3l/n0lUDXjIU9gbNNE/WkyjZAkuqo5ZS+SH8UBQ/PrMw3C2DmKZPuj4wKhw/yoKIZHmRi5
2BjlTCGsH15sFiiLoaXuWsYfItH9YbhpIeTAmQ/SS/+4aWx+y7fXiLdxU2c6MyJT8PUs/3wzovUN
MjOMU7ymVxLhprcPwjnknTf82LbCBEXQT5T4/MVMRc5EOUm9xk0MDw0xXIlgupCB2xpQlpd3MRem
IBNZnIksFtMxYbbi5w2YzRc7NVDwOTk8Wz6afM4RO8dK3f44HGODJtWbZTRMjwukeGEZdrR/NvrR
czQvuq2hw4GG6HSnhZT8/WmbgBo+se9ylfHPUK5eENWRAk87JUmcWdJ1gaQL7AO8mloCLNA5y0Y2
aUWpFt/MfWvH2rKa+ClnkhmrFFtCcWbksbowf2y+dh7rOmNjsFMC8o4gKtD5wh0d8bZlOFs78Tsr
Q59Lf7S7lHcvArVjy7JA6JA1qX6F5NqOgEOer9jL6gbRq5pUPkaCLPxf2vl617IHxp0uC/mM73dD
H8imSc/kpzqFfKn+3AARJGCRzHb+PDzTNeuP68Riyt5qmNuPAF7WB0LKJASewyaACX/4s0HBdI5l
TFVFO8cAIhWeEanScZgDwwzu8x9syozZxM3EgTh0efFxUoyUfIHXdblW6eSpsVOs8MPP5tH6dH/n
vxV0xQToZZfbvLkMiUvCoJiE3CZfKYQRze5/a8zUb+14fKCzqr6vP1SlA0XqFTogx7RTJ8ArutIs
4FV6YZmD9wldjFhuYgwWxNee0F+dwA1Bl2m/wa6yY0ZdrqljnrTDWt1CsmUEgHl/+FkGlXSoHJuy
py52jeP18YNeMbVX4IGOU/XmpcxQHRwFVcLKmixtrPSgi5CSgM4DjqNo9lSzcekWCu0XtziaYpy7
YksGZYDmbvO3q8kE5RxwMrCwMxsJ1RpfkyK0jWbyRVBUROaRurkxNC7zClSWSHA4havxyrNvqLPO
8p+AZvYneW3P71uCfl7ctRUFn/6LUvbyea6So9uyF4w1QXvLYIvssAJloBSsSy/2NZ+4Oqgz9Njn
Vqp8NEuYTecbA90Dt/JXh5LGmL2k+JoLgkTYxvpPenQN1IU3pc4sAd+C6pV+bLtDT8N6iD0NhQEb
m4I7tRLBEZNk5vpH3NM0zOcTopuVUnp/ySF47uFhmqrZHygqNI9/o0CNZO7ssf97N9ZtsoY2hIcf
YeaYmuwVTCto3qrnUC/rsc9gOeFJcfQEwSS7DE8qxu6mOcDbquDX5lymZNxlGaH8suaaXHpxRrub
kCka6VgG9/9wuiWY6/yN81mYczwyy4n0kdd2qKwHIyKULopoEw84lImcTOslkWTa38xDpkSwjea3
ev9FCG3NyWDZBYDDt0W9eaxfyvxLlJ4cl93erlO5cNJ6Qa0MOBdUDLZlNkRzMpLy3+OhFsCvgWVC
aW/DsQN12kSWmx+Loa0tr7J1yTNGzRG7SwQ5vncFzyuLJY+mSMS6FCKWMC4VVOP3BMIyv6TMcV4Q
KCKsAT5/tueI6MTjAJJZJP1I1YDi3C/jAqLWej8hPuAP54S6iXOWVDCoHsEhvTESocIerD+Gl0d/
gDsEiGO45GqEO70BsiERCC8epEdNFiyNVmn75RddB39kQr2NW+75G2Aq8OBwUjf1R2y5b2BBHIU9
oPMjFwvpxQNuiqSR55NOyQpmFEvpKgcaFpXPTRMcjTil0cc36BYf/vDZpFu17JMQc9QkcSR94E20
9PC0MMRIqA7oZl/AZH0YJPHpdwBjaXt1sHHz8imv2FgVfsC28co6VtJNckk2WSJWObUXnsADKmcP
swC3/cBL+ADxlVnIdWbf/A8L1hSe90ifEKCnaC3wQSuP5s/1OLKISmVK8J2W2cL9u+7e9ug6xBge
7SrIkKhMQqvVI07QenS+lyP3n2RTeyVgeFVTXTrA56fvx5nLwrPVLPqmIU6KTng1tx3Z4PV24HqS
NFXPyIXafVwcn2AbxsU6UeG9wGEtjl+hu5wtxCxCSWYJJKYydAgxabUig+gRw5slfewFdTEwB3uc
BdBiVJPjnv1mBAhKiYPq0PL1HdFd8IXHN6keIB942GBkR22AvkewUAf7l7glzjHfURcIQs8q/gHx
EZx6tMoEqYunRyxjdL/L1dQJR0aBFhhMEXkJgVQFiGGH6W/qHq0+xzyi7wGiHQjudKzWZ0LYUfSX
sYholeMQ/f+oj9qZtwBk/Cy3tFD9dP1i5OOgZ/yVexRhQL48yOh5TMtQLbub7HN63Ud/9xwV9rSY
RJvQ1/2C+9AMeDJg4KGDGuKVsD+CK5x7zACbk6tWAUVR5ihTSTjRYrNfytsbuCZktObW51uqrgwb
iqZSeCtZ4+6WgyhggngUFrZytLgt0lzTg5Kv+Y95uxbTstZX5glebKE16KTht0uDYwUPrFE3JTW/
SP8D6dGv3VGkWmdrX5PfWdt9Rw+mCIg+C8DvSXYCTFEDYs5w/Nr1mjFVHyO3VZOU/g79GeJPKsMO
fllSPbSecyI8kLejhk5TCxIVRXDMWDdKBtb8indLhtUZCH1e9XCGZxYB0IwM/IQ6zf+7GaZuqW9l
2F+FPgur6UWwBBDf+p6UYI5exMI7+9bPATJgGBV7F6BDxMAhxaR5L7oKfqNViBYmGcfq/UHfD1FX
4xUk1Pf6W9rzNBH/E3uU/HZv5NRgB8k7xBh9Hu1fA5YSqkeTNEioSDb8abNRvqd3M0bAZGRoEJPO
ExttnVgZXWB/icNQSaFpU07aArTVK/bPvc2p50Q6kcpNzboYG5iBRCprBuUoChnMKci9npZf+wnT
om9mOs0X6+ezrzoJuFDrlA8Q4hOWX1QcuvVc584iVEP20fddG94MyLJtNKbIxI+XuB1THZ+0BhtH
v2QY21/UrB8yH7WyMAsBXH8SiFJ0asAqQAZYYceK6qj2CJR7BLevPgdD3iA7fXYSxTx5+tSo2VHH
oP45G03KWAVB3JGmEAB63kA1eSzMCAUwy9H7mdxtVvnjfZ5KilBoXOCgeMD7iwxCkwH3k/EM2lhH
6LAntlhFs5IMDpFlKq8/YsEeGOr6L1Ka0jAUi+C+1VRG2FEfNRIv983bWZE/6f7Sx7saZgOBbxGK
73lKn2pGI/uToXfDGpPSWH/qNQ6q8piV2zoEAeWRVf8B/+BjPZ4yh6F0b7x16frX1X+2u2WSDrM0
2pJzf7grt2iXz/02vIY7k7or1AFaiVNwrnHnoyD4gmq/lVC4d7Bp8oZ5007QmNL3AqmxeMIKUrCg
Rt0W7uK0mO+gQyrTUQ8xAWLV+tpQfsuthS56QaEuxLw2h1Tn5+CLZ0afIJZwfgzJpaf3nnbOo6Hv
5ZdujYOGdljVFT5/AjgcyiJHDRDKZetF9LlmoXS+7EnhNcANDnBpl1gBKTxjwOkdJEoLeeuMXkJj
UGNKRUHsN5GdOXbCU22UBt9KLXjZiJq0dV0DCzVBq5ppx4onbIDJUlIcM8+NTZKznyUb12EzLsGE
meAh0NqdUsXt8zllbI5Czb3HwrAdJdtjDLRoMQHn4gWo7kknZJvl7KV9ghOa59Qgfid+8I6cukXg
FO33w55Bw/cwcXwnND8xbntldUyvHgJxH9y+8h3XHaK8EW5rlT3o4Do3Z28s5ERRiX6Jd1e7lOKB
wmDg6nEcMU8/Yk6cOQNV0e0TMNsgaYvhj8Uj5N5M2ICYyo998mS8UjdZ4G+GigWFSoZCxd+caho4
G3YpFkTK/Bb6a1xhmliFSYtbI73VCqgUjveyLf0O3DYwY6G1PY1VCsUDlrFMifm6m4JBNZJD4MQ/
7aXIe5hxwaLQOj6l1qIBRlfd469ni5YewTllCf80HvN6+RnH/xHSHB8dY23VmhVSilkkeRcDH3z6
KWw12tknCEJobmME32XFK7dtkILBYveoRt1gNeZi2QCazjY9A/t8Uzp38jWji5GcQ5ujUTyH9RSX
yy/d0/1JXOGj3qpoa+sVfCS9bCCw46J/qjpsWxiKc4tObARbAZgBiHC0j69Vggt9nPgz/Y1vqZfB
OymnPbvh3+5rNCXWsowHHJ6K/hiGUeEtvjYMTgIUIDyEAG4YxLgv0vXzuK1/VPD2IIWJefbdd68f
ja5MpaxmooqEqIoDC8TO1TyPh3A0tuukXSXiSyf8NO/qr255LPmX4cpejp2npKQI3fWrQIprUC2y
t4Dq+SCyONgFtAkNUGZJ6DVWQrfzy2JTNbhiYwChIFxA/SI7WDV/FNGuHcnN10J4QARYFh5yuVfp
Z/46XsecDDNe4i8amf+dIItK7lbXqwZIX/CRny6o83/dKB9+A2phQAxyUwcQNpcpzCjhpoV7gFDJ
IYSh9/vHlEl8hr2DpLaO72PaIuyFJ0H1UXvtePqjzytaSh/96qX+rDbtcMrHyAH5xYiKTPCTqZYb
zaffF+X6dsuV0jYKAdoXGKDFwy9dauMXdh3VavnKJ8JleietLiEhsTEGKXkZGYzlsK1MRZqPYWly
xC6pVo4etYdFoTZeje31WIEDm88c2yo3Cw6MIj4rJrX4hWPElaFuqDy0PfsKVESB0AAG+gwV9fm4
RRWEAsSLT4nJOfvAh7iPTq8hvO7O11ciAqbB79P644ECnI4fq2lZYHd+2d970S6ymFY/0XXYSIQq
22FxqGmLdgzvMsD7BRSuRXPQDbe5EDJgsYWh6R0UOcz3n+IGoUcfWI1sHD9XaK886ZuP8A+rdT/W
8DFWzf1wsvZu662OyUGuy36h/KmEPIvf4lza7tWWzy/WdH2F9lv2rf2sKriURfsNtGvce2mPCRKi
gyKlDl1hXZTef8jTt5i00ZlEQjT7mm+UDL0rnosTETLBkAYaQatvMzUhmCj06DVq0w6ok2kneMuS
Sdm+FZD0krUTQONFykmg5NFPkZ/aDM9uEL2bxUJQRsm2G0BLBC/4sTdpqlanN6KkEqj6O49zL26o
9dOM6PGr3VE9HPehKBVjvsT+fwN8coyKNbaw2F9WVZnomoZ9naYC+qJgEmwcJ843Ul3pLUjuG6gP
Z5pYZ8Muq5lZOrWrDd4xfiNBTJjNCbdzEufu9K47ZaibqDWdyi1gsixP9rJFe/5qze48d5Ghaq2a
EqZtuqmK4WXocwdZcChvHRMQDHTNZTTZ93lpADyl5Pu4fGgwwDZRZjOfNNYkn702PIFG6TW333NA
IQeUi+LZASkkFONPf7IWQY1V6OgLRSJlCLpJa2J3YYuRjslB41kiJe/PFT58HRDxvTj1uK0KCgMA
ivIEgZlwlVSckQikAwK+Q50WKckOrDB7TROr+1UU6brsi3ZUGBqMkY5cbfq1Jz1o7kH7mM7z1PpX
bH+G+44v3vkMyyxrmScB8bkUrQea+zbwydy7K8LsObwj01ii5DK7sm5O2RKwJ1/gnW9opa/47x0L
WwZSzuU1dD2HKxnYtb1YxNq6UUyA3+T+Q46yvIcJcNWpP62D+syz3pR7pvuFBZeZTmwYfIFFv2Z6
gxrROaz5zt+276pwd3MwCfNT8yK9gBvgWe2Y85MwBg6PGkCuB4Tx1n91ay+qQrtAuARRwBbPJd3K
mzd2lc3YpUWvAWszDyWHtRi+F1kbm8tpBXlemrpyroNA2dLbM9vuh5FeXbSXdCKj0n2FDe4BP95X
hERhGM4B9O+AIBsqNuDSgyR2762YgPhBOTJjcocWimi/2qKapOPe4pNN77ZRqy2HQe0HK1DKlYVi
Wh9hCRHT2VgLvYyOM2CVkz6VugptOnXFgzIqld2qcP+ZixSd5S1WUSwOodRvMOVgyswkfj0gys9L
e83BgiySeOtzzsfU3jlD1ob4X6iJLxXwaMf9+PWz/qdIl6qJ8sjhfdmDgy3L46OEvTNZh5j4DmdG
tM/B78To/gbxJSQLU6MsS47tKe8Pl12IjOiPTTd8Vubxtuiaff/KQqOH4ZLoHgqpsQpvg1Yr0NWX
BSm4AviW0hEvNoZKfsTyvTYXZXuFisp+C/y6JpNNgtOc14BxrRZQglpyEdM52Al4YRjsK3dCR5q9
J3p+BqxFFYjexoR3UlwGoapdYVPh6uROc+K5hj2St+85yr9L3Y43RE6FT4U2MClklbSGVoRMnK/h
/+JmfXP3dgvlpONwISCGxLBwcbbFBxh9A1mWtjDAWE3EG37zwnuZ00rvrxpGB2i2PmRibGgPuxY+
Z7Q2Y0q43aZw+idNeQ5MQOC7oABahZli6S8jSixrtLrqsqwgWoo/+ryqgFd6PKoPfXWoDoSd1M5i
6Uy5+KSs3NoR2G1S3tqTcVLwEFdYwsEqIxQgIGmcz5E7NJ41JN8Czv0D17wz5YeN3x58mV/6ieWm
49AVkv/Vc2N27NQ7CNixqTxrZRv3KybJTyxlA0+hGSKuvubwPcuGk0EHtoe3UeZUqmw4hDSx2Ky8
VqeA+1UL3FyKTDIQLmf5mZH5qnlK2RjgSlnoM03eTXiy3NDnS+G6SusltZKp/v0kxWi8mjJvunx7
Sfqcv3fUxMMRfXNt3oazlas08fRzSensCJ80P6gzzZiwJoCNvS37KnA9lMcz2oZqgTljp6JXYtc/
laUQW4glPdk19lM/h5kBP0zIvtz0IcYjAhbTnigDcmjj2j8JjmNtGN3JaqPyBpPmUSloIJUSsggd
a+XWxtvINowX6f8mqHnpFrHTS+OP2oYRWpbOtgqFzqb3BuWHPLyX+Ayhy72prgvDl6sk9HEo3O1R
GFw5vLBOACH1x/oUr8p0R/CcmAai8U5/2f83qflt7e7ygpQscECIrTmYkxiV7pfHD2aqW/6/KdXU
nVeGGybxDIZzqQaTPGkAkGtSMXTtqWSKO4Vx7ZUInf28LOshXr+sNMK1TRZ0N3a94GEC5UsOs0xW
bKJ5nC+eEowQdt/7m9y6ExH9QA7NNTmRvA6cmS4V9wVYbdkofHy9lzylRMDpScB4R7KwBYHC+lsI
a1nInL3LnVePYplpsJnlY9LgR2gn8/TXEKWJkEZds05Wl3m+E3XcZkq6ZfSlgeHCTxOuWIWyWS85
8nu+1leMXYPA2giiN+M+pX4tBjpmtZ6BRlOV+HawM/Ym+FOde1mGTpNzTWVFVlOBjl4J4FsoVXDA
Q/2WlW+55vgP0icN6/fRYW8RPKx8bE8HkxV4wjDFDEeYyQgiuv3x5bxoWdT2jC5jX5cF9xqJlPI2
cXB0eMgh9IUx7+c/Pqk795dPmVdx8DgM7KnUblVIIM02FGyu/NICZyQn9EQzhX2GsHzXD+zNGfrt
Ki/wBXSSXjV3BQk6e9Qn3aHdzi7etgUTiptkj8diK35Eyp5RE1s9BzlfJBQyVn0GL0N1qrqsT43P
/Pq/Q06m4NM77HfLmF9AIfgfQVw58hM9G2n2zxgEKvZUDhWq5A9ewiiTk6bK2EXw984+CrpEPmwN
3rTU9lLm9uPPEHHHhU433HPsPz237BUyThtLwBLzjVnaMmUOTPHusN5DJ405jBFf7nhxNhXaQl1x
gCtBS3y0KOpjckYOX48/cDhMWpokrWO+b2a4btXLaIDjXwh/4PK8i27nKL8BjfTzAmzzguiNPoli
5TTidlAfmW/8dtjOIoQR1ekX4dVLv21g4v1dprPK3uXraKATZeIpLCgwA1XI0wYlF+O3SnTqw0nc
TorF5Z+lQnrSMFyND0ooXgFuusFS+KUJg5ePsk6Ggdrj/vW68naqyAMPOkbwnYe32W7fB2pWACD0
cpmrj6URrQBM81gIv1MtDX2C00jE9tSeTwZgRkTco+e+TV/t0l9KiRjfoFDbhIUAu8BJzh540NUK
MNzSDE0PMGqrWI/Sxnt+EGmCREY1M6EV4d7UJNSAbpMbhPPVI9oInplEaufNxdhP5LCeJpcG3395
L0b3rO2Ed+yjZai+6ehCs2SpsOAjy3DeCzQ1cnMAUPqBBppn5BZY9BwKAw0GMzYpT0XIxMgdsBCR
S6RP5ItYxPbSZlN+AVaZO4kUlzg6QG5fiJtEX2zWZal0l426QlvRDlX7YARarjIFKe3bv4L4+suw
/eyN9y1OXUQk72dKvEWDVJlsxGmpxqWch4RtR1h8s4ErCrWuZ2nVM/gd4h4SWamku7+p9cnTvChN
EoODkhAVtaSpKUKKq76xIPZIQ3PQNz82kXisKLw+SuTVVNqnJcRL6Rid1uQtSG3V6J5tkeCeguhh
hENleKmNx97TrIKA+uncSqApysGobaPvJBL60GZSUf2MPc0nDbVPgNBDcS1jQ/CYOILHofYW/QdV
idEMmpWfzoeqJX10PFjrk6pebmR3AnqLik1wW0v3nZQU0RwK1+hByd9dcSupOs5sgfY3bneBQmEP
3+FgjVdarNmhqWb+DvC42SO/BHPpRR0nYD4Bnaj8XWntBhzL2N6Q3TJF/dVJQb8YCj2FrjGSyNZc
CNXm2/BzITWbE/c/S1pxZdrFLAR05qKb8yeYS7fx/2GhK6ZRtI2E7a+rCy6JSrwIlpTTBsYkn4mB
IlAYWtwAMeMX8XldNJnakbPGycPlwI5D2A85ZvtpYeHovbDOmrQdhoHJt3+Eg+dOP8SVAEQHv+nM
vrZiv0LbGVQZ2by110k1ZtRmQVCHjr6OOzLnbIQuCBcacu9Nx6Nk1q6Ru8YmIO0QFFE7VOg5/MkS
dQeAj64r48HndBgzFW4RwczFR4gmFR9DSwJWl6uv+zTc5jNIXZXmJDmFjOBh9IPf/DlQP9aS8hSQ
0cvxV0GstRobqTeyTOCnT6IL6CGPgEe5i+FSy9MbScg51LYSONPNGFZOQGCN8IXuLDnNcxJVqPzu
RBn67FZR3NIgBuphsaBRc2hEo2GraClvIj3IwSqQctaVF6tt6nn73O7zqbAN51GZje81fc0WP/Vy
gXLG+pqtxBk3KinXrm9o8L7pZhYGCdWr0f7Z1QMpePN8kVmiOA5Maz1dL4bKgIwgHHV7FAo8Szo7
jOul6P6PTRL08cXBXSkuUuDQcuprDXSOJOk2uDhp8A9DP7hzEtk030l9XyGuO7+jgf2NJbjRxaRc
+izP7coUM3wH8OYlJSpv5yto3xMtKFzLNN6Lk4G5VQ==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
