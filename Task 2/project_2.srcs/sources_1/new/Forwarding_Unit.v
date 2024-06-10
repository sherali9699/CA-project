`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 02:46:59 PM
// Design Name: 
// Module Name: Forwarding_Unit
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


module Forward_Unit(
  input [4:0] IDEX_rs1,
  input [4:0] IDEX_rs2,
  input [4:0] EXMEM_rd,
  input EXMEM_RegWrite,
  input [4:0] MEM_WB_rd,
  input MEM_WB_RegWrite,
  
  output reg [1:0] Forward_A, Forward_B
);
always @(*) begin
      
      
                       //Forward A
      
      //1a. EX/MEM.RegisterRd == ID/EX.RegisterRs1
      if ((EXMEM_rd == IDEX_rs1) && (EXMEM_RegWrite == 1) && (EXMEM_rd != 0))

		Forward_A = 2'b10;   //ForwardA = 10
      
		
	  //2a. MEM/WB.RegisterRd == ID/EX.RegisterRs1
      else if ((MEM_WB_rd == IDEX_rs1) && (MEM_WB_RegWrite == 1) && (MEM_WB_rd != 0) && !(EXMEM_RegWrite == 1 && EXMEM_rd != 0 && EXMEM_rd == IDEX_rs1))
        
		Forward_A = 2'b01;  //ForwardA = 01
      
      
      else
        Forward_A = 2'b00; //ForwardA = 00
    				//Forward B

		
      //1b. EX/MEM.RegisterRd == ID/EX.RegisterRs2
      if ((EXMEM_rd == IDEX_rs2) && (EXMEM_RegWrite == 1) && (EXMEM_rd != 0))

		Forward_B = 2'b10;   //ForwardB = 10
		
      //2b. MEM/WB.RegisterRd == ID/EX.RegisterRs2
      else if ((MEM_WB_rd == IDEX_rs2) && (MEM_WB_RegWrite == 1) && (MEM_WB_rd != 0) &&!(EXMEM_RegWrite == 1 && EXMEM_rd != 0 && EXMEM_rd == IDEX_rs2))
        
		Forward_B = 2'b01;  //ForwardB = 01
      
      
      else
        Forward_B = 2'b00; //ForwardB = 00
    
    
    end
endmodule
