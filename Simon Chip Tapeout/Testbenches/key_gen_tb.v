`timescale 1ns/1ps

module key_gen_tb;

    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg [63:0] key;

    // Outputs
    wire [15:0] round_key;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    key_gen uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .key(key),
        .round_key(round_key),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Stimulus
    initial begin
        // Monitor outputs
        $monitor("Time=%0t | round_key=%h | done=%b", $time, round_key, done);

        // Initial values
        reset = 1;
        start = 0;
        key   = 64'h1918111009080100;

        // Reset pulse
        #10 reset = 0;

        // Start signal
        #10 start = 1;
        #10 start = 0; // Pulse

        // Wait for done signal
        wait(done);

        // Hold for a few cycles after done
        #20;

        $display("Final Round Key: %h", round_key);
        $finish;
    end

endmodule
