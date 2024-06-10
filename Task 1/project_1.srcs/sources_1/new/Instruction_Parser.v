`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 12:58:11 PM
// Design Name: 
// Module Name: Instruction_Parser
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


module InsParser
(
    input [31:0] instruction,   // 32-bit instruction input
    output [6:0] opcode,        // 7-bit opcode output
    output [4:0] rd,            // 5-bit destination register output
    output [2:0] funct3,        // 3-bit function code 3 output
    output [4:0] rs1,           // 5-bit source register 1 output
    output [4:0] rs2,           // 5-bit source register 2 output
    output [6:0] funct7         // 7-bit function code 7 output
);

    // Extracting specific bit ranges from the instruction
    assign opcode = instruction[6:0];     // Extract bits 6 to 0 for opcode
    assign rd = instruction[11:7];        // Extract bits 11 to 7 for destination register
    assign funct3 = instruction[14:12];   // Extract bits 14 to 12 for function code 3
    assign rs1 = instruction[19:15];      // Extract bits 19 to 15 for source register 1
    assign rs2 = instruction[24:20];      // Extract bits 24 to 20 for source register 2
    assign funct7 = instruction[31:25];   // Extract bits 31 to 25 for function code 7

endmodule
