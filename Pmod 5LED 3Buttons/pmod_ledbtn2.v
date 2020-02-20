`include "../com/com2.v"

module pmod_ledbtn2(
    input  CLK,
    input  RX,
    output TX,
    output reg LED1,
    output reg LED2,
    output reg LED3,
    output reg LED4,
    output reg LED5,
    input wire BTN1,
    input wire BTN2,
    input wire BTN3
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

    assign DATA_OUT0 = 8'd0;
    assign DATA_OUT1 = 8'd0;


    reg [7:0] pwm = 4'd0;
	reg [12:0] pwm_counter = 13'd0;
	reg pwm_out = 0;
	always @(posedge CLK) begin
		if (pwm_counter < 13'h1FDF)
			pwm_counter <= pwm_counter +13'd1;
		else
			pwm_counter <= 13'd0;
		if (pwm_counter[12:5] < DATA_IN0)
			LED1 <= 1;
		else
			LED1 <= 0;
        if (pwm_counter[12:5] < DATA_IN1) begin
            LED2 <= 1;
            LED3 <= 1;
            LED4 <= 1;
            LED5 <= 1;
        end
		else begin
            LED2 <= 0;
            LED3 <= 0;
            LED4 <= 0;
            LED5 <= 0;
		end
	end
endmodule
