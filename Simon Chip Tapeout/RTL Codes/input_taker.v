`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.07.2025 14:08:57
// Design Name: 
// Module Name: input_taker_5
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

module input_taker_5 (
input clk,
input reset,
input [7:0] key,
input [3:0] Plaintxt,
input start,
output reg [31:0] data,
output reg [63:0] key_out,
output reg  done
    );
    
    reg [3:0] state;
    reg [3:0] next_state;
    reg [7:0] key_buf;
    reg [3:0] Plaintxt_buf;
    reg [31:0] data_buf;
    reg [63:0] key_out_buf;
    reg done_buf;
    reg start_buf;
    
    always@(posedge clk)
    begin
        if(reset)
        begin
            key_buf<=key;
            Plaintxt_buf<=Plaintxt;
            state<=0;
            key_out<=0;
            done<=0;
            data<=0;
            start_buf<=0;
        end
        else
        begin
            key_buf<=key;
            Plaintxt_buf<=Plaintxt;
            state<=next_state;
            key_out<=key_out_buf;
            done <=done_buf;
            data<=data_buf;
            start_buf<=start;
        end
    end
    
    always @*
    begin
        case(state)
        4'b0000:
        begin
            if(start_buf)
            begin
                next_state=4'b0001;
            end
            else
            begin
                next_state=state;
            end
            
            data_buf=data;
            key_out_buf=key_out;
            done_buf=0;
        end
        4'b0001:
        begin
            next_state=4'b0010;
            data_buf = {Plaintxt_buf, data[27:0] };
            key_out_buf = {key_buf , key_out[55:0] };
            done_buf=0;
        end
        4'b0010:
        begin
            next_state=4'b0011;
            data_buf = {data[31:28] ,Plaintxt_buf, data[23:0] };
            key_out_buf = {key_out[63:56] , key_buf , key_out[47:0] };
            done_buf=0;
        end
        4'b0011:
        begin
            next_state=4'b0100;
            data_buf = {data[31:24] ,Plaintxt_buf, data[19:0] };
            key_out_buf = {key_out[63:48] , key_buf , key_out[39:0] };
            done_buf=0;
        end
        4'b0100:
        begin
            next_state=4'b0101;
            data_buf = {data[31:20] ,Plaintxt_buf, data[15:0] };
            key_out_buf = {key_out[63:40] , key_buf , key_out[31:0] };
            done_buf=0;
        end
        4'b0101:
        begin
            next_state=4'b0110;
            data_buf = {data[31:16] ,Plaintxt_buf, data[11:0] };
            key_out_buf = {key_out[63:32] , key_buf , key_out[23:0] };
            done_buf=0;
        end
        4'b0110:
        begin
            next_state=4'b0111;
            data_buf = {data[31:12] ,Plaintxt_buf, data[7:0] };
            key_out_buf = {key_out[63:24] , key_buf , key_out[15:0] };
            done_buf=0;
        end
        4'b0111:
        begin
            next_state=4'b1000;
            data_buf = {data[31:8] ,Plaintxt_buf, data[3:0] };
            key_out_buf = {key_out[63:16] , key_buf, key_out[7:0]  };
            done_buf=0;
        end
        4'b1000:
        begin
            next_state=4'b1001;
            data_buf = {data[31:4] ,Plaintxt_buf };
            key_out_buf = {key_out[63:8] , key_buf  };
            done_buf=0;
        end
        4'b1001:
        begin
            next_state=4'b0000;
            data_buf = data;
            key_out_buf = key_out;
            done_buf=1;
        end
        default:
        begin
            next_state=4'b0000;
            data_buf = data;
            key_out_buf = key_out;
            done_buf=0;
        end
        endcase
    end
    
endmodule
