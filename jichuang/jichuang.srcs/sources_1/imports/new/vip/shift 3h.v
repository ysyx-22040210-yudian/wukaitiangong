`timescale 1ns / 1ps

module shift_3h(

input               clk   ,
input               din   ,
input               ce  ,

output              dout,
output              dout_s0,
output              dout_s1,
output              dout_s2
    );
    
c_shift_ram_0 line1 (
  .D(din),      // input wire [0 : 0] D
  .CLK(clk),  // input wire CLK
  .CE(ce),    // input wire CE
  .Q(dout_s0)      // output wire [0 : 0] Q
);    
c_shift_ram_0 line2 (
  .D(dout_s0),      // input wire [0 : 0] D
  .CLK(clk),  // input wire CLK
  .CE(ce),    // input wire CE
  .Q(dout_s1)      // output wire [0 : 0] Q
);
c_shift_ram_0 line3 (
  .D(dout_s1),      // input wire [0 : 0] D
  .CLK(clk),  // input wire CLK
  .CE(ce),    // input wire CE
  .Q(dout_s2)      // output wire [0 : 0] Q
);
assign  dout= dout_s2;  
    
    
endmodule
