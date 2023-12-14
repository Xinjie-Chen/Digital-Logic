module top(
    input clk100mhz,
    input clr,
    input key1,
    input key2,
    input key3,
    input key4,
    input key5,
    output [3:0]pos1,
    output [3:0]pos2,
    output [7:0]seg1,
    output [7:0]seg2
);
    wire clk3hz, clk190hz;
    wire [39:0]data;
    wire [31:0]dataBus;
    wire [4:0]Key_in = {key5, key4, key3, key2, key1};
    wire [4:0]Key_out;
    wire r_mov, l_mov, state, shine, add, sub;
    wire [3:0] who;
    clkDiv U1(
        clk100mhz,
        clk190hz,
        clk3hz
        );
    
    GPU U2(
        clk100mhz,
        clk3hz,
        clr, 
        data,
        state,
        dataBus
        );
        
    segMsg U3(
        clk190hz,
        dataBus,
        state,
        who,
        shine,
        pos1,
        pos2,
        seg1,
        seg2
    );
    
    DataReg DataReg (
        clk100mhz,
        clr,
        Key_out,
        r_mov,
        l_mov,
        who,
        add,
        sub,
        data
    );
    
    InputJudge InputJudge (
        clk100mhz,
        clr,
        Key_in,
        Key_out
    );
    
    Control Control(
        clk100mhz,
        Key_out,
        state,
        shine,
        r_mov,
        l_mov,
        who,
        add,
        sub
    );
endmodule