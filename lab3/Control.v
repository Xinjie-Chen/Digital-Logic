`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/10 03:47:17
// Design Name: 
// Module Name: Control
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


module Control(
    input clk,
    input [4:0]key_out,
    output state_out,
    output shine_out,
    output r_mov_out,
    output l_mov_out,
    output [3:0]who_out,
    output add_out,
    output sub_out
    );
    reg state, shine, r_mov, l_mov, add, sub;
    reg [3:0]who;
    reg [25:0]cnt_s;
    initial begin
        state <= 0;
        who <= 0;
        cnt_s <= 0;
        shine <= 0;
        add <= 0;
        sub <= 0;
    end
    
    always@(negedge clk) begin
        if (key_out == 16)
            state <= ~state;
        else state <= state;
    end
    
    always@(negedge clk) begin
        if (state == 1) begin
            if (key_out == 2) begin
                if (who != 8)
                    who <= who + 1;
                else
                    who <= who;
            end else if (key_out == 1) begin
                if (who != 1) begin
                    who <= who - 1;
                end else begin
                    who <= who;
                end
            end
        end else 
            who <= 1;
        end
        
        always@(posedge clk) begin
            if (state == 1) 
            begin
                if (cnt_s == 26'd50000000) 
                begin
                    cnt_s <= 0;
                    shine <= ~shine;
                end 
                else 
                    cnt_s <= cnt_s + 1;
             end 
             else 
                cnt_s <= 0;
        end
        
        always@(negedge clk) begin
        if (state == 1) begin
            if (key_out == 1) begin
                if (who == 1) begin
                    r_mov <= 1;
                end else 
                    r_mov <= 0;
            end else if (key_out == 2)  begin
                if (who == 8) begin
                    l_mov <= 1;
                end else 
                    l_mov <= 0;
            end else begin
                l_mov <= 0;
                r_mov <= 0;
            end
        end
        end
       
       always@(negedge clk) begin
        if (state == 1) begin
            if (key_out == 4)
                sub <= 1;
            else 
                sub <= 0;
            if (key_out == 8)
                add <= 1;
            else 
                add <= 0;
        end else begin
            add <= 0;
            sub <= 0;
        end    
        end
        
       assign add_out = add;
       assign sub_out = sub;
       assign who_out = who;
       assign state_out = state;
       assign l_mov_out = l_mov;
       assign r_mov_out = r_mov;
       assign shine_out = shine;
endmodule
