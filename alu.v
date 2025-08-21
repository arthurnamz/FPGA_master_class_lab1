module alu #
(
    parameter DATA_WIDTH = 3,
    parameter OPCODE_WIDTH = 2
)
(
    input clk,
    input rstn,
    input [DATA_WIDTH-1:0] OPA,
    input [DATA_WIDTH-1:0] OPB,
    input [OPCODE_WIDTH-1:0] OPCODE,
    output reg [DATA_WIDTH-1:0] aluRes
);

    always @(posedge clk) begin
        if (!rstn)
            aluRes <= {DATA_WIDTH{1'b0}};
        else begin
            case (OPCODE)
                2'b00: aluRes <= OPA | OPB;
                2'b01: aluRes <= OPA & OPB;
                2'b10: aluRes <= OPA ^ OPB;
                2'b11: aluRes <= ~(OPA ^ OPB);
                default: aluRes <= {DATA_WIDTH{1'b0}};
            endcase
        end
    end
endmodule
