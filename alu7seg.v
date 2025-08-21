`timescale 1ns/1ps

module alu7seg #(
  parameter  DATA_WIDTH   = 3,
  parameter  RESULT_WIDTH = 7
)(
  input  wire [DATA_WIDTH-1:0]   dataIN,   
  output reg  [RESULT_WIDTH-1:0] dataOUT    // Changed to reg
);

  always @* begin
    case (dataIN[2:0])
      3'd0: dataOUT = 7'b1111110; // 0
      3'd1: dataOUT = 7'b0110000; // 1
      3'd2: dataOUT = 7'b1101101; // 2
      3'd3: dataOUT = 7'b1111001; // 3
      3'd4: dataOUT = 7'b0110011; // 4
      3'd5: dataOUT = 7'b1011011; // 5
      3'd6: dataOUT = 7'b1011111; // 6
      3'd7: dataOUT = 7'b1110000; // 7
      default: dataOUT = 7'b0000000; 
    endcase
  end

endmodule
