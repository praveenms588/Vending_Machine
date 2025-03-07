module vending_machine_tb;
    reg clk, reset, coin_5, coin_10;
    wire dispense, change_5;

    // Instantiate the vending machine module
    vending_machine vm(.clk(clk), .reset(reset), .coin_5(coin_5), .coin_10(coin_10), .dispense(dispense), .change_5(change_5));

    // Clock generation (50% duty cycle, period = 10 time units)
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0; reset = 1; coin_5 = 0; coin_10 = 0;
        #10 reset = 0;

        #10 coin_5 = 1; // Insert Rs. 5
        #10 coin_5 = 0;

        #10 coin_10 = 1; // Insert Rs. 10
        #10 coin_10 = 0;

        #20 $finish; // End simulation
    end

    // Dump waveform data for viewing in a waveform viewer
    initial begin
        $dumpfile("vending_machine.vcd"); // Specify VCD output file
        $dumpvars(0, vending_machine_tb); // Dump all variables in this module
    end
endmodule
