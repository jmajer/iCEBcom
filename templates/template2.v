`include "../com/com2.v"

module template2(
    input  CLK,
    input  RX,
    output TX
    );

    wire [7:0] DATA_IN0;
    wire [7:0] DATA_IN1;
    wire [7:0] DATA_OUT0;
    wire [7:0] DATA_OUT1;

    com2 com2_inst(
    	CLK,
    	RX,
      	TX,
        DATA_IN0,
        DATA_IN1,
        DATA_OUT0,
        DATA_OUT1
    );

    assign DATA_OUT0 = DATA_IN0;
    assign DATA_OUT1 = DATA_IN1;
endmodule
