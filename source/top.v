`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2023 04:37:50 PM
// Design Name: 
// Module Name: top
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


module top(
    input clock_100Mhz,
    // ADC
    input bit_D,
    input bit_C,
    input bit_B,
    input bit_A,
    input reset,
    input sw_0,
    input activate,
    //BCD
    output [3:0] Anode_Activate,
    output [6:0] LED_out,
    output [7:0] LED,
    //output led,
    //output  led_A, led_B, led_C, led_D,
    //ADC
    output freq,
    output controlar_sw,
    output actualizar,
    //Motor
    output pwm,
    // LCD
    input start,
    output [7:0] data, 
    output RS, RW, E
    );
    
    reg switch [3:0];
    wire [3:0] Anode_Act_2;
    wire [6:0] LED_out_2;
    wire [7:0] LED_2;
    reg [3:0] selector;
    reg [3:0] entrada_top;
    wire str_lcd = 1;
    wire rst_lcd = 1;
              
    always @*
        begin
            entrada_top[0] = bit_D;
            entrada_top[1] = bit_C;
            entrada_top[2] = bit_B;
            entrada_top[3] = bit_A;
        end
    
    // Lógica para asignar bits a selector
    always @* 
    begin
        selector[0] = bit_D;
        selector[1] = bit_C;
        selector[2] = bit_B;
        selector[3] = bit_A;
    end

        
    frecuencia U0 (clock_100Mhz, freq);
    
    pulso U1 (clock_100Mhz, actualizar);

    control_7seg U2 (clock_100Mhz, reset, bit_D, bit_C, bit_B, bit_A,
    Anode_Act_2, LED_out_2);
    
    Motor_PWM U3 (entrada_top, clock_100Mhz, activate, pwm_2, 
    LED_2);
    
    lcd U4 (clock_100Mhz, rst_lcd, actualizar, str_lcd, selector, data, RS, RW, E);
    
    assign Anode_Act_2 = Anode_Activate;
    assign LED_out_2 = LED_out;
    assign LED_2 = LED;
    assign controlar_sw = sw_0;
    assign pwm_2 = pwm;
    
    
endmodule
