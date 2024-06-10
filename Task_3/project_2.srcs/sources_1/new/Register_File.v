`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2024 02:43:39 PM
// Design Name: 
// Module Name: Register_File
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


module registerFile
( 
    input [63:0] WriteData,
    input [4:0] RS1,
    input [4:0] RS2,
    input [4:0] RD,
    input RegWrite, clk, reset,
    output reg [63:0] ReadData1,
    output reg [63:0] ReadData2
);

//initializing Registers 
reg[63:0] Registers [31:0]; 

integer i;
initial begin
    for(i = 0; i < 32; i = i + 1) begin
        Registers[i] = 0;
    end
    
end

//operation of writing data into a Register should always be done when
//positive edge of clock and RegWrite signal is asserted (or set, i.e. High)
always @ (posedge clk) begin
    case(RegWrite)
        1'b1 : 
            begin
                //All registers can be written to except x0 which stores 0
                if (RD == 5'd0) begin
                    Registers[RD] = 64'd0;
                end
                else begin
                    Registers[RD] = WriteData;
                end
            end 
    endcase
end

//Whenever input changes and reset = 0 ReadData is assigned value of registers
always @ (*) begin
    if(reset) begin
        ReadData1 = 64'b0;
        ReadData2 = 64'b0;
    end
    else begin
        ReadData1 = Registers[RS1];
        ReadData2 = Registers[RS2];
    end
end
endmodule
