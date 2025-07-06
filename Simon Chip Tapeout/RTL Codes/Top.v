module Top #(parameter N=32, M=4, C=8)(
    input clk,
    input reset,
    input [N-1:0] key,         // 8-bit key per cycle (input_taker_3 expects N=8)
    input [M-1:0] Plaintxt,    // 4-bit plaintext per cycle
    input start,
    output [M-1:0] cipher,
    output done_final
);

    // Internal wires
    wire [31:0] data_from_input;
    wire [63:0] key_out_from_input;
    wire input_done;

    wire simon_done;
    wire [31:0] cipher_from_simon;

    wire output_done;

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

endmodule
