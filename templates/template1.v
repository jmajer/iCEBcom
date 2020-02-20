`include "../com/com1.v"

module template1(
    input  CLK,
    input  RX,
    output TX
    );

    wire [7:0] DATA_IN0;
    wire [7:0] DATA_OUT0;

    com1 com1_inst(
    	CLK,
    	RX,
      	TX,
    	DATA_IN0,
        DATA_OUT0
    );

    assign DATA_OUT0 = DATA_IN0;
endmodule
