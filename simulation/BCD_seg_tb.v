`timescale 1ns / 1ns

module control_7seg_tb;
    reg clock_100Mhz;
    reg reset;
    reg [3:0] control;
    wire [3:0] Anode_Activate;
    wire [6:0] LED_out;
    
    always #0.5 clock_100Mhz = ~clock_100Mhz; // Toggle clock every 50 ns

    control_7seg uut (
        .clock_100Mhz(clock_100Mhz),
        .reset(reset),
        .control(control),
        .Anode_Activate(Anode_Activate),
        .LED_out(LED_out)
    );

    initial begin
        // Initialize Inputs
        clock_100Mhz = 0;
        reset = 0;
        control = 0;

        // Wait 100 ns for reset to settle
        #5 reset = 1;
        #100 reset = 0;

        // Add stimulus here
        #200 control = 4'b0000;
        #100 control = 4'b0000; // Example input value
        
        #200 control = 4'b0001;
        #100 control = 4'b0000;
        
        #200 control = 4'b0010;
        #100 control = 4'b0000;
        
        #200 control = 4'b0100;
        #100 control = 4'b1000;
        
        #200 control = 4'b1010;
        #100 control = 4'b0101;
        
        #200 control = 4'b0001;
        #100 control = 4'b0010;
        
        #200 control = 4'b0110;
        #100 control = 4'b0000;
        
        #200 control = 4'b1001;
        #100 control = 4'b0000;
        
        // Add more stimulus here

        // Add a delay to observe the output
        #1000 $finish;
    end

    

endmodule
