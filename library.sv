`default_nettype none

module MagComp
  # (parameter WIDTH = 1)
  (input logic [WIDTH-1:0] A, B,
   output logic AltB, AeqB, AgtB);
  
  always_comb begin
    if (A < B)
      begin
        AeqB = 1'b0;
        AltB = 1'b1;
        AgtB = 1'b0;
      end
    else if (A == B)
      begin
        AeqB = 1'b1;
        AltB = 1'b0;
        AgtB = 1'b0;
      end
    else
      begin
        AgtB = 1'b1;
        AltB = 1'b0;
        AeqB = 1'b0;
      end
  end
 
endmodule: MagComp


module Multiplexer
  # (parameter WIDTH = 2)
  // parameter S_WIDTH = $clog2(WIDTH);
  (input logic [WIDTH-1:0] I,
   input logic [$clog2(WIDTH)-1:0] S,
   output logic Y);
  
  always_comb begin
    if (S < WIDTH) 
      Y = I[S];
  end
  
endmodule: Multiplexer

module Mux2to1
  // input width
  # (parameter WIDTH = 1)
  (input logic [WIDTH-1:0] I0, I1,
   input logic S,
   output logic [WIDTH-1:0] Y);
   
  assign Y = S ? I1 : I0;

endmodule: Mux2to1

module Decoder 
    # (parameter WIDTH = 1)
    // parameter I_WIDTH = $clog2(WIDTH);
    (input logic [$clog2(WIDTH)-1:0] I,
     input logic en,
     output logic [WIDTH-1:0] D);
     
    always_comb begin
      D = 0;
      if (en)
        begin
          if (I < WIDTH)
            D[I] = 1'b1;
        end 
      else
        D = I;
    end
    
endmodule: Decoder
  
module Adder
  # (parameter WIDTH = 1)
  (input logic [WIDTH-1:0] A, B,
   input logic Cin,
   output logic [WIDTH-1:0] S,
   output logic Cout);
   
  assign {Cout, S} = A + B + Cin;
  
endmodule: Adder
 
module Register
  # (parameter WIDTH = 1)
  (input logic [WIDTH-1:0] D,
   input logic en, clear,
   input logic clock,
   output logic [WIDTH-1:0] Q);
   
   always_ff @(posedge clock)
     if (en)
       Q <= clear ? 0 : D;
      
endmodule: Register
  
module Counter
  #(parameter WIDTH = 1)
   (input logic en, clear, load, up,
    input logic clk,
    input logic [WIDTH-1:0] D,
    output logic [WIDTH-1:0] Q);
    
  always_ff @(posedge clk)
    if (clear && en)
      Q <= 0;
    else if (load && en)
      Q <= D;
    else if (up && en)
      Q <= Q + 1;
endmodule: Counter

module ShiftRegister
  #(parameter WIDTH = 1)
   (input logic en, left, load,
    input logic clk,
    input logic [WIDTH-1:0] D, 
    output logic [WIDTH-1:0] Q);
    
  always_ff @(posedge clk)
    if (load)
      Q <= D;
    else if (en && left)
      Q <= (Q << 1);
    else if (en && ~left)
      Q <= (Q >> 1);
      
endmodule: ShiftRegister

module BarrelShiftRegister
  #(parameter WIDTH = 1)
   (input logic load, en, 
    input logic [1:0] by,
    input logic [WIDTH-1:0] D,
    input logic clk,
    output logic [WIDTH-1:0] Q);
    
  always_ff @(posedge clk)
    if (load)
      Q <= D;
    else if (en)
      Q <= (Q << by);
 endmodule: BarrelShiftRegister
 
 module Memory
  #(parameter DW = 16,
              W = 256,
              AW = $clog2(W))
   (input logic re, we, clk,
    input logic [AW-1:0] Address,
    inout tri   [DW-1:0] Data);
    
  logic [DW-1:0] M[W];
  logic [DW-1:0] out;
   
  assign Data = (re) ? out : 'z;
   
  always_ff @(posedge clk)
    if (we)
      M[Address] <= Data;
      
  always_comb begin
    out = M[Address];
  end
    
endmodule: Memory
      
      
    
  


   

      
        
      
  
  
  
   
   
  
