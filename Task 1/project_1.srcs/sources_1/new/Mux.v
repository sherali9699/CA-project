`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2024 12:53:31 PM
// Design Name: 
// Module Name: Mux
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


module Mux
(
    input [63:0] a,
    input [63:0] b,
    input sel,
    output reg [63:0]data_out
);
//assign data_out = sel? b:a ;
always @ (a, b, sel) begin
    // if sel = 0 choose a
    if (!sel)
        data_out = a;
        
    // if sel = 1 choose b
    else
        data_out = b;
end
endmodule
