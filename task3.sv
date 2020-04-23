`default_nettype none

module mult_dp
  (input logic start,
   input logic [7:0] A, B,
   input logic clk, reset_L,
   output logic done,
   output logic [15:0] out);
   
   logic flipA, flipB, flipEnd, doneAdd, addA;
   logic clrOut, ld, enShift, lsb1;
   
   logic [7:0] absA8, absB8, notA, notB, shiftedB; // 8 bits version
   logic [7:0] intMax; // for reference
   logic [15:0] shiftedA, absA16; // left 8 bits of both should be 0
   logic [15:0] ans, notAns, sum;
   logic dead1, dead2, dead3, dead4, dead5, dead6, dead7;
   
   always_comb begin
    notA = ~A + 1;
    notB = ~B + 1;
    notAns = ~ans + 1;
    intMax = 8'b01111111;
    absA16 = {8'b00, absA8};
    lsb1 = shiftedB[0]; 
    // clock = clk;
   end
   
   Mux2to1 #(8) negateA (.I0(A), .I1(notA), .S(flipA), .Y(absA8));
   Mux2to1 #(8) negateB (.I0(B), .I1(notB), .S(flipB), .Y(absB8));
   Mux2to1 #(16) negateAns (.I0(ans), .I1(notAns), 
                            .S(flipEnd), .Y(out));
   
   Register #(16) outReg (.D(sum), .en(addA), .clear(clrOut), .Q(ans), .clock(clk));
   
   MagComp #(8) signA (.A(A), .B(intMax), .AgtB(flipA), 
                       .AltB(dead1), .AeqB(dead2));
   MagComp #(8) signB (.A(B), .B(intMax), .AgtB(flipB), 
                       .AltB(dead3), .AeqB(dead4));
   MagComp #(8) doneB (.A(shiftedB), .B(8'b0), .AeqB(doneAdd), 
                       .AltB(dead5), .AgtB(dead6));
   
   ShiftRegister #(16) shiftA (.D(absA16), .en(enShift), .load(ld), 
                              .clk, .left(1'b1), .Q(shiftedA));
   ShiftRegister #(8) shiftB (.D(absB8), .en(enShift), .load(ld),
                              .clk, .left(1'b0), .Q(shiftedB));
                              
   Adder #(16) iterAdd (.A(shiftedA), .B(ans), .Cin(1'b0), 
                        .S(sum), .Cout(dead7));
                              
   fsm dut (.*);
   
endmodule: mult_dp

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
  
