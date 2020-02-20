`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 1 ns / 1 ps

module pmod_ledbtn2_tb();

reg  CLK;
reg  RX;
wire TX;
wire LED1;
wire LED2;
wire LED3;
wire LED4;
wire LED5;
reg  BTN1;
reg  BTN2;
reg  BTN3;

// instantiate the unit to test
pmod_ledbtn2 pmod_ledbtn2_inst(
    CLK,
    RX,
    TX,
    LED1,
    LED2,
    LED3,
    LED4,
    LED5,
    BTN1,
    BTN2,
    BTN3
);

initial begin
    CLK = 0;
    RX  = 0;
    BTN1 = 0;
    BTN2 = 0;
    BTN3 = 0;

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

    // character 'F'=0x46
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

    #2000000

    $display("End of simulation");
    $finish;
end

// clock 12 MHz
always #41.667 CLK = ~CLK;

initial begin
    //-- File were to store the simulation results
    $dumpfile(`DUMPSTR(pmod_ledbtn2_tb));
    $dumpvars(0, pmod_ledbtn2_tb);
end

endmodule
