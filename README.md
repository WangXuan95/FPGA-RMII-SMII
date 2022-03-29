![语言](https://img.shields.io/badge/语言-systemverilog_(IEEE1800_2005)-CAD09D.svg) ![仿真](https://img.shields.io/badge/仿真-iverilog-green.svg) ![部署](https://img.shields.io/badge/部署-quartus-blue.svg) ![部署](https://img.shields.io/badge/部署-vivado-FF1010.svg)

MII to RMII and MII to SMII
===========================

一些以太网 PHY 芯片拥有 RMII 或 SMII 接口，然而 FPGA 中的软核或硬核的 MAC 往往是 MII 接口的。

为了实现适配，本库实现了：

- 10M/100M 以太网的 MII 转 RMII

- 10M/100M 以太网的 MII 转 SMII



# MII to RMII

    -----------           ----------------------------------------------                   ------------------
    |         |           |                                            |     ---------     |                |
    |         |<----------| mii_crs                                    |     | 50MHz |     |                |
    |         |<----------| mii_rxrst                                  |     |  OSC  |     |                |
    |         |<----------| mii_rxc                                    |     ---------     |                |
    |         |<----------| mii_rxdv                                   |         |         |                |
    |         |<----------| mii_rxer                      rmii_ref_clk |<--------^-------->| phy_ref_clk    |
    |         |<----------| mii_rxd      rmii_phy_if.sv                |                   |                |
    |   MAC   |<----------| mii_txrst                       rmii_crsdv |<------------------|      PHY       |
    |         |<----------| mii_txc                          rmii_rxer |<------------------|  e.g. LAN8720  |
    |         |---------->| mii_txen                          rmii_rxd |<------------------|                |
    |         |---------->| mii_txer                         rmii_txen |------------------>|                |
    |         |---------->| mii_txd                           rmii_txd |------------------>|                |
    |         |    MII    |                                            |       RMII        |                |
    -----------           ----------------------------------------------                   ------------------

## 代码

见 RTL 目录中的 rmii_phy_if.sv 。它是根据规范文档 RMII.pdf 编写的。使用方法详见代码注释。它已在 LAN8720（一个 RMII 接口的 PHY 芯片）上成功运行了网络通信。

> 注：RMII 接口频率为 50MHz ，因此 FPGA 和 PHY 芯片之间的连接要足够短，最好画在同一个PCB上，或直接用插针传递信号，不要用杜邦线连接。

## 仿真

仿真相关的文件都在 SIM 文件夹中，其中：

- tb_rmii_phy_if.sv 是针对 rmii_phy_if.sv 的 testbench，它在 RMII RX 通道上生成假的、短小的帧，rmii_phy_if 会把它转换成 MII RX 的波形。同时，它在 MII TX 通道上生成假的、短小的帧，通过 rmii_phy_if 转换成 RMII TX 的波形。
- tb_rmii_phy_if_run_iverilog.bat 包含了运行 iverilog 仿真的命令。

使用 iverilog 进行仿真前，需要安装 iverilog ，见：[iverilog_usage](https://github.com/WangXuan95/WangXuan95/blob/main/iverilog_usage/iverilog_usage.md)

然后双击 tb_rmii_phy_if_run_iverilog.bat 运行仿真，然后可以打开生成的 dump.vcd 文件查看波形。



# MII to SMII

    -----------           ----------------------------------------------                   -----------------------
    |         |           |                                            |     ---------     |                     |
    |         |<----------| mii_crs                                    |     | 125MHz|     |                     |
    |         |<----------| mii_rxrst                                  |     |  OSC  |     |                     |
    |         |<----------| mii_rxc                                    |     ---------     |                     |
    |         |<----------| mii_rxdv                                   |         |         |                     |
    |         |<----------| mii_rxer                      smii_ref_clk |<--------^-------->| phy_ref_clk         |
    |         |<----------| mii_rxd      smii_phy_if.sv                |                   |                     |
    |   MAC   |<----------| mii_txrst                                  |                   |      PHY            |
    |         |<----------| mii_txc                          smii_sync |------------------>|  e.g. KSZ8041TLI-S  |
    |         |---------->| mii_txen                          smii_rxd |<------------------|                     |
    |         |---------->| mii_txer                          smii_txd |------------------>|                     |
    |         |---------->| mii_txd                                    |       SMII        |                     |
    |         |    MII    |                                            |                   |                     |
    -----------           ----------------------------------------------                   -----------------------

## 代码

见 RTL 目录中的 smii_phy_if.sv 。它是根据规范文档 SMII.pdf 编写的。使用方法详见代码注释。它已在 KSZ8041TLI-S（一个 SMII 接口的 PHY 芯片）上成功运行了网络通信。

>  注：SMII 接口频率为 125MHz ，因此 FPGA 和 PHY 芯片之间的连接要足够短，最好画在同一个PCB上。

## 仿真

仿真相关的文件都在 SIM 文件夹中，其中：

- tb_smii_phy_if.sv 是针对 smii_phy_if.sv 的 testbench，它在 SMII RX 通道上生成假的、短小的帧，smii_phy_if 会把它转换成 MII RX 的波形。同时，它在 MII TX 通道上生成假的、短小的帧，通过 smii_phy_if 转换成 SMII TX 的波形。
- tb_smii_phy_if_run_iverilog.bat 包含了运行 iverilog 仿真的命令。

使用 iverilog 进行仿真前，需要安装 iverilog ，见：[iverilog_usage](https://github.com/WangXuan95/WangXuan95/blob/main/iverilog_usage/iverilog_usage.md)

然后双击 tb_smii_phy_if_run_iverilog.bat 运行仿真，然后可以打开生成的 dump.vcd 文件查看波形。



# 参考资料

* [github.com/alexforencich/verilog-ethernet](github.com/alexforencich/verilog-ethernet)
