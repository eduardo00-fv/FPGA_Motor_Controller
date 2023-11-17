`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.10.2023 21:00:58
// Design Name: 
// Module Name: test_top
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

module test_top;

    reg clock_100Mhz;
    reg [3:0] bit_D, bit_C, bit_B, bit_A;
    reg reset, sw_0;
    wire [3:0] Anode_Activate;
    wire [6:0] LED_out;
    wire [7:0] LED;
    wire freq, controlar_sw, actualizar;
    wire pwm_2;
    reg start;
    wire [7:0] data;
    wire RS, RW, E;

    integer i;
    
        // Inicialización de señales
    initial begin
        clock_100Mhz = 0;
        bit_D = 4'b0000;
        bit_C = 4'b0001;
        bit_B = 4'b0010;
        bit_A = 4'b0011;
        reset = 0;
        sw_0 = 0;
        start = 0;
        

        // Iniciar simulación
        $dumpfile("dump.vcd");
        $dumpvars(0, test_top);

        // Ciclo de reloj
        forever begin
            #50 clock_100Mhz = ~clock_100Mhz; // Cambiar el flanco del reloj cada 5 unidades de tiempo
        end
    end

    top UUT (
        .clock_100Mhz(clock_100Mhz),
        .bit_D(bit_D),
        .bit_C(bit_C),
        .bit_B(bit_B),
        .bit_A(bit_A),
        .reset(reset),
        .sw_0(sw_0),
        .Anode_Activate(Anode_Activate),
        .LED_out(LED_out),
        .LED(LED),
        .freq(freq),
        .controlar_sw(controlar_sw),
        .actualizar(actualizar),
        .pwm(pwm_2),
        .start(start),
        .data(data),
        .RS(RS),
        .RW(RW),
        .E(E)
    );


    // Estimulación de las entradas
    always begin
        for (i = 0; i < 16; i = i + 1) begin
            bit_D = i[0];
            bit_C = i[1];
            bit_B = i[2];
            bit_A = i[3];
            #100; // Mantener los valores de entrada durante un tiempo
        end
        $finish; // Terminar la simulación
    end

endmodule




