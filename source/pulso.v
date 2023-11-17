`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/07/2023 01:02:13 PM
// Design Name: 
// Module Name: pulso
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

module pulso(
    input clock_100Mhz,
    output pulso_lento
    );
    reg [25:0] count = 0;
    reg clk_out;
    
    always @(posedge clock_100Mhz)
    
        begin
            count <= count +1;
            if (count == 50_000_000)
                begin
                    count <= 0;
                    clk_out = ~clk_out;
                end
        end
    assign pulso_lento = clk_out;
endmodule
