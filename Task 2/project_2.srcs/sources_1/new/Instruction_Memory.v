`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 02:33:40 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory
(
    input [63:0] Inst_Address,
    output reg [31:0] Instruction
);
// Creating 95 1-byte registers to store Instructions
reg [7:0] inst_mem [95:0];
initial
begin
    
    // Test cases with Data Hazards that require forwarding
    {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h00500193; //addi x3, x0, 5
    {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h00300233; //add x4, x0, x3
    {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h000202b3; //add x5, x4, x0
    
    
    // Initializing Instruction Memory with Instructions to implement Insertion Sort
//    {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'h00800513;//0
//    {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'h00500693;//1
//    {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'h00100713;//2
//    {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'h04d75a63;//3
//    {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'hfff70793;//4
//    {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'h00371813;//5 
//    {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'h01050833;//6
//    {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'h00083883;//7
//    {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'h00379913;//8
//    {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'h01250933;//9
//    {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'h00093983;//10 
//    {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'h0138de63;//11
//    {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'h0007cc63;//12
//    {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'h00893a03;//13
//    {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'h01393423;//14
//    {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'h01493023;//15
//    {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'hfff78793;//16
//    {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'hf77ff0ef;//17
//    {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'h00178a93;//18
//    {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'h003a9a93;//19
//    {inst_mem[83], inst_mem[82], inst_mem[81], inst_mem[80]} = 32'h00aa8ab3;//20
//    {inst_mem[87], inst_mem[86], inst_mem[85], inst_mem[84]} = 32'h011ab023;//21
//    {inst_mem[91], inst_mem[90], inst_mem[89], inst_mem[88]} = 32'h00170713;//22
//    {inst_mem[95], inst_mem[94], inst_mem[93], inst_mem[92]} = 32'hEC7FF0ef;//23

end

always @(Inst_Address)
begin
    //Reading 4 registersw as a RISC-V Instruction is 32-bits
    Instruction={inst_mem[Inst_Address+3],inst_mem[Inst_Address+2],inst_mem[Inst_Address+1],inst_mem[Inst_Address]};
end


endmodule
