`timescale 1ns / 1ps
module Motor_PWM (
  input [3:0] entrada,  // Entrada de 4 bits para las velocidades (0000 - 1111)
  input clk,    
  input activate,        // Entrada de reloj
  output reg pwm,            // Salida PWM para controlar el motor (ahora es un registro)
  output reg [7:0] LED       // Salida de 8 bits para controlar LEDs (nueva salida)
);

reg [5:0] counter = 0;   // Contador para la señal PWM
integer ciclo_de_trabajo;   // Ciclo de trabajo calculado

always @(posedge clk ) begin
  if (activate == 0)
    begin
        ciclo_de_trabajo = 0;
    end// Calcula el ciclo de trabajo en función de la entrada
  else
    begin
        case (entrada)
    4'b0000: ciclo_de_trabajo = 0; // 0% de ciclo de trabajo
    4'b0001: ciclo_de_trabajo = 4; // 6.66% de ciclo de trabajo
    4'b0010: ciclo_de_trabajo = 8; // 13.33% de ciclo de trabajo
    4'b0011: ciclo_de_trabajo = 12; // 20.00% de ciclo de trabajo
    4'b0100: ciclo_de_trabajo = 17; // 26.66% de ciclo de trabajo
    4'b0101: ciclo_de_trabajo = 21; // 33.33% de ciclo de trabajo
    4'b0110: ciclo_de_trabajo = 25; // 40.00% de ciclo de trabajo
    4'b0111: ciclo_de_trabajo = 29; // 46.66% de ciclo de trabajo
    4'b1000: ciclo_de_trabajo = 34; // 53.33% de ciclo de trabajo
    4'b1001: ciclo_de_trabajo = 38; // 60.00% de ciclo de trabajo
    4'b1010: ciclo_de_trabajo = 42; // 66.66% de ciclo de trabajo
    4'b1011: ciclo_de_trabajo = 46; // 73.33% de ciclo de trabajo
    4'b1100: ciclo_de_trabajo = 50; // 80.00% de ciclo de trabajo
    4'b1101: ciclo_de_trabajo = 55; // 86.66% de ciclo de trabajo
    4'b1110: ciclo_de_trabajo = 59; // 93.33% de ciclo de trabajo
    4'b1111: ciclo_de_trabajo = 63; // 100.00% de ciclo de trabajo
    default: ciclo_de_trabajo = 0; // Valor predeterminado: 0% de ciclo de trabajo
  endcase
   
  // Controla los LEDs en función de la entrada (nueva funcionalidad)
  case (entrada)
    4'b0000: LED <= 8'b00000000; // Valor predeterminado: Apaga todos los LEDs
    4'b0001: LED <= 8'b00000001; // Enciende el primer LED
    4'b0010: LED <= 8'b00000001; // Enciende el primer LED
    4'b0011: LED <= 8'b00000011; // Enciende los dos primeros LEDs
    4'b0100: LED <= 8'b00000011; // Enciende los dos primeros LEDs
    4'b0101: LED <= 8'b00000111; // Enciende los tres primeros LEDs
    4'b0110: LED <= 8'b00000111; // Enciende los tres primeros LEDs
    4'b0111: LED <= 8'b00001111; // Enciende los cuatro primeros LEDs
    4'b1000: LED <= 8'b00001111; // Enciende los cuatro primeros LEDs
    4'b1001: LED <= 8'b00011111; // Enciende los cinco primeros LEDs
    4'b1010: LED <= 8'b00011111; // Enciende los cinco primeros LEDs
    4'b1011: LED <= 8'b00011111; // Enciende los seis primeros LEDs
    4'b1100: LED <= 8'b00111111; // Enciende los seis primeros LEDs
    4'b1101: LED <= 8'b01111111; // Enciende los siete primeros LEDs
    4'b1110: LED <= 8'b01111111; // Enciende los siete primeros LEDs
    4'b1111: LED <= 8'b11111111; // Enciende todos los LEDs
    default: LED <= 8'b00000000; // Valor predeterminado: Apaga todos los LEDs
  endcase
    end
  
end

always @(posedge clk) begin
    counter <= counter + 1; // Incrementa el contador en cada flanco de subida del reloj
    
    // Genera la señal PWM con un ciclo de trabajo variable
    if (counter < ciclo_de_trabajo) // Cambia el valor 32 para ajustar el ciclo de trabajo
      pwm <= 1'b1;
    else
      pwm <= 1'b0;
  end
  
  
endmodule