# iCEBcom

This project provides modules for a simple communication between the host computer and the iCBreaker FPGA. The communication is realized with 1,2,4 or 8 input and output bytes. Furtermore, there python GUIs to control the data on the host side.

## Getting Started

Prerequisit:

* install the icestorm toolchain
* install python3 with pyserial and PyQt5 

Start the first example by executing the following commands

`cd Pmod\ 5LED\ 3Buttons/`

`make prog`

`python3 pmod_ledbtn1.py`

![pmod_ledbtn1.png](img/pmod_ledbtn1.png)

If you want run the second example, change the first line of the Makefile and replace the `1` with a `2`. Then run `make prog` and `python3 pmod_ledbtn2.py`.

![pmod_ledbtn2.png](img/pmod_ledbtn2.png)

## 7 Segment Display

Make sure that 7 segment dispaly is connected to Pmod 1A. Then use `make prog` and `python3 pmod_7seg1.py`. 

![pmod_7seg1.png](img/pmod_7seg1.png)

![pmod_7seg1.png](img/pmod_7seg2.png)

## templates

![template.png](img/template.png)

## com folder

