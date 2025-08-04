`timescale 1ns / 1ps

module Top #(parameter N=8, M=4, C=8)(
    input clk_pad,
    input reset_pad,
    input [N-1:0] key_pad,         // 8-bit key per cycle (input_taker_3 expects N=8)
    input [M-1:0] Plaintxt_pad,    // 4-bit plaintext per cycle
    input start_pad,
    output [M-1:0] cipher_pad,
    output done_final_pad,
    output [M-1:0] out_txt_pad,
    output [5:0] test_pad,
    output txt_done_final_pad
);

    // Internal wires
    wire [31:0] data_from_input;
    wire [63:0] key_out_from_input;
    wire input_done;

    wire simon_done;
    wire [31:0] cipher_from_simon;

    wire output_done;
   
    

/////////////////////////////////cells/wires for io_pads//////////////////////
// input cell = pc3d01
// ouput cell = pc3o05
// Vdd cell = pvdi, pvda
// VSS/Gnd = pv0i, pv0a
/////////////////////////////////////////////////////////////////////////////
wire clk,reset,start,done_final,CLK,txt_done_final;
wire [N-1:0] key;     
wire [M-1:0] cipher,Plaintxt,out_txt;
wire [5:0] test;

 assign test = {key_out_from_input[53:50], reset, clk};

  pc3c01 CLK_3CPAD (.CCLK(CLK), .CP(clk));
  pc3d01 CLK_3DPAD (.PAD(clk_pad), .CIN(CLK));

  pc3d01 RST_PAD (.PAD(reset_pad), .CIN(reset));
  pc3d01 START_PAD (.PAD(start_pad), .CIN(start));
 
  pc3d01 INPUT_0_PAD (.PAD(Plaintxt_pad[0]),.CIN(Plaintxt[0]));  
  pc3d01 INPUT_1_PAD (.PAD(Plaintxt_pad[1]),.CIN(Plaintxt[1]));
  pc3d01 INPUT_2_PAD (.PAD(Plaintxt_pad[2]),.CIN(Plaintxt[2]));
  pc3d01 INPUT_3_PAD (.PAD(Plaintxt_pad[3]),.CIN(Plaintxt[3]));

  pc3d01 KEY_0_PAD (.PAD(key_pad[0]),.CIN(key[0]));
  pc3d01 KEY_1_PAD (.PAD(key_pad[1]),.CIN(key[1]));
  pc3d01 KEY_2_PAD (.PAD(key_pad[2]),.CIN(key[2]));
  pc3d01 KEY_3_PAD (.PAD(key_pad[3]),.CIN(key[3]));
  pc3d01 KEY_4_PAD (.PAD(key_pad[4]),.CIN(key[4]));
  pc3d01 KEY_5_PAD (.PAD(key_pad[5]),.CIN(key[5]));
  pc3d01 KEY_6_PAD (.PAD(key_pad[6]),.CIN(key[6]));
  pc3d01 KEY_7_PAD (.PAD(key_pad[7]),.CIN(key[7]));

  pc3o05 OUTPUT_0_PAD (.I(cipher[0]),.PAD(cipher_pad[0]));
  pc3o05 OUTPUT_1_PAD (.I(cipher[1]),.PAD(cipher_pad[1]));
  pc3o05 OUTPUT_2_PAD (.I(cipher[2]),.PAD(cipher_pad[2]));
  pc3o05 OUTPUT_3_PAD (.I(cipher[3]),.PAD(cipher_pad[3]));
  pc3o05 DONE_PAD (.I(done_final),.PAD(done_final_pad));

  pc3o05 TXT_OUTPUT_0_PAD (.I(out_txt[0]),.PAD(out_txt_pad[0]));
  pc3o05 TXT_OUTPUT_1_PAD (.I(out_txt[1]),.PAD(out_txt_pad[1]));
  pc3o05 TXT_OUTPUT_2_PAD (.I(out_txt[2]),.PAD(out_txt_pad[2]));
  pc3o05 TXT_OUTPUT_3_PAD (.I(out_txt[3]),.PAD(out_txt_pad[3]));
  pc3o05 TXT_DONE_PAD (.I(txt_done_final),.PAD(txt_done_final_pad));

  pc3o05 TEST_PAD1 (.I(test[0]),.PAD(test_pad[0]));
  pc3o05 TEST_PAD2 (.I(test[1]),.PAD(test_pad[1]));
  pc3o05 TEST_PAD3 (.I(test[2]),.PAD(test_pad[2]));
  pc3o05 TEST_PAD4 (.I(test[3]),.PAD(test_pad[3]));
  pc3o05 TEST_PAD5 (.I(test[4]),.PAD(test_pad[4]));
  pc3o05 TEST_PAD6 (.I(test[5]),.PAD(test_pad[5]));



/////////////////////////////

    // Instantiate input_taker_3
    input_taker_5 u_input_taker (
        .clk(clk),
        .reset(reset),
        .key(key),
        .Plaintxt(Plaintxt),
        .start(start),
        .data(data_from_input),
        .key_out(key_out_from_input),
        .done(input_done)
    );

    // Instantiate simon_newer
    simon_newer u_simon (
        .clk(clk),
        .reset(reset),
        .start(input_done), // Trigger when input_taker is done
        .key(key_out_from_input),
        .plain_text(data_from_input),
        .cipher_text(cipher_from_simon),
        .done(simon_done)
    );

    // Instantiate output_giver
    output_giver #(32, 4, 8) u_output_giver (
        .clk(clk),
        .reset(reset),
        .start(simon_done), // Start when encryption is complete
        .data(cipher_from_simon),
        .cipher(cipher),
        .done(done_final)
    );

    output_giver #(32, 4, 8) u_input_checker (
        .clk(clk),
        .reset(reset),
        .start(simon_done), // Start when encryption is complete
        .data(data_from_input),
        .cipher(out_txt),
        .done(txt_done_final)
    );
endmodule
