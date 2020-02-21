`include "../com/com2.v"
`include "sevseg.v"


module pmod_7seg1 (
    input  CLK,
    input  RX,
    output TX,
    output wire P1A1,
    output wire P1A2,
    output wire P1A3,
    output wire P1A4,
    output wire P1A7,
    output wire P1A8,
    output wire P1A9,
    output wire P1A10
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

    assign {P1A10, P1A9, P1A8, P1A7, P1A4, P1A3, P1A2, P1A1} = PMOD;
    assign DIGIT0 = DATA_IN0;
    assign DIGIT1 = DATA_IN1;

    assign DATA_OUT0 = 8'd0;
    assign DATA_OUT1 = 8'd0;
endmodule
