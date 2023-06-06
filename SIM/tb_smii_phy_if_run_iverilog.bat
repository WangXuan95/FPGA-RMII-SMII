del sim.out dump.vcd
iverilog  -g2001  -o sim.out  tb_smii_phy_if.v  ../RTL/smii_phy_if.v
vvp -n sim.out
del sim.out
pause