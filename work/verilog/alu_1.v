/*
   This file was generated automatically by the Mojo IDE version B1.3.6.
   Do not edit this file directly. Instead edit the original Lucid source.
   This is a temporary file and any changes made to it will be destroyed.
*/

module alu_1 (
    input [15:0] a,
    input [15:0] b,
    input [5:0] alufn,
    output reg [15:0] out
  );
  
  
  
  wire [16-1:0] M_aluadd_adder;
  adder_9 aluadd (
    .a(a),
    .b(b),
    .alufn(alufn[0+5-:6]),
    .adder(M_aluadd_adder)
  );
  wire [16-1:0] M_alushift_shift;
  shifter_10 alushift (
    .a(a),
    .b(b),
    .alufn(alufn[0+5-:6]),
    .shift(M_alushift_shift)
  );
  wire [16-1:0] M_alucmp_cmp;
  comparator_11 alucmp (
    .a(a),
    .b(b),
    .alufn(alufn[0+5-:6]),
    .cmp(M_alucmp_cmp)
  );
  
  always @* begin
    out = 1'h0;
    
    case (alufn[4+1-:2])
      2'h0: begin
        out = M_aluadd_adder;
      end
      2'h2: begin
        out = M_alushift_shift;
      end
      2'h3: begin
        out = M_alucmp_cmp;
      end
      default: begin
        out = 1'h0;
      end
    endcase
  end
endmodule
