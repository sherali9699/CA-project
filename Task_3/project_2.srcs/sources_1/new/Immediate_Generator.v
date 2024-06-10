`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 02:39:15 PM
// Design Name: 
// Module Name: Immediate_Generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ImmGen
(
    input [31:0] ins,
    output reg [63:0] imm_data
);

reg [19:0] jal_imm;

reg [11:0] ld_imm;
reg [11:0] sd_imm;
reg [11:0] br_imm;
wire [1:0] sel;
assign sel = ins [6:5];
    localparam [1:0]
    ld_ins = 2'b00,
    sd_ins = 2'b01,
    br_ins = 2'b11;



always @ (ins) begin
    // Immediate field for JAL Instruction
    if (ins[6:0] == 7'b1101111) begin
        jal_imm = ins[31:12];
        imm_data = {{52{ins[31]}}, jal_imm[19], jal_imm[9:0], jal_imm[10], jal_imm[18:11]};
    end
    
    else begin
        case (sel)
            // Immediate field for Load Instruction
            ld_ins:
                begin
                    ld_imm = ins [31:20];
                    imm_data = {{52{ins[31]}}, ld_imm};
                end
            
            // Immediate field for Store Instrucion
            sd_ins:
                begin
                    sd_imm = {ins [31:25], ins[11:7]};
                    imm_data = {{52{ins[31]}}, sd_imm};
                end
            
            // Immediate field for Branch Instruction  
            br_ins:
                begin
                    br_imm = {ins [31], ins [7], ins [30:25], ins [11:8]};
                    imm_data = {{52{ins[31]}}, br_imm};
                end
                
            default: imm_data = 64'h0000000000000000;
        endcase
    end
end
endmodule
