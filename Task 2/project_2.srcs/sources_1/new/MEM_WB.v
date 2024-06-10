`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 02:57:11 PM
// Design Name: 
// Module Name: MEM_WB
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

module MEM_WB(
    input clk, reset,
    input EXMEM_RegWrite, EXMEM_MemtoReg, EXMEM_Jal,
    input [4:0] EXMEM_RD,
    input [63:0] EXMEM_Result, Read_Data, EXMEM_adder_out1,
    output reg MEMWB_MemtoReg, MEMWB_RegWrite, MEMWB_Jal,
    output reg [4:0] MEMWB_RD, 
    output reg [63:0] MEMWB_Result, MEMWB_Read_Data, MEMWB_adder_out1
);
always @(posedge clk or posedge reset) begin
    if (reset == 1'b1) begin
        MEMWB_MemtoReg = 0; 
        MEMWB_RegWrite = 0; 
        MEMWB_Jal = 0;
        MEMWB_RD = 0;
        MEMWB_Result = 0; 
        MEMWB_Read_Data = 0;
        MEMWB_adder_out1 = 0;
    end
    else begin
        MEMWB_MemtoReg = EXMEM_MemtoReg; 
        MEMWB_RegWrite = EXMEM_RegWrite; 
        MEMWB_Jal = EXMEM_Jal;
        MEMWB_RD = EXMEM_RD;
        MEMWB_Result = EXMEM_Result; 
        MEMWB_Read_Data = Read_Data;
        MEMWB_adder_out1 = EXMEM_adder_out1;
    end 
end
endmodule
