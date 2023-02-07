`timescale 1s / 1s
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.02.2023 10:17:16
// Design Name: 
// Module Name: TrafficLight
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


module TrafficLight(
    input clock,
    input reset,
    input button_push,
    output reg greenLight, yellowLight, redLight, stop, walk
    );
    
    
    
    logic [1:0] current_state, next_state, previous_state;
    logic [1:0] red = 2'b00,
                green_yellow = 2'b01,
                red_yellow = 2'b11,
                green  = 2'b10;
    integer timer = 0;   
              
    //Current state memory. A flip flop to hold the current signal
    always_ff @ (posedge  clock or negedge reset)
        begin: CURRENT_STATE_MEMORY
            if (~reset)
                current_state <= green;
            else
                current_state <= next_state;
        end: CURRENT_STATE_MEMORY
        
     always_ff @ (posedge clock)
         begin
            if (timer != 0)
                timer <= timer - 1;
         end
    
    //Setting the next state logic block. Setting the next state based on the currnt state
    always_comb
        begin: NEXT_STATE_LOGIC
            case (current_state)
                green : if (button_push == 1'b1)
                            begin
                                next_state = green_yellow;
                            end
                         else
                             begin
                                 next_state = green;
                             end
                green_yellow : if (timer == 0) 
                            next_state = red;
                         else next_state = green_yellow;
                red     :   if (timer == 0) 
                                next_state = red_yellow;
                            else next_state = red;
                red_yellow     :   if (timer == 0) 
                                       next_state = green;
                                   else next_state = red_yellow;
                default : next_state = green;
           endcase
        end: NEXT_STATE_LOGIC
        
        //Output Logic. 
        always_comb
            case(current_state)
                green : 
                    begin
                        greenLight = 1'b1;
                        yellowLight = 1'b0;
                        redLight = 1'b0;
                        stop = 1'b1;
                        walk = 1'b0;
                     end
                 green_yellow : 
                    begin
                        greenLight = 1'b0;
                        yellowLight = 1'b1;
                        redLight = 1'b0;
                        stop = 1'b1;
                        walk = 1'b0;
                        timer = 10;
                     end
                  red_yellow : 
                    begin
                        greenLight = 1'b0;
                        yellowLight = 1'b1;
                        redLight = 1'b0;
                        stop = 1'b1;
                        walk = 1'b0;
                        timer = 10;
                     end
                  red : 
                    begin
                        greenLight = 1'b0;
                        yellowLight = 1'b0;
                        redLight = 1'b1;
                        stop = 1'b0;
                        walk = 1'b1;
                        timer = 30;
                     end
                  default : 
                    begin
                        greenLight = 1'b1;
                        yellowLight = 1'b0;
                        redLight = 1'b0;
                        stop = 1'b1;
                        walk = 1'b0;
                     end
            endcase
endmodule
