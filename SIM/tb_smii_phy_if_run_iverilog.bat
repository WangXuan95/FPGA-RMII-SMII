del sim.out dump.vcd
iverilog  -g2005-sv  -o sim.out  tb_smii_phy_if.sv  ../RTL/smii_phy_if.sv
vvp -n sim.out
del sim.out
pause