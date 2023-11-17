module lcd(
    // 50MHz clock input
    input clk,
    // Input from reset button (active low)
    input rst_n,
    input clk_2,
    // Outputs to the 8 onboard LEDs
    //output[7:0]led,
  
	 
	 //My Inputs and Outputs
	 input start,
	 input [3:0] selector,
	 output [7:0] data, 
	 output reg RS, RW, E
	 );

    wire rst = ~rst_n; // make reset active high
    
    reg [7:0] data_2;

/*
always @* 
    begin
        selector[0] = d;
        selector[1] = c;
        selector[2] = b;
        selector[3] = a;
        
    end
*/
//assign led[7:0] = 5'h00;



localparam [1:0] idle      = 2'b00,
					  lcd_init  = 2'b01,
					  lcd_print = 2'b10;
					  
reg [1:0] state_reg, state_next;
reg [4:0] addr_reg, addr_next;
reg [21:0] cnt_reg, cnt_next;
reg [1:0] s1, s2;

//State Registers
always@(posedge clk, posedge rst)
begin
	if(rst)
		state_reg <= idle;
	else
		state_reg <= state_next;
end


//Next State Logic
always @*
begin
	case(state_reg)
		idle:
			if(start)
				state_next = lcd_init;
			else
				state_next = idle;
				
		lcd_init:
			if(addr_reg == 5'h03 && cnt_reg == 3550000)
				state_next = lcd_print;
			else 
				state_next = lcd_init;
				
		lcd_print:
			if(addr_reg == 5'h19 && cnt_reg == 3550000)
				state_next = idle;
			else 
				state_next = lcd_print;
				
		 default:
				state_next = idle;
		endcase
end

//Output Logic	
always @*
begin
		case(state_reg)
			idle:
				begin
				s1 = 2'b10;
				s2 = 2'b10;
				RW = 0;
				RS = 0;
				E = 0;
				end
				
			lcd_init:
				begin
				s1 = 2'b00;
				s2 = 2'b01;
				RS = 0;
				RW = 0;
				E = 0;
				if (cnt_reg >= 500000)
					E = 1;
				if (cnt_reg >= 3400000)
					E = 0;
				if (cnt_reg == 3550000)
				begin
					s1 = 2'b01;
					s2 = 2'b10;
				end
				end
				
			lcd_print:
				begin
				s1 = 2'b00;
				s2 = 2'b01; //01
				RS = 1;
				RW = 0;
				E = 0;
				if (cnt_reg >= 500000)
					E = 1;
				if (cnt_reg >= 3400000)
					E = 0;
				if (cnt_reg == 3550000)
				begin
					s1 = 2'b01;
					s2 = 2'b10;
				end
				end
			default:
				begin
				s1 = 2'b10;
				s2 = 2'b10;
				RW = 0;
				RS = 0;
				E = 0;
				end
				
		endcase
end

//Path 1: ROM
reg [7:0] rom_data [29:0];
//reg [7:0] rom_data_2 [29:0];
    
    always @(posedge clk) 
        begin
            case (selector)
                4'b0000: 
               
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C0;
                   rom_data[3] = 8'h01;
                  
                   rom_data[5] = "M";
                   rom_data[6] = "O";
                   rom_data[7] = "T";
                   rom_data[8] = "O";
                   rom_data[9] = "R";
                   rom_data[10] = " ";
                   rom_data[11] = "D";
                   rom_data[12] = "E";
                   rom_data[13] = "T";
                   rom_data[14] = "E";
                   rom_data[15] = "N";
                   rom_data[16] = "I";
                   rom_data[17] = "D";
                   rom_data[18] = "O";
                   rom_data[19] = " ";
                   rom_data[20] = " ";
                   
                   
                   
                   
		   
		   
     
	           end



                4'b0001:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "1";
                   rom_data[18] = " ";
                   rom_data[19] = " ";
                   end
                4'b0010:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "2";
                   rom_data[18] = " ";
                   rom_data[19] = " ";
                   end
                4'b0011:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "3";
                   rom_data[18] = " ";
                   rom_data[19] = " ";
                   end
                4'b0100:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "4";
                   rom_data[18] = " ";
                   rom_data[19] = " ";
                   end
                4'b0101:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "5";
                   rom_data[18] = " ";
                   rom_data[19] = " ";
                   end
                4'b0110:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "6";
                   rom_data[18] = " ";
                   rom_data[19] = " ";
                   end
                4'b0111:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "7";
                   rom_data[18] = " ";
                   rom_data[19] = " ";
                   end
                4'b1000:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "8";
                   rom_data[18] = " ";
                   rom_data[19] = " ";
                   end
                4'b1001:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "9";
                   rom_data[18] = " ";
                   rom_data[19] = " ";
                   end
                4'b1010:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "1";
                   rom_data[18] = "0";
                   rom_data[19] = " ";
                   end
                4'b1011:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "1";
                   rom_data[18] = "1";
                   rom_data[19] = " ";
                   end
                4'b1100:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "1";
                   rom_data[18] = "2";
                   rom_data[19] = " ";
                   end
                4'b1101:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "1";
                   rom_data[18] = "3";
                   rom_data[19] = " ";
                   end
                4'b1110:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = " ";
                   rom_data[5] = " ";
                   rom_data[6] = "V";
                   rom_data[7] = "E";
                   rom_data[8] = "L";
                   rom_data[9] = "O";
                   rom_data[10] = "C";
                   rom_data[11] = "I";
                   rom_data[12] = "D";
                   rom_data[13] = "A";
                   rom_data[14] = "D";
                   rom_data[15] = ":";
                   rom_data[16] = " ";
                   rom_data[17] = "1";
                   rom_data[18] = "4";
                   rom_data[19] = " ";
                   end
                4'b1111:
                   begin
                   rom_data[0] = 8'h38;
                   rom_data[1] = 8'h06;
                   rom_data[2] = 8'h0C;
                   rom_data[3] = 8'h01;
                  
                   rom_data[4] = "V";
                   rom_data[5] = "E";
                   rom_data[6] = "L";
                   rom_data[7] = "O";
                   rom_data[8] = "C";
                   rom_data[9] = "I";
                   rom_data[10] = "D";
                   rom_data[11] = "A";
                   rom_data[12] = "D";
                   rom_data[13] = " ";
                   rom_data[14] = "M";
                   rom_data[15] = "A";
                   rom_data[16] = "X";
                   rom_data[17] = "I";
                   rom_data[18] = "M";
                   rom_data[19] = "A";
                   end
            endcase
        end
        
        
/*    
        
    
  always @(negedge clk)
    begin
        case (selector)
                4'b0000: 
                
                    begin
                   rom_data_2[0] = 8'h38;
                   rom_data_2[1] = 8'h06;
                   rom_data_2[2] = 8'h0C;
		           rom_data_2[3] = 8'h0C0;
                   rom_data_2[4] = 8'h01;
                  
                   rom_data_2[21] = "A";
                   rom_data_2[22] = " ";
                   rom_data_2[23] = "B";
                   rom_data_2[24] = " ";
                   rom_data_2[25] = "C";
                   rom_data_2[26] = " ";
                   rom_data_2[27] = "D";
                   rom_data_2[28] = " ";
                   rom_data_2[29] = "E";
                   rom_data_2[30] = " ";

                   
                   
	               end

                4'b0001:
                   begin
                   rom_data_2[0] = 8'h38;
                   rom_data_2[1] = 8'h06;
                   rom_data_2[2] = 8'h0C0;
                   rom_data_2[3] = 8'h01;
                  
                   rom_data_2[4] = " ";
                   rom_data_2[5] = " ";
                   rom_data_2[6] = "V";
                   rom_data_2[7] = "E";
                   rom_data_2[8] = "L";
                   rom_data_2[9] = "O";
                   rom_data_2[10] = "C";
                   rom_data_2[11] = "I";
                   rom_data_2[12] = "D";
                   rom_data_2[13] = "A";
                   rom_data_2[14] = "D";
                   rom_data_2[15] = ":";
                   rom_data_2[16] = " ";
                   rom_data_2[17] = "400";
                   rom_data_2[18] = " ";
                   rom_data_2[19] = " ";
                   end
       endcase
    end

 always@(*)
    begin
        if (clk_2 == 1)
            begin
                data_2 = rom_data[addr_reg];
            end
        else 
            begin
                data_2 = rom_data_2[addr_reg];
            end
    end
*/    
  assign data = rom_data[addr_reg];
//assign data = data_2;

//Path 1: Registers
always@(posedge clk, posedge rst)
begin
	if(rst)
		addr_reg <= 5'b0;
	else
		addr_reg <= addr_next;
end

//Path 1: Mux
always @* 
	case(s1)
		2'b00:
			addr_next = addr_reg;
			
		2'b01:
			addr_next = addr_reg + 1'b1;
			
		2'b10:
			addr_next = 5'b0;
			
		default:
			addr_next = addr_reg;
	endcase
	

//Path 2: Registers
always@(posedge clk, posedge rst)
begin
	if(rst)
		cnt_reg <= 21'h0;
	else
		cnt_reg <= cnt_next;
end

//Path 2: Mux
always @* 
	case(s2)
		2'b00:
			cnt_next = cnt_reg;
			
		2'b01:
			cnt_next = cnt_reg + 1'b1;
			
		2'b10:
			cnt_next = 21'h0;
			
		default:
			cnt_next = cnt_reg;
	endcase

endmodule