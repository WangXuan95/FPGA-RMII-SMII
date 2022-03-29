del sim.out dump.vcd
iverilog  -g2005-sv  -o sim.out  tb_rmii_phy_if.sv  ../RTL/rmii_phy_if.sv
vvp -n sim.out
del sim.out
pause