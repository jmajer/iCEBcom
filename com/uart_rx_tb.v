`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module uart_rx_tb();


reg        CLK;
reg        rx;
wire       rx_ready;
wire [7:0] rx_data;
wire       rx_idle;
wire       rx_eop;

// instantiate the unit to test
uart_rx uart_rx_inst(
    CLK,
	rx,
	rx_ready,
	rx_data,
	rx_idle,
	rx_eop
);

initial begin
  CLK = 0;
  rx = 0;
  #8680.555

  // character 'H'=0x48
  rx = 0;
  #8680.555
  rx = 0;
  #8680.555
  rx = 0;
  #8680.555
  rx = 1;
  #8680.555
  rx = 0;
  #8680.555
  rx = 0;
  #8680.555
  rx = 1;
  #8680.555
  rx = 0;
  #8680.555

  rx = 1;
  #8680.555
  rx = 0;
  #8680.555

  // character 'e'=0x65
  rx = 1;
  #8680.555
  rx = 0;
  #8680.555
  rx = 1;
  #8680.555
  rx = 0;
  #8680.555
  rx = 0;
  #8680.555
  rx = 1;
  #8680.555
  rx = 1;
  #8680.555
  rx = 0;
  #8680.555

  rx = 1;
  #8680.555
  rx = 1;
  #8680.555

  #100000
  $display("End of simulation");
  $finish;
end

// clock 12 MHz
always #41.667 CLK = ~CLK;

initial begin
  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(uart_rx_tb));
  $dumpvars(0, uart_rx_tb);
end

endmodule
