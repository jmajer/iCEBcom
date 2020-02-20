`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module com2_tb();


reg        CLK;
reg        RX;
wire       TX;
wire [7:0] DATA_IN0;
wire [7:0] DATA_IN1;
reg  [7:0] DATA_OUT0;
reg  [7:0] DATA_OUT1;

// instantiate the unit to test
com2 com2_inst(
    CLK,
    RX,
    TX,
    DATA_IN0,
    DATA_IN1,
    DATA_OUT0,
    DATA_OUT1
);

initial begin
    CLK = 0;
    RX  = 0;
    DATA_OUT0 = 8'd0;
    DATA_OUT1 = 8'd0;

    #8680.555

    // character 'S'=0x53
    RX = 1;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    // character '0'=0x30
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555

    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    // character 'E'=0x45
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    // character '6'=0x36
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555

    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    // character '\n'=0x0A
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555

    RX = 1;
    #8680.555
    RX = 1;
    #8680.555


    #557291.695


    RX = 0;
    #8680.555

    // character 'S'=0x53
    RX = 1;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    // character '1'=0x31
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555

    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    // character 'D'=0x44
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    RX = 1;
    #8680.555
    RX = 0;
    #8680.555

    // character '4'=0x34
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 1;
    #8680.555
    RX = 1;
    #8680.555
    RX = 0;
    #8680.555
    RX = 0;
    #8680.555

    RX = 1;
    #8680.555
    RX = 1;
    #8680.555

    //#643864.151
    #644097.245

    DATA_OUT0 = 8'd155;
    #1000000

    DATA_OUT1 = 8'hAA;
    #1000000

    $display("End of simulation");
    $finish;
end

// clock 12 MHz
always #41.667 CLK = ~CLK;

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(com2_tb));
    $dumpvars(0, com2_tb);
end

endmodule
