`timescale 10ns / 1ps
module InputJudge(
    input clk,
    input clr,
    input [4:0] Key_in,
    output reg [4:0] Key_out
);
    parameter xd = 21'd1000000;
    
    reg [20:0] xd_cnt = 0;
    reg [26:0] cnt_s = 0;
    always @(posedge clk) begin
        if (Key_in == 5'b00000) begin
            xd_cnt <= 0;
        end else if (xd_cnt == xd) begin
            xd_cnt <= xd;
        end else begin
            xd_cnt <= xd_cnt + 1;
        end
    end

    always @(posedge clk) begin
        if (!clr)
            Key_out <= 5'b00000;
        else if (xd_cnt == (xd - 21'b1) ) begin
            case(Key_in) 
                5'b00001:   Key_out <= 1;
                5'b00010:   Key_out <= 2;
                5'b00100:   Key_out <= 4;
                5'b01000:   Key_out <= 8;
                5'b10000:   Key_out <= 16;
            endcase  
        end else begin
            Key_out <= 0;
        end
    end

endmodule