`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 01:09:02 PM
// Design Name: 
// Module Name: Top
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


module Top(
    input clk, reset,
    
    // Instruction reading
    output reg[63:0] PC_In, PC_Out, adder_out1, adder_out2,
    
    // Instruction Parser
    output reg[31:0] Instruction,
    output reg[6:0] Opcode,
    output reg[4:0] rs1, rs2, rd,
    
    //Register File
    output reg[63:0] ReadData1, ReadData2, WriteData, 
    
    // Immediate Generator
    output reg[63:0] imm_data,
    
    // ALU
    output reg[63:0] aluB,
    output reg[3:0] Operation,
    output reg[63:0] Result,
    output ZERO,
    
    // Data Memory
    output reg[63:0] Read_Data,     
    output reg[63:0] MemtoRegOut,
    
    // Control Unit
    output reg [1:0] ALUOp,
    output reg Branch, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite, Jal,
    
    // Array output
    output reg [63:0] index0, index1, index2, index3, index4 ,index5,index6   
);

// Creating internal wires  
wire[63:0] PC_In, PC_Out, adder_out1, adder_out2;
wire[31:0] Instruction;
wire[6:0] Opcode, funct7;
wire[4:0] rs1, rs2, rd;
wire[63:0] ReadData1, ReadData2, WriteData;
wire[2:0] funct3;
wire[63:0] imm_data;
wire[3:0] Funct, Operation;
wire[63:0] aluB;
wire[3:0] Operation;
wire[63:0] Result;
wire ZERO;
wire[63:0] Read_Data;
wire[63:0] MemtoRegOut;
wire[1:0] ALUOp;
wire Branch, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite, Jal;
wire[63:0] index0, index1, index2, index3, index4,index5,index6;

// Instruction Fetch
Adder Adder1(.a(PC_Out), .b(64'd4), .out(adder_out1));
Mux PCSrc_Mux(.a(adder_out1), .b(adder_out2), .sel(Branch && ZERO), .data_out(PC_In));
Program_Counter PC(.clk(clk), .reset(reset), .PC_In(PC_In), .PC_Out(PC_Out));
Instruction_Memory InstrMem(.Inst_Address(PC_Out), .Instruction(Instruction));

// Instruction Decode
InsParser InstrPrsr(.instruction(Instruction), .opcode(Opcode), .rd(rd), .funct3(funct3), .rs1(rs1), .rs2(rs2), .funct7(funct7));
ImmGen Immgen(.ins(Instruction), .imm_data(imm_data));
Control_Unit CU(.Opcode(Opcode), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jal(Jal), .ALUOp(ALUOp));
registerFile Regfile(.WriteData(WriteData), .RS1(rs1), .RS2(rs2), .RD(rd), .RegWrite(RegWrite), .clk(clk), .reset(reset), .ReadData1(ReadData1), .ReadData2(ReadData2));
assign Funct = {Instruction[30], Instruction[14:12]};

// Execute
Adder Adder2(.a(PC_Out), .b(imm_data*2), .out(adder_out2));
Mux AluSrc_Mux(.a(ReadData2), .b(imm_data), .sel(ALUSrc), .data_out(aluB));
ALU_Control Alu_CU(.ALUOp(ALUOp), .Funct(Funct), .Operation(Operation));
ALU_64_bit ALU(.a(ReadData1), .b(aluB), .ALUOperation(Operation), .Result(Result), .ZERO(ZERO));

// Memory Access
Data_Memory DataMem(.Mem_Addr(Result), .Write_Data(ReadData2), .clk(clk), .MemWrite(MemWrite), .MemRead(MemRead), .Read_Data(Read_Data), .index0(index0), .index1(index1), .index2(index2), .index3(index3), .index4(index4),.index5(index5),.index6(index6));

//Write Back
Mux MemtoReg_Mux(.a(Result), .b(Read_Data), .sel(MemtoReg), .data_out(MemtoRegOut));
Mux Jal_Mux(.a(MemtoRegOut), .b(adder_out1), .sel(Jal), .data_out(WriteData));

endmodule
