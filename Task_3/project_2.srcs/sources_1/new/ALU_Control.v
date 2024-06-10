`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 02:50:34 PM
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control
(
    input [1:0] ALUOp,
    input [3:0] Funct,
    output reg [3:0] Operation
);

always @ (ALUOp or Funct) begin
    case(ALUOp)
        // For I-type and S-type Instructions
        2'b00: begin 
            case(Funct[2:0])
                3'b001: Operation = 4'b0011;    // SLLI Instruction
                default: Operation = 4'b0010;   // When load or store, add
            endcase
        end
        
        // For Branching
        2'b01: begin
            case(Funct[2:0])
                3'b000: Operation = 4'b0101;    // For Beq
                3'b100: Operation = 4'b1000;    // For Blt
                3'b101: Operation = 4'b1010;    // For Bge
            endcase
        end
        
        // For R-type
        2'b10: begin
            case(Funct)
                4'b0000: Operation = 4'b0010;   // ADD
                4'b1000: Operation = 4'b0110;   // SUB
                4'b0111: Operation = 4'b0000;   // AND
                4'b0110: Operation = 4'b0001;   // OR
            endcase
        end
        
        // For J-type
        2'b11: Operation = 4'b1110;
        
    endcase
end
endmodule
