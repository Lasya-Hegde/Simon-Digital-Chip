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

    // Instantiate the DUT (Device Under Test)
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
    reg [7:0] key_array [0:7];
    reg [3:0] plaintext_array [0:7];
    integer i;

    initial begin
        // Initialize values
        reset = 1;
        start = 0;
        key = 8'h00;
        Plaintxt = 4'h0;

        // Preload Key and Plaintext values (big-endian)
        key_array[0] = 8'h19;
        key_array[1] = 8'h18;
        key_array[2] = 8'h11;
        key_array[3] = 8'h10;
        key_array[4] = 8'h09;
        key_array[5] = 8'h08;
        key_array[6] = 8'h01;
        key_array[7] = 8'h00;

        plaintext_array[0] = 4'h6;
        plaintext_array[1] = 4'h5;
        plaintext_array[2] = 4'h6;
        plaintext_array[3] = 4'h5;
        plaintext_array[4] = 4'h6;
        plaintext_array[5] = 4'h8;
        plaintext_array[6] = 4'h7;
        plaintext_array[7] = 4'h7;

        #20;
        reset = 0;
        @(posedge clk);

        // Start signal high during input feeding
        start = 1;

        for (i = 0; i < 8; i = i + 1) begin
            @(posedge clk);
            key <= key_array[i];
            Plaintxt <= plaintext_array[i];
        end

        start = 0;

        // Wait for final done signal
        wait(done_final == 1);

        $display("\n=========== Final Output ===========");
        $display("Cipher Nibble Out: %h", cipher);
        $display("====================================\n");

        #20;
        $finish;
    end

endmodule
