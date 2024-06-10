`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 02:45:25 PM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    input clk, reset,
    input Branch, MemRead, MemWrite, MemtoReg, RegWrite, ALUSrc, Jal,
    input [1:0] ALUOp,
    input [3:0] Funct,
    input [4:0] RS1, RS2, RD,
    input [63:0] IFID_PC_Out, ReadData1, ReadData2, ImmData, IFID_adder_out1,
    output reg IDEX_Branch, IDEX_MemRead, IDEX_MemWrite, IDEX_MemtoReg, IDEX_RegWrite, IDEX_ALUSrc, IDEX_Jal,
    output reg [1:0] IDEX_ALUOp,
    output reg [3:0] IDEX_Funct,
    output reg [4:0] IDEX_RS1, IDEX_RS2, IDEX_RD,
    output reg [63:0] IDEX_PC_Out, IDEX_ReadData1, IDEX_ReadData2, IDEX_ImmData, IDEX_adder_out1
);
always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        IDEX_Branch = 0; 
        IDEX_MemRead = 0; 
        IDEX_MemWrite = 0;
        IDEX_MemtoReg = 0; 
        IDEX_RegWrite = 0; 
        IDEX_ALUSrc = 0;
        IDEX_Jal = 0;
        IDEX_ALUOp = 0; 
        IDEX_Funct = 0; 
        IDEX_RS1 = 0; 
        IDEX_RS2 = 0; 
        IDEX_RD = 0;
        IDEX_PC_Out = 0; 
        IDEX_ReadData1 = 0; 
        IDEX_ReadData2 = 0; 
        IDEX_ImmData = 0;
        IDEX_adder_out1 = 0;
    end
    else begin
        IDEX_Branch = Branch; 
        IDEX_MemRead = MemRead; 
        IDEX_MemWrite = MemWrite;
        IDEX_MemtoReg = MemtoReg; 
        IDEX_RegWrite = RegWrite; 
        IDEX_ALUSrc = ALUSrc;
        IDEX_Jal = Jal;
        IDEX_ALUOp = ALUOp; 
        IDEX_Funct = Funct; 
        IDEX_RS1 = RS1; 
        IDEX_RS2 = RS2; 
        IDEX_RD = RD;
        IDEX_PC_Out = IFID_PC_Out; 
        IDEX_ReadData1 = ReadData1; 
        IDEX_ReadData2 = ReadData2; 
        IDEX_ImmData = ImmData;   
        IDEX_adder_out1 = IFID_adder_out1;
    end 
end
endmodule
