PROJ = template8

PIN_DEF = icebreaker.pcf
DEVICE = up5k
PKG = sg48
OPTION = --freq 12

all: $(PROJ).rpt $(PROJ).bin

%.blif: %.v *.v
	yosys -q -p 'synth_ice40 -top $(PROJ) -blif $@' $^

$(PROJ).json: $(PROJ).v
	yosys -q -p 'synth_ice40 -top $(PROJ) -json $@' $^

#%.asc: $(PIN_DEF) %.blif
# 	arachne-pnr -d 8k -P $(PKG) -o $@ -p $^

%.asc: $(PIN_DEF) %.json
	nextpnr-ice40 -q $(OPTION) --$(DEVICE) --package $(PKG) --pcf $(PIN_DEF) --json $*.json --asc $@

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

%_syn.v: %.blif
	yosys -p 'read_blif -wideports $^; write_verilog $@'

%_tb.out: %_tb.v %.v
	iverilog -D SIM -o $@ $^

%_tb.vcd: %_tb.out
	vvp -N $< +vcd=$@.out

gui: $(PIN_DEF) $(PROJ).json
	nextpnr-ice40 $(OPTION) --$(DEVICE) --package $(PKG) --pcf $(PIN_DEF) --json $(PROJ).json --asc $(PROJ).asc --gui

sim: $(PROJ)_tb.vcd

view: $(PROJ).asc
	iceview_html.py $(PROJ).asc $(PROJ).html

prog: $(PROJ).bin
	iceprog $<

clean:
	rm -f *.blif *.json *.asc *_tb.out *_tb.vcd *.rpt *.bin

.SECONDARY:
.PHONY: all clean
