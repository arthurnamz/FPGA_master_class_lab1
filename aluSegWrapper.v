`timescale 1ns/1ps

module aluSegWrapper #(
  parameter DATA_WIDTH   = 3,
  parameter OPCODE_WIDTH = 2,
  parameter RESULT_WIDTH = 7
)(
  input  wire                  clk,
  input  wire                  rstn,
  input  wire [DATA_WIDTH-1:0] OPA,
  input  wire [DATA_WIDTH-1:0] OPB,
  input  wire [OPCODE_WIDTH-1:0] OPCODE,
  output wire [RESULT_WIDTH-1:0] segD0, // Display 0: OPA
  output wire [RESULT_WIDTH-1:0] segD1, // Display 1: OPB
  output wire [RESULT_WIDTH-1:0] segD2, // Display 2: OPCODE
  output wire [RESULT_WIDTH-1:0] segD3  // Display 3: ALU result
);

  wire [DATA_WIDTH-1:0] aluRes;

  // Instantiate ALU
  alu #(
    .DATA_WIDTH(DATA_WIDTH),
    .OPCODE_WIDTH(OPCODE_WIDTH)
  ) alu_inst (
    .clk(clk),
    .rstn(rstn),
    .OPA(OPA),
    .OPB(OPB),
    .OPCODE(OPCODE),
    .aluRes(aluRes)
  );

  // Display OPA
  alu7seg #(
    .DATA_WIDTH(DATA_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) segD0_inst (
    .dataIN(OPA),
    .dataOUT(segD0)
  );

  // Display OPB
  alu7seg #(
    .DATA_WIDTH(DATA_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) segD1_inst (
    .dataIN(OPB),
    .dataOUT(segD1)
  );

  // Display OPCODE (zero-extend to match DATA_WIDTH)
  alu7seg #(
    .DATA_WIDTH(DATA_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) segD2_inst (
    .dataIN({{(DATA_WIDTH-OPCODE_WIDTH){1'b0}}, OPCODE}),
    .dataOUT(segD2)
  );

  // Display ALU result
  alu7seg #(
    .DATA_WIDTH(DATA_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) segD3_inst (
    .dataIN(aluRes),
    .dataOUT(segD3)
  );

endmodule