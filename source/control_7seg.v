`timescale 1ns / 1ps


module control_7seg(
    input clock_100Mhz, // 100 Mhz clock source on Basys 3 FPGA
    input reset, // reset
    input [3:0] control,
    output reg [3:0] Anode_Activate, // anode signals of the 7-segment LED display
    output reg [6:0] LED_out// cathode patterns of the 7-segment LED display
    //output reg [7:0] LED
    );
    reg [26:0] one_second_counter; // counter for generating 1 second clock enable
    wire one_second_enable;// one second enable for counting numbers
    reg [15:0] displayed_number; // counting number to be displayed
    reg [3:0] LED_BCD;
    reg [19:0] refresh_counter; // 20-bit for creating 10.5ms refresh period or 380Hz refresh rate
             // the first 2 MSB bits for creating 4 LED-activating signals with 2.6ms digit period
    wire [1:0] LED_activating_counter; 
    
    //wire [2:0] LED_8;
    //reg [3:0] sw;
                 // count     0    ->  1  ->  2  ->  3
              // activates    LED1    LED2   LED3   LED4
             // and repeat
    /*
    always @(posedge clock_100Mhz or posedge reset)
    begin
        if(reset==1)
            one_second_counter <= 0;
        else begin
            if(one_second_counter>=99999999) 
                 one_second_counter <= 0;
            else
                one_second_counter <= one_second_counter + 1;
        end
    end 
    assign one_second_enable = (one_second_counter==99999999)?1:0;
    always @(posedge clock_100Mhz or posedge reset)
    begin
        if(reset==1)
            displayed_number <= 0;
        else if(one_second_enable==1)
            displayed_number <= displayed_number + 1;
    end
    
    always @*
        begin
            sw[0] = bit_D;
            sw[1] = bit_C;
            sw[2] = bit_B;
            sw[3] = bit_A;
        end
    */
    always @ ( control )
        begin
            case (control)
                4'b0000 : displayed_number <= 16'b0000000000000000;
                4'b0001 : displayed_number <= 16'b0000000000000001;
                4'b0010 : displayed_number <= 16'b0000000000000010;
                4'b0011 : displayed_number <= 16'b0000000000000011;
                4'b0100 : displayed_number <= 16'b0000000000000100;
                4'b0101 : displayed_number <= 16'b0000000000000101;
                4'b0110 : displayed_number <= 16'b0000000000000110;
                4'b0111 : displayed_number <= 16'b0000000000000111;
                4'b1000 : displayed_number <= 16'b0000000000001000;
                4'b1001 : displayed_number <= 16'b0000000000001001;
                4'b1010 : displayed_number <= 16'b0000000000001010;
                4'b1011 : displayed_number <= 16'b0000000000001011;
                4'b1100 : displayed_number <= 16'b0000000000001100;
                4'b1101 : displayed_number <= 16'b0000000000001101;
                4'b1110 : displayed_number <= 16'b0000000000001110;
                4'b1111 : displayed_number <= 16'b0000000000001111;
                default : displayed_number <= 16'b0000000000000001;
            endcase
        end
        // Escala de 8 D,C,B
    /*
    assign LED_8[2:0] = sw[2:0];
    
    always @( LED_8)
        begin
            case (LED_8)
                3'b000   :   LED <= 8'b00000000;
                3'b001   :   LED <= 8'b10000000;
                3'b010   :   LED <= 8'b11000000;
                3'b011   :   LED <= 8'b11100000;
                3'b100   :   LED <= 8'b11110000;
                3'b101   :   LED <= 8'b11111000;
                3'b110   :   LED <= 8'b11111100;
                3'b111   :   LED <= 8'b11111111;
                default  :   LED <= 8'b11111111;
            endcase
        end
        
    */
    always @(posedge clock_100Mhz or posedge reset)
    begin 
        if(reset==1)
            refresh_counter <= 0;
        else
            refresh_counter <= refresh_counter + 1;
    end 
    assign LED_activating_counter = refresh_counter[19:18];
    // anode activating signals for 4 LEDs, digit period of 2.6ms
    // decoder to generate anode signals 
    always @(*)
    begin
        case(LED_activating_counter)
        2'b00: begin
            Anode_Activate = 4'b0111; 
            // activate LED1 and Deactivate LED2, LED3, LED4
            LED_BCD = displayed_number/1000;
            // unidades
              end
        2'b01: begin
            Anode_Activate = 4'b1011; 
            // activate LED2 and Deactivate LED1, LED3, LED4
            LED_BCD = (displayed_number % 1000)/100;
            // decenas
              end
        2'b10: begin
            Anode_Activate = 4'b1101; 
            // activate LED3 and Deactivate LED2, LED1, LED4
            LED_BCD = ((displayed_number % 1000)%100)/10;
            // centenas
                end
        2'b11: begin
            Anode_Activate = 4'b1110; 
            // activate LED4 and Deactivate LED2, LED3, LED1
            LED_BCD = ((displayed_number % 1000)%100)%10;
            // um   
               end
        endcase
    end
    // Cathode patterns of the 7-segment LED display 
    always @(*)
    begin
        case(LED_BCD)
        4'b0000: LED_out = 7'b0000001; // "0"     
        4'b0001: LED_out = 7'b1001111; // "1" 
        4'b0010: LED_out = 7'b0010010; // "2" 
        4'b0011: LED_out = 7'b0000110; // "3" 
        4'b0100: LED_out = 7'b1001100; // "4" 
        4'b0101: LED_out = 7'b0100100; // "5" 
        4'b0110: LED_out = 7'b0100000; // "6" 
        4'b0111: LED_out = 7'b0001111; // "7" 
        4'b1000: LED_out = 7'b0000000; // "8"     
        4'b1001: LED_out = 7'b0000100; // "9" 
        default: LED_out = 7'b0000001; // "0"
        endcase
    end
 endmodule