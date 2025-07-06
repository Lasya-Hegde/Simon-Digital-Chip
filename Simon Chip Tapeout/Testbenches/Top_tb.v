`timescale 1ns / 1ps

module Top_tb;

    // Parameters
    parameter N = 8;
    parameter M = 4;
    parameter C = 8;

    // Inputs
    reg clk;
    reg reset;
    reg [N-1:0] key;
    reg [M-1:0] Plaintxt;
    reg start;

    // Outputs
    wire [M-1:0] cipher;
    wire done_final;

    // Instantiate the DUT
    Top #(N, M, C) uut (
        .clk(clk),
        .reset(reset),
        .key(key),
        .Plaintxt(Plaintxt),
        .start(start),
        .cipher(cipher),
        .done_final(done_final)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initial state
        clk = 0;
        reset = 1;
        start = 0;
        key = 8'h00;
        Plaintxt = 4'h0;

        // Hold reset
        #20;
        reset = 0;

        // Wait for one clock edge
        #20;

        // Start input
        start = 1;

        // First input
        #10;
        key = 8'h19;
        Plaintxt = 4'h6;

        #10;
        key = 8'h18;
        Plaintxt = 4'h5;

        #10;
        key = 8'h11;
        Plaintxt = 4'h6;

        #10;
        key = 8'h10;
        Plaintxt = 4'h5;

        #10;
        key = 8'h09;
        Plaintxt = 4'h6;

        #10;
        key = 8'h08;
        Plaintxt = 4'h8;

        #10;
        key = 8'h01;
        Plaintxt = 4'h7;

        #10;
        key = 8'h00;
        Plaintxt = 4'h7;

        // Stop input
        #10;
        start = 0;

        // Wait for done
        wait(done_final == 1);

        $display("\n=========== Final Output ===========");
        $display("Cipher Nibble Out: %h", cipher);
        $display("====================================\n");

        #20;
        $finish;
    end

endmodule
