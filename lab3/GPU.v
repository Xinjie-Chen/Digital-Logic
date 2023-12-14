`timescale 10ns / 1ps

module GPU(
    input clk,
    input clk3hz,
    input clr,
    input [39:0]NUMBER,
    input state,
    output [31:0]dataBus
);
    reg [39:0]msgArray;
    initial msgArray = 40'hbbbbbbbbbb;
    assign dataBus = msgArray[39:8];
    always @(posedge clk3hz or negedge clr) begin
        if (state == 0) begin
            if(!clr)
                msgArray <= NUMBER;
            else begin
                msgArray[3:0] <= msgArray[39:36];
                msgArray[39:4] <= msgArray[35:0];
            end
        end else if (state == 1) begin
            msgArray <= NUMBER;
        end
    end 
    
    
    
endmodule
