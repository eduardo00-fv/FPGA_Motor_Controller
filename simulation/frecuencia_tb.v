`timescale 1ns / 1ps






module clkgen ();

    parameter mitad = 0.5;
    parameter cuarto = 0.25;
    
    reg clk_0;
    reg clk_1 = 0;
    reg clk_2;
    
    initial begin
    
        clk_0 = 0;
        forever begin 
            # (mitad); clk_0 = ~clk_0;
        end
        
    end
    
    always 
        begin
            #(cuarto); clk_1 = ~clk_1;
        end
        
    initial begin
        clk_2 = 1;
        forever begin
            clk_2 = 1; #(0.3);
            clk_2 = 0; #(0.7);
        end
    end
    
    initial begin
        #40 $stop;
        $display("Final");
    end
endmodule


/*
module clkgen ();

    parameter mitad = 5; // 5 ns para 100 M Hz
    parameter cuarto = 50000; // 50000 ns para 10K Hz
    reg clk_0;
    reg clk_1 = 0;
    reg clk_2;
    
    initial begin
        clk_0 = 0;
        forever begin 
            #(mitad); clk_0 = ~clk_0;
        end
    end
    
    always begin
        #(cuarto); clk_1 = ~clk_1;
    end
        
    initial begin
        clk_2 = 1;
        forever begin
            #(500000000); // 500000000 ns para 1 Hz
            clk_2 = ~clk_2;
        end
    end
    
    initial begin
        #200_000_000 $stop;
        $display("Final");
    end
endmodule
*/