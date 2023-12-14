`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/12/09 20:55:00
// Design Name: 
// Module Name: DataReg
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


module DataReg(
    input clk,
    input clr,
    input [4:0]key_out,
    input r_mov,
    input l_mov,
    input [3:0]who,
    input add1,
    input sub1,
    output [39:0]data_out
    );
    reg [3:0] data[9:0];

    always@(posedge clk or negedge clr) begin
        if (!clr) begin 
            data[9] <= 4'hb;
            data[8] <= 4'hb;
            data[7] <= 4'hb;
            data[6] <= 4'hb;
            data[5] <= 4'hb;
            data[4] <= 4'hb;
            data[3] <= 4'hb;
            data[2] <= 4'hb;
            data[1] <= 4'hb;
            data[0] <= 4'hb;
        end else if (l_mov) begin
            data[0] <= data[1];
            data[1] <= data[2];
            data[2] <= data[3];
            data[3] <= data[4];
            data[4] <= data[5];
            data[5] <= data[6];
            data[6] <= data[7];
            data[7] <= data[8];
            data[8] <= data[9];
            data[9] <= data[0];
        end else if (r_mov) begin
            data[1] <= data[0];
            data[2] <= data[1];
            data[3] <= data[2];
            data[4] <= data[3];
            data[5] <= data[4];
            data[6] <= data[5];
            data[7] <= data[6];
            data[8] <= data[7];
            data[9] <= data[8];
            data[0] <= data[9];
       end else if (add1) begin
            if (data[who + 1] >= 10)
                data[who + 1] <= 0;
            else 
                data[who + 1] <= data[who + 1] + 1;
       end else if (sub1) begin
            if (data[who + 1] == 0)
                data[who + 1] <= 10;
            else 
                data[who + 1] <= data[who + 1] - 1;
       end
     end
    
    
    assign data_out = {data[9],data[8],data[7],data[6],data[5],data[4],data[3],data[2],data[1],data[0]};
    
endmodule
