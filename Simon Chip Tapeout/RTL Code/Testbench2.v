`timescale 1ns / 1ps


module simon_newer_tb;

  // Inputs
  reg clk;
  reg reset;
  reg start;
  reg [63:0] key;
  reg [31:0] plain_text;

  // Outputs
  wire [31:0] cipher_text;
  wire done;

  // Instantiate the DUT
  simon_newer uut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .key(key),
    .plain_text(plain_text),
    .cipher_text(cipher_text),
    .done(done)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Testcase data
  reg [63:0] keys [0:4];
  reg [31:0] plaintexts [0:4];
  reg [31:0] expected_ciphertexts [0:4];

  integer i;

  initial begin
    // Initialize
    clk = 0;
    reset = 1;
    start = 0;

    // Wait a few cycles with reset
    #20;
    reset = 0;

    // Populate test vectors
    keys[1] = 64'h1918111009080100; plaintexts[1] = 32'h65656877; expected_ciphertexts[1] = 32'hc69be9bb;
    keys[0] = 64'hae4f4b3f2bea21bb; plaintexts[0] = 32'hb94dd41b; expected_ciphertexts[0] = 32'h8494f458;
    keys[2] = 64'h09586108cdaade2c; plaintexts[2] = 32'h9d09da8b; expected_ciphertexts[2] = 32'hdeb4c76b;
    keys[3] = 64'ha1f6a78d5886c60a; plaintexts[3] = 32'h5be7b347; expected_ciphertexts[3] = 32'hfc29a459;
    keys[4] = 64'hccc85d3d82b2d23a; plaintexts[4] = 32'he8e18044; expected_ciphertexts[4] = 32'h32294659;

    // Loop through each testcase
    for (i = 0; i < 5; i = i + 1) begin
      @(posedge clk);
      key = keys[i];
      plain_text = plaintexts[i];
      start = 1;
        
      @(posedge clk);
      start = 0;

      // Wait for done signal
      wait (done == 1);

      // Display results
      $display("TC %0d:", i);
      $display("  Key        = %h", keys[i]);
      $display("  Plaintext  = %h", plaintexts[i]);
      $display("  Ciphertext = %h", cipher_text);
      if (cipher_text !== expected_ciphertexts[i])
        $display("  ❌ MISMATCH! Expected: %h", expected_ciphertexts[i]);
      else
        $display("  ✅ Match");

      // Small delay before next input
      #10;
    end

    $display("All testcases completed.");
    $finish;
  end

endmodule
