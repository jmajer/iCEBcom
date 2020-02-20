`include "../com/com4.v"

module template4(
    input  CLK,
    input  RX,
    output TX
    );

    wire [7:0] DATA_IN0;
    wire [7:0] DATA_IN1;
    wire [7:0] DATA_IN2;
    wire [7:0] DATA_IN3;
    wire [7:0] DATA_OUT0;
    wire [7:0] DATA_OUT1;
    wire [7:0] DATA_OUT2;
    wire [7:0] DATA_OUT3;

    com4 com4_inst(
    	CLK,
    	RX,
      	TX,
        DATA_IN0,
        DATA_IN1,
        DATA_IN2,
        DATA_IN3,
        DATA_OUT0,
        DATA_OUT1,
        DATA_OUT2,
        DATA_OUT3
    );

    assign DATA_OUT0 = DATA_IN0;
    assign DATA_OUT1 = DATA_IN1;
    assign DATA_OUT2 = DATA_IN2;
    assign DATA_OUT3 = DATA_IN3;
endmodule
