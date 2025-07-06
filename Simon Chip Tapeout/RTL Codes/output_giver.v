`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2025 19:40:56
// Design Name: 
// Module Name: output_giver
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


module output_giver #(parameter N=32, M=4, C=8)(
input clk,
input reset,
input start,
input [N-1:0] data,
output reg [M-1:0] cipher,
output  done
    );
    
    reg [5:0] i_cur;
    reg [5:0] i_next;
    reg [M-1:0] out;
    wire [31:0] buffer;
    reg [31:0] buffer_reg;
    
    always @(posedge clk)
    begin
        if(reset)
        begin
            i_cur<=0;
            cipher<=0;
            buffer_reg<=0;
        end
        else
        begin
            i_cur<=i_next;
            cipher<=out;
            buffer_reg<=buffer;
        end
    end
    
    assign buffer = start ? data : buffer_reg;
    
    always @*
    begin
        if(   ((start==1) && (i_cur==0))  || ((i_cur<36) && (i_cur!=0)))
        begin
            i_next=i_cur+4;
            
            if( (i_cur!=0))
            begin
                out = buffer_reg[(i_cur-1)-:4];
            end
            else
            begin
                out=0;
            end
        end
        else
        begin
            i_next=0;
            out = 0;
        end
    end
    
    assign done = (i_cur==36)? 1:0;
endmodule
