`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.06.2025 00:01:15
// Design Name: 
// Module Name: encrypt
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


module encrypt(
input clk,
input reset,
input start,
input [15:0] round_key,
input [31:0] plain_text,
output [31:0] cipher_text,
output done
    );
    
    reg [5:0] i_cur;
    reg [5:0] i_next;
    reg [15:0] temp;
    reg [15:0] x_cur;
    reg [15:0] y_cur;
    reg [15:0] x_next;
    reg [15:0] y_next;
    reg [15:0] not_del_this;
    reg [15:0] not_del_this2;
    reg [15:0] not_del_this3;
    reg [15:0] not_del_this4;
    reg [15:0] not_del_this5;
    reg [15:0] not_del_this6;
    
//     x = plain_text[31:16];
//     y = plain_text[15:0];
    
    assign done = (i_cur == 32 )? 1 : 0;
    assign cipher_text =  (i_cur >= 32 )? ({x_cur,y_cur}) : 0;

    always @*
    begin
        if(start)
        begin
            i_next=0;
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
            x_cur <= plain_text[31:16];
            y_cur <= plain_text[15:0];
        end
        else
        begin
            i_cur<=i_next;
            x_cur <= x_next;
            y_cur <= y_next;
        end
    end
    
    
    always @*
    begin
        if(i_cur<32)
        begin
               temp = x_cur;
               not_del_this = {x_cur[14:0],x_cur[15]};
               not_del_this2 = {x_cur[7:0],x_cur[15:8]};
               not_del_this3= {x_cur[13:0],x_cur[15:14]};
               not_del_this4 = (not_del_this & not_del_this2)^y_cur;
               not_del_this5 = not_del_this4 ^ not_del_this3 ; 
               not_del_this6 = round_key ^ not_del_this5;
               
               if(start)
               begin
                    x_next = plain_text[31:16];
                    if(i_cur==0)
                    begin
                        y_next = temp;
                    end
                    else
                    begin
                        y_next = plain_text[15:0];
                    end
                    
               end
               else
               begin
                    x_next = y_cur ^ ( ({x_cur[14:0],x_cur[15]}) & ({x_cur[7:0], x_cur[15:8]})) ^ ({ x_cur[13:0],x_cur[15:14]} ) ^ (round_key );
                    y_next = temp;
               end
               
        end
        else
        begin
                temp=0;
                not_del_this=0;
                not_del_this2=0;
                not_del_this3=0;
                not_del_this4=0;
                not_del_this5=0;
                not_del_this6=0;

                if(i_cur==33)
                begin
                    x_next = plain_text[31:16];
                    y_next = plain_text[15:0];
                end
                else
                begin
                    x_next = x_cur;
                    y_next = y_cur;
                end
                
        end
    end
    
    
    
endmodule
