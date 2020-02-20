`include "../com/com1.v"

module pmod_ledbtn1(
    input  CLK,
    input  RX,
    output TX,
    output LED1,
    output LED2,
    output LED3,
    output LED4,
    output LED5,
    input  BTN1,
    input  BTN2,
    input  BTN3
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

    assign {LED5, LED4, LED3, LED2, LED1} = DATA_IN0[4:0];
    assign DATA_OUT0 = {5'd0, BTN3, BTN2, BTN1};
endmodule
