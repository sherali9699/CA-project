`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 01:52:58 PM
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory
(
    input [63:0] Mem_Addr,
    input [63:0] Write_Data,
    input clk, MemWrite, MemRead,
    output reg [63:0] Read_Data,
    
    output [63:0] index0,
    output [63:0] index1,
    output [63:0] index2,
    output [63:0] index3,
    output [63:0] index4,
    output [63:0] index5,
    output [63:0] index6
);

// Initializing Data Memory
reg [7:0] DataMemory [70:0];
integer i;
initial begin
    for(i = 0; i < 64; i = i + 1) begin
        DataMemory[i] = 0;
    end
    
    // Storing values to be sorted
    DataMemory[8] = 8'd30;
    DataMemory[16] = 8'd13;
    DataMemory[24] = 8'd9;
    DataMemory[32] = 8'd3;
    DataMemory[40] = 8'd5;
    DataMemory[48]= 8'd22;
    DataMemory[56]= 8'd8;
    
end

// Storing values according array index
assign index0 = {DataMemory[15],DataMemory[14],DataMemory[13],DataMemory[12],DataMemory[11],DataMemory[10],DataMemory[9],DataMemory[8]};
assign index1 = {DataMemory[23],DataMemory[22],DataMemory[21],DataMemory[20],DataMemory[19],DataMemory[18],DataMemory[17],DataMemory[16]};
assign index2 = {DataMemory[31],DataMemory[30],DataMemory[29],DataMemory[28],DataMemory[27],DataMemory[26],DataMemory[25],DataMemory[24]};
assign index3 = {DataMemory[39],DataMemory[38],DataMemory[37],DataMemory[36],DataMemory[35],DataMemory[34],DataMemory[33],DataMemory[32]};
assign index4 = {DataMemory[47],DataMemory[46],DataMemory[45],DataMemory[44],DataMemory[43],DataMemory[42],DataMemory[41],DataMemory[40]};
assign index5 = {DataMemory[55],DataMemory[54],DataMemory[53],DataMemory[52],DataMemory[51],DataMemory[50],DataMemory[49],DataMemory[48]};
assign index6 = {DataMemory[63],DataMemory[62],DataMemory[61],DataMemory[60],DataMemory[59],DataMemory[58],DataMemory[57],DataMemory[56]};

// Whem MemRead DataMemory read
always @ (*) begin
    if (MemRead)
        Read_Data = {DataMemory[Mem_Addr+7],DataMemory[Mem_Addr+6],DataMemory[Mem_Addr+5],DataMemory[Mem_Addr+4],DataMemory[Mem_Addr+3],DataMemory[Mem_Addr+2],DataMemory[Mem_Addr+1],DataMemory[Mem_Addr]};
end

    
always @ (posedge clk) begin
    // Whem MemWrite data written to memory
    if (MemWrite) begin
        DataMemory[Mem_Addr] = Write_Data[7:0];
        DataMemory[Mem_Addr+1] = Write_Data[15:8];
        DataMemory[Mem_Addr+2] = Write_Data[23:16];
        DataMemory[Mem_Addr+3] = Write_Data[31:24];
        DataMemory[Mem_Addr+4] = Write_Data[39:32];
        DataMemory[Mem_Addr+5] = Write_Data[47:40];
        DataMemory[Mem_Addr+6] = Write_Data[55:48];
        DataMemory[Mem_Addr+7] = Write_Data[63:56];
    end
end
endmodule
