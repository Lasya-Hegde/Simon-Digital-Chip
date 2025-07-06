`timescale 1ns/1ps

module encrypt_tb;

    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg [15:0] round_key;
    reg [31:0] plain_text;

    // Outputs
    wire [31:0] cipher_text;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    encrypt uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .round_key(round_key),
        .plain_text(plain_text),
        .cipher_text(cipher_text),
        .done(done)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Stimulus
    initial begin
        $display("=== SIMON Encrypt Testbench ===");

        // Monitor the output
        $monitor("Time=%0t | start=%b | done=%b | CipherText = %h", 
                  $time, start, done, cipher_text);

        // Initialize inputs
        reset = 1;
        start = 0;
        plain_text = 32'h65656877;
        round_key = 16'h0100;

        // Apply reset
        #10 reset = 0;

        // Apply start pulse
        #10 start = 1;
        #10 start = 0;

        // Wait for encryption to complete
        wait (done);

        #10;
        $display("Final CipherText = %h", cipher_text);
        $finish;
    end

endmodule
