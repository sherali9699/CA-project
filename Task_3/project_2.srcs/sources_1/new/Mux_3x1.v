`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 02:49:15 PM
// Design Name: 
// Module Name: Mux_3x1
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


module MUX_3x1(
    input [63:0] a, b, c,
    input [1:0] sel,
    output reg [63:0] data_out
);

always @ (a, b, c, sel) begin

    if (sel == 2'b00) begin
        data_out = a;
    end
    else if (sel == 2'b01) begin
        data_out = b;
    end
    else if(sel == 2'b10) begin
        data_out = c;
    end
end
endmodule
