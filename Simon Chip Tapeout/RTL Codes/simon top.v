`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.06.2025 11:19:35
// Design Name: 
// Module Name: simon_newer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module simon_newer (
    input clk,
    input reset,
    input start,               // Start signal for the full operation
    input [63:0] key,          // Full input key
    input [31:0] plain_text,   // Plaintext input
    output [31:0] cipher_text, // Ciphertext output
    output done                // Done when encryption is complete
);

    reg  start_prev;
    reg  buffer;
    wire encrypt_start;
    wire key_gen_start;
    reg [2:0] j_cur;
    reg [2:0] j_next;
    reg [15:0] round_key_buffer;
    wire [15:0] key_from_key;
 //   wire [15:0] key_wire;
    
    
    always @*
    begin
        if(j_cur==1)
        begin
            round_key_buffer = key[15:0];
        end
        else if(j_cur==2)
        begin
            round_key_buffer = key[31:16];
        end
        else if(j_cur==3)
        begin
            round_key_buffer = key[47:32];
        end
        else if(j_cur==4)
        begin
            round_key_buffer= key[63:48];
        end
        else
        begin
            round_key_buffer= key_from_key;
        end
    end
    
    always@(posedge clk)
    begin
        if(reset)
        begin
            start_prev<=0;
            buffer<=0;
            j_cur<=0;
        end
        else 
        begin
            buffer<=start;
            start_prev<=buffer;
            j_cur<=j_next;
        end
    end
    
    always @*
    begin
        if(encrypt_start)
        begin
            j_next=j_cur+1;    
        end
        else if((j_cur!=0) && (j_cur<5))
        begin
            j_next=j_cur+1;  
        end
        else if(j_cur==5)
        begin
            j_next=0;
        end
        else
        begin
            j_next=j_cur;
        end
    end
    
    assign encrypt_start = ( (start_prev!=start) && (start==1) ) ? 1 : 0;
    assign key_gen_start = (j_cur==3 && (encrypt_start==0) ) ? 1:0;
    
    key_gen u_key_gen (
        .clk(clk),
        .reset(reset),
        .start(key_gen_start),
        .key(key),
        .round_key(key_from_key),
        .done(keygen_done)
    );

    encrypt u_encrypt (
        .clk(clk),
        .reset(reset),
        .start(encrypt_start),
        .round_key(round_key_buffer),
        .plain_text(plain_text),
        .cipher_text(cipher_text),
        .done(done)
    );
    
    endmodule