`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module uart_tx_tb();

// Simulation time
parameter DURATION = 110000;

reg       CLK;
reg       tx_start;
reg [7:0] tx_data;
wire      tx;
wire      tx_busy;

// instantiate the unit to test
uart_tx uart_tx_inst(
    CLK,
	tx_start,
	tx_data,
	tx,
	tx_busy
);

initial begin
  CLK = 0;
  tx_start = 0;
  tx_data = 8'h48;
  #100
  tx_start = 1;
  #500
  tx_start = 0;
  #(DURATION)
  $display("End of simulation");
  $finish;
end

// clock 12 MHz
always #41.667 CLK = ~CLK;

initial begin
  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(uart_tx_tb));
  $dumpvars(0, uart_tx_tb);
end

endmodule
