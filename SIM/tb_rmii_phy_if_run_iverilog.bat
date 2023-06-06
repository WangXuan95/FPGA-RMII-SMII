del sim.out dump.vcd
iverilog  -g2001  -o sim.out  tb_rmii_phy_if.v  ../RTL/rmii_phy_if.v
vvp -n sim.out
del sim.out
pause