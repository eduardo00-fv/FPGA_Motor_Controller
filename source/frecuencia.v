`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2023 04:27:25 PM
// Design Name: 
// Module Name: frecuencia
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


module frecuencia(
    input clock_100Mhz,
    output reg senal
    );
    reg [21:0] count = 0;
    reg clk_out;
    
    always @(posedge clock_100Mhz) begin
        count <= count + 1;
        if (count == 19999) begin
            count <= 0;
            clk_out <= ~clk_out;
            senal = clk_out;
        end
    end
   
endmodule
       