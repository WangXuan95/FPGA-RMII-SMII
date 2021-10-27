MII to RMII and MII to SMII
===========================
一些以太网 PHY 芯片拥有 RMII 或 SMII 接口，然而 FPGA 中的软核或硬核的 MAC 往往是 MII 接口的。

为了实现适配，我用 Verilog 实现了：

- 10M/100M 以太网的 MII 转 RMII

- 10M/100M 以太网的 MII 转 SMII



# MII to RMII

## 代码

见 **rmii_phy_if.sv** 。它是根据规范文档 spec/RMII.pdf 编写的。使用方法详见代码注释。它已在 LAN8720（一个 RMII 接口的 PHY 芯片）上成功运行了网络通信。

> 注：RMII 接口频率为 50MHz ，因此 FPGA 和 PHY 芯片之间的连接要足够短，最好画在同一个PCB上，或直接用插针传递信号，不要用杜邦线连接。

## 仿真

**tb_rmii_phy_if.sv** 是 **rmii_phy_if.sv** 的仿真文件。

它在 RMII RX 通道上生成假的、短小的包，rmii_phy_if 会把它转换成 MII RX 的波形。同时，它在 MII TX 通道上生成假的、短小的包，通过 rmii_phy_if 转换成 RMII TX 的波形。



# MII to SMII

## 代码

见 **smii_phy_if.sv** 。它是根据规范文档 spec/SMII.pdf 编写的。使用方法详见代码注释。它已在 KSZ8041TLI-S（一个 SMII 接口的 PHY 芯片）上成功运行了网络通信。

>  注：SMII 接口频率为 125MHz ，因此 FPGA 和 PHY 芯片之间的连接要足够短，最好画在同一个PCB上。

## 仿真

**tb_smii_phy_if.sv** 是 **smii_phy_if.sv** 的仿真文件。

它在 SMII RX 通道上生成假的、短小的包，smii_phy_if 会把它转换成 MII RX 的波形。同时，它在 MII TX 通道上生成假的、短小的包，通过 smii_phy_if 转换成 SMII TX 的波形。



# 参考资料

* [github.com/alexforencich/verilog-ethernet](github.com/alexforencich/verilog-ethernet)
