`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2025 22:39:05
// Design Name: 
// Module Name: key_gen
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


module key_gen(
input clk,
input reset,
input start,
input [63:0] key,
output [15:0] round_key,
output done
    );
    
    
    localparam [63:0] z = 64'b01100111000011010100100010111110110011100001101010010001011111;
    localparam [15:0] round_constant = 16'hfffc;
    reg [5:0] i_cur;
    reg [5:0] i_next;
    reg [15:0] temp;
    reg [15:0] temp2;
 //   reg [15:0] del_this;
    reg [15:0] not_del_this3;
    reg [15:0] not_del_this4;
    reg  not_del_this2;
    reg [15:0] key0;
    reg [15:0] key1;
    reg [15:0] key2;
    reg [15:0] key3;
   // reg [15:0] key4;
    reg [15:0] key0_next;
    reg [15:0] key1_next;
    reg [15:0] key2_next;
    reg [15:0] key3_next;
    reg [15:0] key4_next;
    
    
     
    assign round_key = key3;
    assign done = (i_cur == 32 )? 1 : 0;
    
    always @*
    begin
        if(start)
        begin
            i_next=4;
        end
        else if(i_cur<33)
        begin
            i_next = i_cur+1;
        end
        else
        begin
            i_next = i_cur;
        end
    end
    
    always @(posedge clk)
    begin
        if(reset)
        begin
            i_cur <=3;
            key0 <= 0;
            key1 <= 0;
            key2 <= 0;
            key3 <= 0;
       //     key4 <= 0;
        end
        else
        begin
            i_cur<=i_next;
            key0 <= key0_next;
            key1 <= key1_next;
            key2 <= key2_next;
            key3 <= key3_next;
       //     key4 <= key4_next;
        end
    end
    
    always @*
    begin
        if((i_cur<32) && (i_cur>3))
        begin
           //     del_this=({ key3[2:0] , key3[15:3] }) ;
                temp = ({ key3[2:0] , key3[15:3] }) ^ (key1) ;
                temp2 = temp ^ ({temp[0],temp[15:1]});
                not_del_this2 = (z[i_cur-4]); 
                not_del_this3 = {temp[0],temp[15:1]};
                not_del_this4 = not_del_this2 ^ round_constant;
                key4_next = not_del_this4 ^ key0 ^ not_del_this3 ^ temp; 
        end
        else
        begin
            temp =0;
            temp2=0;
            key4_next=0;
            not_del_this2=0;
            not_del_this3=0;
            not_del_this4=0;
        end
    end
    
    
    always @*
    begin
    
        if(start)
        begin
            key3_next = key[63:48];
            key2_next=key[47:32];
            key1_next=key[31:16];
            key0_next= key[15:0];
        end
        else
        begin
            key3_next = key4_next;
            key2_next = key3;
            key1_next = key2;
            key0_next = key1;
        end
    end
    
endmodule
