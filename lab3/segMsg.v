
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/11/22 14:05:49
// Design Name: 
// Module Name: segMsg
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


module segMsg( 
    input clk190hz,
    input [31:0]dataBus,
    input state,
    input [3:0]who,
    input shine,
    output reg [3:0]pos1,
    output reg [3:0]pos2,
    output reg [7:0]seg1,
    output reg [7:0]seg2
    );
    reg [3:0] dataP1;
    reg [3:0] dataP2;
    reg [1:0]posC1 = 0;
    reg [1:0]posC2 = 0;
    always @(posedge clk190hz) begin
        case(posC1) 
            0: begin
                if(state == 1 && shine == 1 && who == 1)
                    pos1 <= 4'b0000;
                else 
                    pos1 <= 4'b0001;
                dataP1 <= dataBus[3:0]; 
            end
            1: begin
               if(state == 1 && shine == 1 && who == 2)
                    pos1 <= 4'b0000;
                else 
                    pos1 <= 4'b0010;
                dataP1 <= dataBus[7:4];
            end
            2: begin
                if(state == 1 && shine == 1 && who == 3)
                    pos1 <= 4'b0000;
                else 
                    pos1 <= 4'b0100;
                dataP1 <= dataBus[11:8];
            end
            3: begin
                if(state == 1 && shine == 1 && who == 4)
                    pos1 <= 8'b0000;
                else 
                    pos1 <= 8'b1000;
                dataP1 <= dataBus[15:12];
            end
            
        endcase
        posC1 <= posC1 + 1;
    end 
always @(posedge clk190hz) begin
        case (posC2) 
             0: begin
                if(state == 1 && shine == 1 && who == 5)
                    pos2 <= 4'b0000;
                else 
                    pos2 <= 4'b0001;
                dataP2 <= dataBus[19:16];
                end
             1: begin
                if(state == 1 && shine == 1 && who == 6)
                    pos2 <= 4'b0000;
                else 
                    pos2 <= 4'b0010;
                dataP2 <= dataBus[23:20];
            end
            2: begin
                if(state == 1 && shine == 1 && who == 7)
                    pos2 <= 4'b0000;
                else 
                    pos2 <= 4'b0100;
                dataP2 <= dataBus[27:24];
            end
            3: begin
                if(state == 1 && shine == 1 && who == 8)
                    pos2 <= 4'b0000;
                else 
                    pos2 <= 4'b1000;
                dataP2 <= dataBus[31:28];
            end
        endcase
            posC2 <= posC2 + 1;
        end    
   always @(dataP1, dataP2) begin
        case(dataP1)
            0: seg1 = 8'b0011_1111;
            1: seg1 = 8'b0000_0110;
            2: seg1 = 8'b0101_1011;
            3: seg1 = 8'b0100_1111;
            4: seg1 = 8'b0110_0110;
            5: seg1 = 8'b0110_1101;
            6: seg1 = 8'b0111_1101;
            7: seg1 = 8'b0000_0111;
            8: seg1 = 8'b0111_1111;
            9: seg1 = 8'b0110_1111;
            10: seg1 = 8'b0011_1110;
            default seg1 = 8'b0000_1000;
        endcase
        case(dataP2)
            0: seg2 = 8'b0011_1111;
            1: seg2 = 8'b0000_0110;
            2: seg2 = 8'b0101_1011;
            3: seg2 = 8'b0100_1111;
            4: seg2 = 8'b0110_0110;
            5: seg2 = 8'b0110_1101;
            6: seg2 = 8'b0111_1101;
            7: seg2 = 8'b0000_0111;
            8: seg2 = 8'b0111_1111;
            9: seg2 = 8'b0110_1111;
            10: seg2 = 8'b0011_1110;
            default seg2 = 8'b0000_1000;
        endcase
    end
endmodule
