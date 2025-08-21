`timescale 1ns/1ps

module aluSegWrapper_tb;

  // Parameters
  localparam DATA_WIDTH   = 3;
  localparam OPCODE_WIDTH = 2;
  localparam RESULT_WIDTH = 7;

  // Testbench signals
  reg clk;
  reg rstn;
  reg [DATA_WIDTH-1:0] OPA;
  reg [DATA_WIDTH-1:0] OPB;
  reg [OPCODE_WIDTH-1:0] OPCODE;
  wire [RESULT_WIDTH-1:0] segD0, segD1, segD2, segD3;

  // Instantiate DUT
  aluSegWrapper #(
    .DATA_WIDTH(DATA_WIDTH),
    .OPCODE_WIDTH(OPCODE_WIDTH),
    .RESULT_WIDTH(RESULT_WIDTH)
  ) dut (
    .clk(clk),
    .rstn(rstn),
    .OPA(OPA),
    .OPB(OPB),
    .OPCODE(OPCODE),
    .segD0(segD0),
    .segD1(segD1),
    .segD2(segD2),
    .segD3(segD3)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Helper function for expected ALU result
  function [DATA_WIDTH-1:0] expected_aluRes;
    input [DATA_WIDTH-1:0] a, b;
    input [OPCODE_WIDTH-1:0] op;
    begin
      case (op)
        2'b00: expected_aluRes = a | b;
        2'b01: expected_aluRes = a & b;
        2'b10: expected_aluRes = a ^ b;
        2'b11: expected_aluRes = ~(a ^ b);
        default: expected_aluRes = {DATA_WIDTH{1'b0}};
      endcase
    end
  endfunction

  // Helper function for expected 7-seg output
  function [RESULT_WIDTH-1:0] expected_seg;
    input [DATA_WIDTH-1:0] val;
    begin
      case (val)
        3'd0: expected_seg = 7'b1111110;
        3'd1: expected_seg = 7'b0110000;
        3'd2: expected_seg = 7'b1101101;
        3'd3: expected_seg = 7'b1111001;
        3'd4: expected_seg = 7'b0110011;
        3'd5: expected_seg = 7'b1011011;
        3'd6: expected_seg = 7'b1011111;
        3'd7: expected_seg = 7'b1110000;
        default: expected_seg = 7'b0000000;
      endcase
    end
  endfunction

  // Test procedure
  initial begin
    $display("Starting aluSegWrapper testbench...");
    rstn = 0;
    OPA = 0;
    OPB = 0;
    OPCODE = 0;
    #12;
    rstn = 1;

    // Test all combinations
    for (OPA = 0; OPA < 8; OPA = OPA + 1) begin
      for (OPB = 0; OPB < 8; OPB = OPB + 1) begin
        for (OPCODE = 0; OPCODE < 4; OPCODE = OPCODE + 1) begin
          #10;
          // Check ALU result
          if (dut.aluRes !== expected_aluRes(OPA, OPB, OPCODE)) begin
            $display("FAIL: ALU mismatch OPA=%d OPB=%d OPCODE=%b: got %b, expected %b",
              OPA, OPB, OPCODE, dut.aluRes, expected_aluRes(OPA, OPB, OPCODE));
          end
          // Check segD0
          if (segD0 !== expected_seg(OPA)) begin
            $display("FAIL: segD0 mismatch OPA=%d: got %b, expected %b", OPA, segD0, expected_seg(OPA));
          end
          // Check segD1
          if (segD1 !== expected_seg(OPB)) begin
            $display("FAIL: segD1 mismatch OPB=%d: got %b, expected %b", OPB, segD1, expected_seg(OPB));
          end
          // Check segD2 (OPCODE zero-extended)
          if (segD2 !== expected_seg({{(DATA_WIDTH-OPCODE_WIDTH){1'b0}}, OPCODE})) begin
            $display("FAIL: segD2 mismatch OPCODE=%b: got %b, expected %b", OPCODE, segD2, expected_seg({{(DATA_WIDTH-OPCODE_WIDTH){1'b0}}, OPCODE}));
          end
          // Check segD3 (ALU result)
          if (segD3 !== expected_seg(expected_aluRes(OPA, OPB, OPCODE))) begin
            $display("FAIL: segD3 mismatch ALU result=%d: got %b, expected %b", expected_aluRes(OPA, OPB, OPCODE), segD3, expected_seg(expected_aluRes(OPA, OPB, OPCODE)));
          end
        end
      end
    end

    $display("aluSegWrapper testbench completed.");
    $finish;
  end

endmodule