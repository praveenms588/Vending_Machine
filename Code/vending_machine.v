module vending_machine(
    input clk, reset,
    input coin_5, coin_10, 
    output reg dispense,   
    output reg change_5    
);

    // State encoding
    parameter IDLE = 2'b00; 
    parameter FIVE = 2'b01; 
    parameter TEN = 2'b10;
    parameter DISPENSE = 2'b11;
              
    reg [1:0] state, next_state;

    // State transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic and output logic
    always @(*) begin
        dispense = 0;
        change_5 = 0;
        case (state)
            IDLE: begin
                if (coin_5)
                    next_state = FIVE;
                else if (coin_10)
                    next_state = TEN;
                else
                    next_state = IDLE;
            end

            FIVE: begin
                if (coin_5)
                    next_state = DISPENSE;
                else if (coin_10)
                    next_state = DISPENSE;
                else
                    next_state = FIVE;
            end

            TEN: begin
                if (coin_5)
                    next_state = DISPENSE;
                else
                    next_state = TEN;
            end

            DISPENSE: begin
                dispense = 1;
                if (state == TEN && coin_10)
                    change_5 = 1; // Return Rs. 5 change
                next_state = IDLE;
            end

            default: next_state = IDLE;
        endcase
    end
endmodule
