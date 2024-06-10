`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2024 06:53:23 PM
// Design Name: 
// Module Name: hazard_detection_unit
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


module hazard_detection(
    input [4:0] IDEX_RD, IF_ID_rs1, IF_ID_rs2,
    input ID_EX_MemRead, 
    output reg stall 
);

always@(*)
begin    
    if (ID_EX_MemRead && (IDEX_RD == IF_ID_rs1 || IDEX_RD == IF_ID_rs2))
        begin
            stall=1;
        end
    else
        begin
            stall=0;
        end

end
endmodule
