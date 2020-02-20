`include "../com/com2.v"
`include "sevseg.v"


module pmod_7seg1 (
    input  CLK,
    input  RX,
    output TX,
    output wire P2_1,
    output wire P2_2,
    output wire P2_3,
    output wire P2_4,
    output wire P2_7,
    output wire P2_8,
    output wire P2_9,
    output wire P2_10
    );

    wire [7:0] DATA_IN0;
    wire [7:0] DATA_IN1;
    wire [7:0] DATA_OUT0;
    wire [7:0] DATA_OUT1;

    wire [7:0] PMOD;
    wire [7:0] DIGIT0;
    wire [7:0] DIGIT1;

    com2 com2_inst(
    	CLK,
    	RX,
      	TX,
    	DATA_IN0,
    	DATA_IN1,
        DATA_OUT0,
    	DATA_OUT1
    );

    sevsegraw sevsegraw_inst(
        CLK,
        DIGIT0,
        DIGIT1,
        PMOD
    );

    assign {P2_10, P2_9, P2_8, P2_7, P2_4, P2_3, P2_2, P2_1} = PMOD;
    assign DIGIT0 = DATA_IN0;
    assign DIGIT1 = DATA_IN1;

    assign DATA_OUT0 = 8'd0;
    assign DATA_OUT1 = 8'd0;
endmodule
