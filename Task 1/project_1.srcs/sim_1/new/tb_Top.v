`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 01:57:25 PM
// Design Name: 
// Module Name: tb_Top
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


module tb_top();

reg clk, reset;
wire[63:0] PC_In, PC_Out, adder_out1, adder_out2;
wire[31:0] Instruction;
wire[6:0] Opcode;
wire[4:0] rs1, rs2, rd;
wire[63:0] ReadData1, ReadData2, WriteData;
wire[63:0] imm_data;
wire[63:0] aluB;
wire[3:0] Operation;
wire[63:0] Result;
wire ZERO;
wire[63:0] Read_Data;
wire[63:0] MemtoRegOut;
wire[1:0] ALUOp;
wire Branch, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite, Jal;
wire[63:0] index0, index1, index2, index3, index4, index5, index6;

Top RISCV_Processor(
    clk, reset,
    PC_In, PC_Out, adder_out1, adder_out2,
    Instruction,
    Opcode,
    rs1, rs2, rd,
    ReadData1, ReadData2, WriteData,
    imm_data,
    aluB,
    Operation,
    Result,
    ZERO,
    Read_Data,
    MemtoRegOut,
    ALUOp,
    Branch, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite, Jal,
    index0, index1, index2, index3, index4, index5, index6
); 


initial begin
    clk = 0; reset = 1'b1;
    #1 reset = 0;
end

always
    #1 clk = ~clk;

endmodule