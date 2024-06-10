module Top(
    input clk, reset,
    
    // Instruction reading
    output reg[63:0] PC_In, PC_Out, adder_out1, adder_out2,
    
    // Register FIle
    output reg[31:0] Instruction,
    output reg[6:0] Opcode,
    output reg[4:0] rs1, rs2, rd,
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
    
        output reg [1:0] ALUOp,

    // Control Unit
   
    output reg Branch, MemRead, MemWrite, MemtoReg, ALUSrc, RegWrite, Jal,
    
    // Array output
    output reg [63:0] index0, index1, index2, index3, index4    
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
wire[63:0] index0, index1, index2, index3, index4;
wire addermuxselect;
wire EM_addermuxselect;
wire [31:0] IFID_Instruction;
wire [63:0] IFID_PC_Out, IFID_adder_out1;

wire IDEX_Branch, IDEX_MemRead, IDEX_MemWrite, IDEX_MemtoReg, IDEX_RegWrite, IDEX_ALUSrc, IDEX_Jal;
wire [1:0] IDEX_ALUOp;
wire [3:0] IDEX_Funct;
wire [4:0] IDEX_RS1, IDEX_RS2, IDEX_RD;
wire [63:0] IDEX_PC_Out, IDEX_ReadData1, IDEX_ReadData2, IDEX_ImmData, IDEX_adder_out1;

wire EXMEM_Branch, EXMEM_MemRead, EXMEM_MemWrite, EXMEM_MemtoReg, EXMEM_RegWrite, EXMEM_Jal;
wire EXMEM_Zero;
wire [4:0] EXMEM_RD;
wire [63:0] EXMEM_Adder2Out, EXMEM_Result, EXMEM_WriteData, EXMEM_adder_out1;

wire MEMWB_MemtoReg, MEMWB_RegWrite, MEMWB_Jal;
wire [4:0] MEMWB_RD;
wire [63:0] MEMWB_Result, MEMWB_Read_Data, MEMWB_adder_out1;

wire [1:0] Forward_A, Forward_B; 

wire [63:0] frwrdMux1_out, frwrdMux2_out; 
wire stall;
// Instruction Fetch
Adder Adder1(.a(PC_Out), .b(64'd4), .out(adder_out1));
Mux PCSrc_Mux(.a(adder_out1), .b(EXMEM_Adder2Out), .sel(EXMEM_Branch && EXMEM_Zero), .data_out(PC_In));
Program_Counter PC(.clk(clk), .reset(reset), .stall(stall), .PC_In(PC_In), .PC_Out(PC_Out));
Instruction_Memory InstrMem(.Inst_Address(PC_Out), .Instruction(Instruction));
wire IF_ID_Write_out;
IF_ID IFID(.clk(clk), .reset(reset),.stall(stall), .Instruction(Instruction), .PC_Out(PC_Out), .adder_out1(adder_out1), .IFID_Instruction(IFID_Instruction), .IFID_PC_Out(IFID_PC_Out), .IFID_adder_out1(IFID_adder_out1));
wire control_mux_sel;
//Hazard detection unit
hazard_detection Hazard_Detection(
            .IDEX_RD(IDEX_RD),
            .IF_ID_rs1(rs1),
            .IF_ID_rs2(rs2),
            .ID_EX_MemRead(IDEX_MemRead),   
            .stall(stall)
        );
// Instruction Decode
InsParser InstrPrsr(.instruction(IFID_Instruction), .opcode(Opcode), .rd(rd), .funct3(funct3), .rs1(rs1), .rs2(rs2), .funct7(funct7));
ImmGen Immgen(.ins(IFID_Instruction), .imm_data(imm_data));
Control_Unit CU(.Opcode(Opcode), .stall(stall), .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .Jal(Jal), .ALUOp(ALUOp));
registerFile Regfile(.WriteData(WriteData), .RS1(rs1), .RS2(rs2), .RD(MEMWB_RD), .RegWrite(MEMWB_RegWrite), .clk(clk), .reset(reset), .ReadData1(ReadData1), .ReadData2(ReadData2));
assign Funct = {IFID_Instruction[30], IFID_Instruction[14:12]};


ID_EX IDEX(.clk(clk), .reset(reset),
           .Branch(Branch), .MemRead(MemRead), .MemWrite(MemWrite), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .ALUSrc(ALUSrc), .Jal(Jal),
           .ALUOp(ALUOp),
           .Funct(Funct),
           .RS1(rs1), .RS2(rs2), .RD(rd),
           .IFID_PC_Out(IFID_PC_Out), .ReadData1(ReadData1), .ReadData2(ReadData2), .ImmData(imm_data), .IFID_adder_out1(IFID_adder_out1),
           .IDEX_Branch(IDEX_Branch), .IDEX_MemRead(IDEX_MemRead), .IDEX_MemWrite(IDEX_MemWrite), .IDEX_MemtoReg(IDEX_MemtoReg), .IDEX_RegWrite(IDEX_RegWrite), .IDEX_ALUSrc(IDEX_ALUSrc), .IDEX_Jal(IDEX_Jal),
           .IDEX_ALUOp(IDEX_ALUOp),
           .IDEX_Funct(IDEX_Funct),
           .IDEX_RS1(IDEX_RS1), .IDEX_RS2(IDEX_RS2), .IDEX_RD(IDEX_RD),
           .IDEX_PC_Out(IDEX_PC_Out), .IDEX_ReadData1(IDEX_ReadData1), .IDEX_ReadData2(IDEX_ReadData2), .IDEX_ImmData(IDEX_ImmData), .IDEX_adder_out1(IDEX_adder_out1));

// Execute
Adder Adder2(.a(IDEX_PC_Out), .b(IDEX_ImmData*2), .out(adder_out2));
Forward_Unit FrwrdUnit(
    .IDEX_rs1(IDEX_RS1),
    .IDEX_rs2(IDEX_RS2),
    .EXMEM_rd(EXMEM_RD),
    .EXMEM_RegWrite(EXMEM_RegWrite),
    .MEM_WB_rd(MEMWB_RD),
    .MEM_WB_RegWrite(MEMWB_RegWrite),
    .Forward_A(Forward_A),
    .Forward_B(Forward_B)
);
MUX_3x1 frwrdMux1(
    .a(IDEX_ReadData1),
    .b(WriteData),
    .c(EXMEM_Result),
    .sel(Forward_A),
    .data_out(frwrdMux1_out)
);
MUX_3x1 frwrdMux2(
    .a(IDEX_ReadData2),
    .b(WriteData),
    .c(EXMEM_Result),
    .sel(Forward_B),
    .data_out(frwrdMux2_out)
);
Mux AluSrc_Mux(.a(frwrdMux2_out), .b(IDEX_ImmData), .sel(IDEX_ALUSrc), .data_out(aluB));
ALU_Control Alu_CU(.ALUOp(IDEX_ALUOp), .Funct(IDEX_Funct), .Operation(Operation));

ALU_64_bit ALU(.clk(clk), .a(frwrdMux1_out), .b(aluB), .ALUOperation(Operation), .Result(Result), .ZERO(ZERO));

EX_MEM EXMEM(
    .clk(clk), .reset(reset),
    .IDEX_Branch(IDEX_Branch), .IDEX_MemRead(IDEX_MemRead), .IDEX_MemWrite(IDEX_MemWrite), .IDEX_MemtoReg(IDEX_MemtoReg), .IDEX_RegWrite(IDEX_RegWrite), .IDEX_Jal(IDEX_Jal),
    .Zero(ZERO),
    .addermuxselect(addermuxselect),
    .IDEX_RD(IDEX_RD), 
    .adder_out2(adder_out2), .Result(Result), .Write_Data(frwrdMux2_out), .IDEX_adder_out1(IDEX_adder_out1),
    .EXMEM_Branch(EXMEM_Branch), .EXMEM_MemRead(EXMEM_MemRead), .EXMEM_MemWrite(EXMEM_MemWrite), .EXMEM_MemtoReg(EXMEM_MemtoReg), .EXMEM_RegWrite(EXMEM_RegWrite), .EXMEM_Jal(EXMEM_Jal),
    .EXMEM_Zero(EXMEM_Zero),
    .EM_addermuxselect(EM_addermuxselect),
    .EXMEM_RD(EXMEM_RD),
    .EXMEM_Adder2Out(EXMEM_Adder2Out), .EXMEM_Result(EXMEM_Result), .EXMEM_WriteData(EXMEM_WriteData), .EXMEM_adder_out1(EXMEM_adder_out1)
);

// Memory Access
Data_Memory DataMem(.Mem_Addr(EXMEM_Result), .Write_Data(EXMEM_WriteData), .clk(clk), .MemWrite(EXMEM_MemWrite), .MemRead(EXMEM_MemRead), .Read_Data(Read_Data), .index0(index0), .index1(index1), .index2(index2), .index3(index3), .index4(index4));

MEM_WB MEMWB(
    .clk(clk), .reset(reset),
    .EXMEM_RegWrite(EXMEM_RegWrite), .EXMEM_MemtoReg(EXMEM_MemtoReg), .EXMEM_Jal(EXMEM_Jal),
    .EXMEM_RD(EXMEM_RD),
    .EXMEM_Result(EXMEM_Result), .Read_Data(Read_Data), .EXMEM_adder_out1(EXMEM_adder_out1),
    .MEMWB_MemtoReg(MEMWB_MemtoReg), .MEMWB_RegWrite(MEMWB_RegWrite), .MEMWB_Jal(MEMWB_Jal),
    .MEMWB_RD(MEMWB_RD), 
    .MEMWB_Result(MEMWB_Result), .MEMWB_Read_Data(MEMWB_Read_Data), .MEMWB_adder_out1(MEMWB_adder_out1)
);

//Write Back
Mux MemtoReg_Mux(.a(MEMWB_Result), .b(MEMWB_Read_Data), .sel(MEMWB_MemtoReg), .data_out(MemtoRegOut));
Mux Jal_Mux(.a(MemtoRegOut), .b(MEMWB_adder_out1), .sel(MEMWB_Jal), .data_out(WriteData));

endmodule