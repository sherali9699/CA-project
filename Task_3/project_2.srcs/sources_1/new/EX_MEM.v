`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 02:54:12 PM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(
    input clk, reset,
    input IDEX_Branch, IDEX_MemRead, IDEX_MemWrite, IDEX_MemtoReg, IDEX_RegWrite, IDEX_Jal,
    input Zero,
    input [4:0] IDEX_RD, 
    input [63:0] adder_out2, Result, Write_Data, IDEX_adder_out1,
    output reg EXMEM_Branch, EXMEM_MemRead, EXMEM_MemWrite, EXMEM_MemtoReg, EXMEM_RegWrite, EXMEM_Jal,
    output reg EXMEM_Zero,
    output reg [4:0] EXMEM_RD,
    output reg [63:0] EXMEM_Adder2Out, EXMEM_Result, EXMEM_WriteData, EXMEM_adder_out1
);
always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        EXMEM_Branch = 0; 
        EXMEM_MemRead = 0; 
        EXMEM_MemWrite = 0; 
        EXMEM_MemtoReg = 0;
        EXMEM_RegWrite = 0; 
        EXMEM_Jal = 0;
        EXMEM_Zero = 0; 
        EXMEM_RD = 0; 
        EXMEM_Adder2Out = 0;
        EXMEM_Result = 0; 
        EXMEM_WriteData = 0;
        EXMEM_adder_out1 = 0;
    end
    else begin
        EXMEM_Branch = IDEX_Branch; 
        EXMEM_MemRead = IDEX_MemRead; 
        EXMEM_MemWrite = IDEX_MemWrite; 
        EXMEM_MemtoReg = IDEX_MemtoReg; 
        EXMEM_RegWrite = IDEX_RegWrite; 
        EXMEM_Jal = IDEX_Jal;
        EXMEM_Zero = Zero; 
        EXMEM_RD = IDEX_RD; 
        EXMEM_Adder2Out = adder_out2; 
        EXMEM_Result = Result; 
        EXMEM_WriteData = Write_Data;
        EXMEM_adder_out1 = IDEX_adder_out1;
    end 
end
endmodule
