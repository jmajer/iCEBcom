`include "../com/com8.v"

module template8(
    input  CLK,
    input  RX,
    output TX
    );

    wire [7:0] DATA_IN0;
    wire [7:0] DATA_IN1;
    wire [7:0] DATA_IN2;
    wire [7:0] DATA_IN3;
    wire [7:0] DATA_IN4;
    wire [7:0] DATA_IN5;
    wire [7:0] DATA_IN6;
    wire [7:0] DATA_IN7;
    wire [7:0] DATA_OUT0;
    wire [7:0] DATA_OUT1;
    wire [7:0] DATA_OUT2;
    wire [7:0] DATA_OUT3;
    wire [7:0] DATA_OUT4;
    wire [7:0] DATA_OUT5;
    wire [7:0] DATA_OUT6;
    wire [7:0] DATA_OUT7;

    com8 com8_inst(
    	CLK,
    	RX,
      	TX,
        DATA_IN0,
        DATA_IN1,
        DATA_IN2,
        DATA_IN3,
        DATA_IN4,
        DATA_IN5,
        DATA_IN6,
        DATA_IN7,
        DATA_OUT0,
        DATA_OUT1,
        DATA_OUT2,
        DATA_OUT3,
        DATA_OUT4,
        DATA_OUT5,
        DATA_OUT6,
        DATA_OUT7
    );

    assign DATA_OUT0 = DATA_IN0;
    assign DATA_OUT1 = DATA_IN1;
    assign DATA_OUT2 = DATA_IN2;
    assign DATA_OUT3 = DATA_IN3;
    assign DATA_OUT4 = DATA_IN4;
    assign DATA_OUT5 = DATA_IN5;
    assign DATA_OUT6 = DATA_IN6;
    assign DATA_OUT7 = DATA_IN7;
endmodule
