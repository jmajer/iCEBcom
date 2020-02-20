module sevsegraw (
    input wire CLK,
    input wire [7:0] DIGIT0,
    input wire [7:0] DIGIT1,
    output wire [7:0] PMOD
    );

    reg aa;
    reg ab;
    reg ac;
    reg ad;
    reg ae;
    reg af;
    reg ag;
    reg ca;

    reg [12:0] counter = 13'd0;
    always @(posedge CLK) begin
        counter <= counter + 13'd1;
    end

    always @(posedge CLK) begin
        if (counter[12]==0) begin
            aa <= ~DIGIT0[0];
            ab <= ~DIGIT0[1];
            ac <= ~DIGIT0[2];
            ad <= ~DIGIT0[3];
            ae <= ~DIGIT0[4];
            af <= ~DIGIT0[5];
            ag <= ~DIGIT0[6];
            ca <= 1;
        end
        else begin
            aa <= ~DIGIT1[0];
            ab <= ~DIGIT1[1];
            ac <= ~DIGIT1[2];
            ad <= ~DIGIT1[3];
            ae <= ~DIGIT1[4];
            af <= ~DIGIT1[5];
            ag <= ~DIGIT1[6];
            ca <= 0;
        end
    end

    assign PMOD = {ca, ag, af, ae, ad, ac, ab, aa};
endmodule

module sevseg (
    input wire CLK,
    input wire [3:0] DIGIT0,
    input wire [3:0] DIGIT1,
    output wire [7:0] PMOD
    );

    reg aa;
    reg ab;
    reg ac;
    reg ad;
    reg ae;
    reg af;
    reg ag;
    reg ca;

    reg [12:0] counter = 13'd0;
    always @(posedge CLK) begin
        counter <= counter + 13'd1;
    end

    wire [6:0] sseg0;
    wire [6:0] sseg1;
    hex2sseg hex2sseg_inst0(
        CLK,
        DIGIT0,
        sseg0
    );

    hex2sseg hex2sseg_inst1(
        CLK,
        DIGIT1,
        sseg1
    );

    always @(posedge CLK) begin
        if (counter[12]==0) begin
            aa <= ~sseg0[0];
            ab <= ~sseg0[1];
            ac <= ~sseg0[2];
            ad <= ~sseg0[3];
            ae <= ~sseg0[4];
            af <= ~sseg0[5];
            ag <= ~sseg0[6];
            ca <= 1;
        end
        else begin
            aa <= ~sseg1[0];
            ab <= ~sseg1[1];
            ac <= ~sseg1[2];
            ad <= ~sseg1[3];
            ae <= ~sseg1[4];
            af <= ~sseg1[5];
            ag <= ~sseg1[6];
            ca <= 0;
        end
    end

    assign PMOD = {ca, ag, af, ae, ad, ac, ab, aa};
endmodule

module hex2sseg(
    input wire CLK,
    input wire [3:0] NUMBER,
    output reg [6:0] SSEG
    );

    always @(posedge CLK) begin
        case (NUMBER)
            4'h0:
                SSEG <= 7'b0111111;
            4'h1:
                SSEG <= 7'b0000110;
            4'h2:
                SSEG <= 7'b1011011;
            4'h3:
                SSEG <= 7'b1001111;
            4'h4:
                SSEG <= 7'b1100110;
            4'h5:
                SSEG <= 7'b1101101;
            4'h6:
                SSEG <= 7'b1111101;
            4'h7:
                SSEG <= 7'b0000111;
            4'h8:
                SSEG <= 7'b1111111;
            4'h9:
                SSEG <= 7'b1101111;
            4'hA:
              	SSEG <= 7'b1110111;
            4'hB:
             	SSEG <= 7'b1111100;
            4'hC:
            	SSEG <= 7'b0111001;
            4'hD:
            	SSEG <= 7'b1011110;
            4'hE:
                SSEG <= 7'b1111001;
            4'hF:
            	SSEG <= 7'b1110001;
        endcase
    end
endmodule
