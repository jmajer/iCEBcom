`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module com8_tb();


reg        CLK;
reg        RX;
wire       TX;
wire [7:0] DATA_IN0;
wire [7:0] DATA_IN1;
wire [7:0] DATA_IN2;
wire [7:0] DATA_IN3;
wire [7:0] DATA_IN4;
wire [7:0] DATA_IN5;
wire [7:0] DATA_IN6;
wire [7:0] DATA_IN7;
reg  [7:0] DATA_OUT0;
reg  [7:0] DATA_OUT1;
reg  [7:0] DATA_OUT2;
reg  [7:0] DATA_OUT3;
reg  [7:0] DATA_OUT4;
reg  [7:0] DATA_OUT5;
reg  [7:0] DATA_OUT6;
reg  [7:0] DATA_OUT7;

// instantiate the unit to test
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

initial begin
    CLK = 0;
    RX  = 0;
    DATA_OUT0 = 8'd0;
    DATA_OUT1 = 8'd0;
    DATA_OUT2 = 8'd0;
    DATA_OUT3 = 8'd0;
    DATA_OUT4 = 8'd0;
    DATA_OUT5 = 8'd0;
    DATA_OUT6 = 8'd0;
    DATA_OUT7 = 8'd0;

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

    DATA_OUT5 = 8'hAA;
    #1000000

    $display("End of simulation");
    $finish;
end

// clock 12 MHz
always #41.667 CLK = ~CLK;

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(com8_tb));
    $dumpvars(0, com8_tb);
end

endmodule
