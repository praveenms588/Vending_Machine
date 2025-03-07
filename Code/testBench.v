module vendingMachine_tb;
    reg clk, reset, coin_5, coin_10;
    wire dispense, change_5;

    vendingMachine vm1(.clk(clk), .reset(reset), .coin_5(coin_5), .coin_10(coin_10), .dispense(dispense), .change_5(change_5));

    always #5 clk = ~clk; 

    initial begin
        $monitor("Time=%0t | Coin_5=%b Coin_10=%b | Dispense=%b Change_5=%b", 
                 $time, coin_5, coin_10, dispense, change_5);

        clk = 0; reset = 1; coin_5 = 0; coin_10 = 0;
        #10 reset = 0;

        #10 coin_5 = 1; 
        #10 coin_5 = 0;

        #10 coin_10 = 1; 
        #10 coin_10 = 0;

        #20 $finish;
    end
endmodule
