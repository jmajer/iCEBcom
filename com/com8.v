/*

*/

`include "../com/uart_tx.v"
`include "../com/uart_rx.v"

module com8 (
	input  CLK,
	input  RX,
  	output TX,
	output reg [7:0] DATA_IN0,		// data from the host to the fpga
	output reg [7:0] DATA_IN1,
	output reg [7:0] DATA_IN2,
	output reg [7:0] DATA_IN3,
	output reg [7:0] DATA_IN4,
	output reg [7:0] DATA_IN5,
	output reg [7:0] DATA_IN6,
	output reg [7:0] DATA_IN7,
	input wire [7:0] DATA_OUT0,		// data from the fpga to the host
	input wire [7:0] DATA_OUT1,
	input wire [7:0] DATA_OUT2,
	input wire [7:0] DATA_OUT3,
	input wire [7:0] DATA_OUT4,
	input wire [7:0] DATA_OUT5,
	input wire [7:0] DATA_OUT6,
	input wire [7:0] DATA_OUT7
	);


	// instantiate the rx and tx module
	reg tx1_start = 0;
	reg [7:0] tx1_data;
	wire tx1_busy;
	uart_tx #(clk_freq, baud) utx1 (
		.clk(CLK),
		.tx_start(tx1_start),
		.tx_data(tx1_data),
		.tx(TX),
		.tx_busy(tx1_busy)
	);
	wire reg rx1_ready;
	wire reg [7:0] rx1_data;
	uart_rx #(clk_freq, baud) urx1 (
		.clk(CLK),
		.rx(RX),
		.rx_ready(rx1_ready),
		.rx_data(rx1_data)
	);
	// clock parameters
	localparam clk_freq = 12_000_000; // 12MHz
	localparam baud = 115200;

	// receiver
	reg [3:0] uartstatus = 0;
	reg [3:0] register = 0;
	reg [7:0] rdata = 0;
	wire [3:0] hexval;
	assign hexval[3:0] = rx1_data>"9" ? rx1_data-"A"+10 : rx1_data-"0";

	always @(posedge CLK) begin
		if(rx1_ready) begin
			case (uartstatus)
				0 :
					begin
	                    if(rx1_data == "S")
	                        uartstatus <= 4'd1;
	                end
				1 :
					begin
						register[3:0] <= hexval;
						uartstatus <= 4'd2;
					end
				2 :
					begin
						rdata[7:4] <= hexval;
						uartstatus <= 4'd3;
					end
				3 :
					begin
						uartstatus <= 4'd0;
						if (register==0)
							DATA_IN0 <= {rdata[7:4], hexval};
						else if (register==1)
							DATA_IN1 <= {rdata[7:4], hexval};
						else if (register==2)
							DATA_IN2 <= {rdata[7:4], hexval};
						else if (register==3)
							DATA_IN3 <= {rdata[7:4], hexval};
						else if (register==4)
							DATA_IN4 <= {rdata[7:4], hexval};
						else if (register==5)
							DATA_IN5 <= {rdata[7:4], hexval};
						else if (register==6)
							DATA_IN6 <= {rdata[7:4], hexval};
						else if (register==7)
							DATA_IN7 <= {rdata[7:4], hexval};
					end
			endcase
		end
	end


	// transmitter state machine
	reg [3:0] state = 0;
	reg [2:0] chan;
	reg [7:0] data;
	reg [7:0] out0 = 8'd0;
	reg [7:0] out1 = 8'd0;
	reg [7:0] out2 = 8'd0;
	reg [7:0] out3 = 8'd0;
	reg [7:0] out4 = 8'd0;
	reg [7:0] out5 = 8'd0;
	reg [7:0] out6 = 8'd0;
	reg [7:0] out7 = 8'd0;
	always @(posedge CLK) begin
		case(state)
			4'd0:		// idle
			begin
				if (DATA_OUT0!=out0) begin
					out0 <= DATA_OUT0;
					data <= DATA_OUT0;
					chan <= 3'd0;
					state <= 4'd1;
				end
				else if (DATA_OUT1!=out1) begin
					out1 <= DATA_OUT1;
					data <= DATA_OUT1;
					chan <= 3'd1;
					state <= 4'd1;
				end
				else if (DATA_OUT2!=out2) begin
					out2 <= DATA_OUT2;
					data <= DATA_OUT2;
					chan <= 3'd2;
					state <= 4'd1;
				end
				else if (DATA_OUT3!=out3) begin
					out3 <= DATA_OUT3;
					data <= DATA_OUT3;
					chan <= 3'd3;
					state <= 4'd1;
				end
				else if (DATA_OUT4!=out4) begin
					out4 <= DATA_OUT4;
					data <= DATA_OUT4;
					chan <= 3'd4;
					state <= 4'd1;
				end
				else if (DATA_OUT5!=out5) begin
					out5 <= DATA_OUT5;
					data <= DATA_OUT5;
					chan <= 3'd5;
					state <= 4'd1;
				end
				else if (DATA_OUT6!=out6) begin
					out6 <= DATA_OUT6;
					data <= DATA_OUT6;
					chan <= 3'd6;
					state <= 4'd1;
				end
				else if (DATA_OUT7!=out7) begin
					out7 <= DATA_OUT7;
					data <= DATA_OUT7;
					chan <= 3'd7;
					state <= 4'd1;
				end
			end
			4'd1:		// send character 'D'
			begin
				if (!tx1_busy && !tx1_start) begin
					tx1_data <= "D";
					tx1_start <= 1;
				end
				if (tx1_busy && tx1_start) begin
					tx1_start <= 0;
					state <= 4'd2;
				end
			end
			4'd2:		// send channel number
			begin
				if (!tx1_busy && !tx1_start) begin
					tx1_data <= "0"+chan;
					tx1_start <= 1;
				end
				if (tx1_busy && tx1_start) begin
					tx1_start <= 0;
					state <= 4'd3;
				end
			end
			4'd3:		// send upper half byte
			begin
				if (!tx1_busy && !tx1_start) begin
					tx1_data <= data[7:4]<4'd10 ? "0"+data[7:4] : 8'd55+data[7:4];
					tx1_start <= 1;
				end
				if (tx1_busy && tx1_start) begin
					tx1_start <= 0;
					state <= 4'd4;
				end
			end
			4'd4:		// send lower half byte
			begin
				if (!tx1_busy && !tx1_start) begin
					tx1_data <= data[3:0]<4'd10 ? "0"+data[3:0] : 8'd55+data[3:0];
					tx1_start <= 1;
				end
				if (tx1_busy && tx1_start) begin
					tx1_start <= 0;
					state <= 4'd5;
				end
			end
			4'd5:		// send return character
			begin
				if (!tx1_busy && !tx1_start) begin
					tx1_data <= 8'h0A;
					tx1_start <= 1;
				end
				if (tx1_busy && tx1_start) begin
					tx1_start <= 0;
					state <= 4'd0;
				end
			end
			default:
			begin
				state <= 4'd0;
				tx1_start <= 0;
			end
		endcase
	end

endmodule
