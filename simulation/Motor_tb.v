`timescale 1ns / 1ns // Escala de tiempo de 1 ns (1 GHz)

module testbench;

  // Definir señales de prueba
  reg [3:0] entrada;  // Entrada de 4 bits
  reg clk;            // Entrada de reloj
  wire pwm;           // Salida PWM
  wire [7:0] LED;     // Salida LED

  integer counter = 0;
  reg [3:0] change_counter = 0;

  // Generar un reloj de prueba a 1 MHz
  always begin
    #0.5 clk = ~clk; // Invierte el reloj cada 0.5 unidades de tiempo (0.5 ns)
  end

  // Instancia el módulo Motor_PWM
  Motor_PWM dut (
    .entrada(entrada),
    .clk(clk),
    .pwm(pwm),
    .LED(LED)
  );

  // Simulación
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, testbench);

    // Inicializa el reloj en bajo
    clk = 0;

    // Ejecutar pruebas para todas las combinaciones de entrada
    for (entrada = 4'b0000; entrada <= 4'b1111; entrada = entrada + 1) begin
      // Espera un ciclo de reloj antes de verificar las salidas
      #1;
      // Verificar las salidas
      if (pwm != (entrada < 6 ? 1 : 0) || LED !== {8{entrada[0]}}) begin
        $display("Error: Entrada = %b, PWM = %b, LED = %b", entrada, pwm, LED);
      end
    end

    // Cambiar la entrada cada 10 flancos de reloj
    while (change_counter < 10) begin
      #1; // Esperar un ciclo de reloj
      if (clk) begin
        change_counter = change_counter + 1;
      end
    end

    // Reiniciar el contador de cambio de entrada
    change_counter = 0;

    // Continuar con la siguiente combinación de entrada

    // Finalizar la simulación
    $finish;
  end

endmodule