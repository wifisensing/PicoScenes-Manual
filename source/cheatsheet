PicoScenes Cheat Sheet
======================

Parameters Description
-----------------------


Quick Templates
----------------

.. *斜体*
.. `解释文字`
.. **粗体**
.. ``行内文字asdfadsf``

.. 这是一个段落

.. - 符号列表1
.. - 符号列表2

..     + 二级标题
..     + 二级标题

.. .. code-block:: bash
    
.. .. bash脚本写在这里

本小节为用户提供了若干测试用例代码。用户安装 `PicoScenes` 并测试软硬件环境状态，如果软硬件环境一切正常。用户可以运行本节中的若干测试代码来快速上手 `PicoScenes` 。

两台电脑单接收单发送模式(injector-logger)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

本个测试用例代码的作用在于将一台电脑设置为发送端，将另一台电脑设置为接收端进行一次测试。在测试完成后，用户将在接收端 `shell(.sh)` 脚本所在目录发现一个后缀为 `.csi` 的文件。在后续操作中，用户可以通过 `matlab` 解析 `.csi` 文件来得到本次测试的具体数据，从而进行后续的数据分析以及实验改进。

接收端的 `shell` 脚本代码如下：

.. code-block:: bash

    #!/bin/bash
    
    set -e

    # array_prepare_for_picoscenes 可以通过添加参数和值来将指定的网卡设置为指定状态
    # all 表示将本机所有网卡都设置为 PicoScenes 工作模式
    # "5200 HT20" 表示将网卡的中心频率设置为 5200MHz, 并将带宽设置为 20MHz
    # 可以通过在终端运行 array_prepare_for_picoscenes -h 来查看详细信息

    array_prepare_for_picoscenes all "5200 HT20"

    # PicoScenes 将本机中的网卡进行了编号,可以通过在终端运行
    # array_status 来查看本机中的网卡编号,本实验中假设网卡编号为2,用户可根据本机中的网卡编号进行调整,修改2为指定值即可

    phyID=2
    
    # -d debug 表示接收端信息显示级别为 debug, 用户可在终端中输入
    # PicoScenes -h 来即时查看每一个参数的详细信息
    # -i ${phyID} 在本例中表示将2号网卡作为接收端
    # --mode logger 指定网卡的工作模式为logger,即接收模式
    # --freq 4900e6 指定网卡工作的中心频率为4900MHz, 注意,此处的中心频率可以和 array_prepare_for_picoscenes 中设置的不同
    # --rate 20e6 指定网卡工作的带宽为20MHz
    # --txcm 1 表示发送端选择的天线数为1且天线编号为1, 一个网卡最多可以指定3个天线同时发送,天线编号分别为4、2、1，可以通过指定txcm(合法值为1、2、3、4、5、6、7)来指定1~3根天线工作
    # --rxcm 1 表示接收端发送的天线数为1且天线编号为1，值选取规则和txcm相同

    PicoScenes -d debug -i ${phyID} --mode logger --freq 4900e6 --rate 20e6 --txcm 1 --rxcm 1
    # end

`array_status` 、 `array_prepare_for_picoscenes` 运行演示如下

.. code-block:: text

    csi@csi-X201:~$ array_status
    ----------------------
    Device Status of Wi-Fi NIC array "all":
    PhyPath DEV PHY [MON] DEV_MacAddr [MON_MacAddr] [CF] [BW] ProductName
    [sudo] password for csi:  
    2 wlp3s0 phy1 10:9a:dd:a6:3b:a8 AR93xx Wireless Network Adapter 
    4 wlp2s0 phy0 00:21:6a:b2:36:06 Ultimate N WiFi Link 5300 
    ----------------------
    csi@csi-X201:~$ array_prepare_for_picoscenes all
    Default working freq is 5200 HT20.
    Change CPU frequency governor to performance ...
    CPU frequency governor has been set to performance for 4 core(s).
    Un-managing NICs from Network-Manager ...
    Disabling power management...
    Disconnecting Wi-Fi...
    Stopping monitor interfaces...
    Changing MAC address...
    Skip setting the mac address (00:16:ea:12:34:56) for Intel 5300 NIC (wlp2s0)...
    Adding monitor interfaces...
    Adding a monitor interface for phy0 (phy0), named phy0mon ...
    Adding a monitor interface for phy1 (phy1), named phy1mon ...
    Changing working frequency to 5200 HT20 ...
    Preperation is done.
    ----------------------
    Device Status of Wi-Fi NIC array "all":
    PhyPath DEV PHY [MON] DEV_MacAddr [MON_MacAddr] [CF] [BW] ProductName
    2 wlp3s0 phy1 phy1mon 00:16:ea:12:34:56 10:9a:dd:a6:3b:a8 5200 20 AR93xx Wireless Network Adapter 
    4 wlp2s0 phy0 phy0mon 00:21:6a:b2:36:06 00:21:6a:b2:36:06 5200 20 Ultimate N WiFi Link 5300 
    ----------------------
    csi@csi-X201:~$ 

在本个示例中，可用网卡的编号为 `2` `4`,实验中选择编号为 `2(QCA9300网卡)` 的发送端和接收端。

发送端的 `shell` 脚本代码如下:

.. code-block:: bash

    #!/bin/bash

    set -e

    array_prepare_for_picoscenes all "5200 HT20"

    phyID=2

    # --mode injector 指定网卡的工作模式为injector,即注入模式(发送模式)
    # --delay 5e3 表示发送端连续两个包之间的间隔，单位为微秒(μs)，在本例中为每秒发送200个包
    # --repeat 100 表示整个发送过程共发送100个包
    # --mcs 0 表示发送包调制与编码策略，可查询mcs关键词来获取更多信息
    # --sts 1 表示发送端发送信号的空间流个数
    # --cbw 20 表示基带生成信号的带宽，单位为MHz，在本例中为20MHz

    PicoScenes -d debug -i ${phyID} --mode injector --freq 4900e6 --rate 20e6 --delay 5e3 --repeat 100 --txcm 1 --rxcm 1 --mcs 0 --sts 1 --cbw 20
    #end

用户可以分别粘贴发送端脚本代码和接收端脚本代码到发送端电脑和接收端电脑，然后运行两个脚本来进行实验，实验过程如下：

1. 修改发送端脚本名称为 `tx.sh` ,并使用 `chmod +x tx.sh` 赋予可执行权限；修改接收端脚本名称为 `rx.sh` ，并赋予可执行权限；

2. 进入 `rx.sh` 所在目录，并在当前目录打开终端，在终端运行 `./rx.sh`，显示类似如下信息则表示接收端成功打开；

.. code-block:: text

    [     0.001][Info]loading PicoScenes Platform...        
    [   256.939][Info]PicoScenes Platform version: 2021.0308.1534
    [   280.287][Info]PicoScenes Driver version: 20210222
    [   280.400][Debug]Try escalating PicoScenes's priority...
    [   280.459][Debug]Priority escalation succeeded!      
    [   281.581][Info]2 plugins are found...                    
    [   317.520][Warning]PicoScenes on SDR is not activated on this machine, because its CPU doesn't support AVX instruction set.
    [   483.142][Info]2 compatible Wi-Fi COTS NICs are found...
    [   638.615][Info]Command Execution Service started.  
    [   638.745][Detail]Execute command: "-d debug -i 2 --mode logger --freq 4900e6 --rate 20e6 --txcm 1 --rxcm 1"
    [   716.500][Trace]2(phy1) tunes baseband sampling rate (sf) to 20000000.0Hz in HT20 mode.
    [   718.511][Trace]2 tunes passband carrier frequency (cf) to 4900000000Hz with policy FastCC
    [   718.922][Info][2(phy1), mac=a6:3b:a8]: cf=4900.0000MHz, sf=20.0000MHz, mode=HT20, txcm = 1, rxcm = 1, txpower = 21, tx_ness = 0
    [   718.988][Detail]Device [2] calls 2 plugins to handle the command: -d debug --mode logger --freq 4900e6 --rate 20e6 --txcm 1 --rxcm 1
    [   770.491][Debug]Baseband DSP library is prefeteched successfully!

3. 进入 `tx.sh` 所在目录，并在当前目录打开终端，在终端运行 `./tx.sh`，显示类似如下信息则表示发送端成功打开；

.. code-block:: text

    [     0.003][Info]loading PicoScenes Platform...        
    [   273.938][Info]PicoScenes Platform version: 2021.0308.1534
    [   292.305][Info]PicoScenes Driver version: 20210222
    [   292.410][Debug]Try escalating PicoScenes's priority...
    [   292.457][Debug]Priority escalation succeeded!      
    [   293.975][Info]2 plugins are found...                    
    [   332.340][Warning]PicoScenes on SDR is not activated on this machine, because its CPU doesn't support AVX instruction set.
    [   504.666][Info]2 compatible Wi-Fi COTS NICs are found...
    [   683.502][Info]Command Execution Service started.  
    [   683.639][Detail]Execute command: "-d debug -i 2 --mode injector --freq 4900e6 --rate 20e6 --delay 5e3 --repeat 5 --txcm 1 --rxcm 1 --mcs 0 --sts 1 --cbw 20"
    [   763.708][Trace]2(phy1) tunes baseband sampling rate (sf) to 20000000.0Hz in HT20 mode.
    [   765.620][Trace]2 tunes passband carrier frequency (cf) to 4900000000Hz with policy FastCC
    [   765.968][Info][2(phy1), mac=63:20:8b]: cf=4900.0000MHz, sf=20.0000MHz, mode=HT20, txcm = 1, rxcm = 1, txpower = 20, tx_ness = 0
    [   766.021][Detail]Device [2] calls 2 plugins to handle the command: -d debug --mode injector --freq 4900e6 --rate 20e6 --delay 5e3 --repeat 5 --txcm 1 --rxcm 1 --mcs 0 --sts 1 --cbw 20
    [   792.307][Info]EchoProbe job parameters: sf--> 20.0 : 0.0 : 20.0MHz, cf--> 4900.0 : 0.0 : 4900.0MHz, 0.005K repeats with 5000us interval 0s delayed start.

4. 当发送端发送完成的时候即表示实验结束，可以按 `Ctrl + C` 来关闭 `PicoScenes` 的发送端和接收端。

实验测试完成后，在接收端脚本目录可以看见一个后缀为 `.csi` 的文件，则表示实验成功。

.. code-block:: text

    csi@csi-X201:~$ ll *.csi
    -rw-rw-r-- 1 csi csi 2250 Dec 31 00:13 rx_2_201231_001329.csi
    csi@csi-X201:~$ 

实验的完整显示内容如下：

**注意！在本例中为了显示方便，将发送端的发送个数--repeat设置为5，用户实际操作时可根据需求更改**

接收端：

.. code-block:: text

    csi@csi-X201:~$ cat ./rx.sh
    #!/bin/bash

    set -e

    array_prepare_for_picoscenes all "5200 HT20"

    phyID=2

    PicoScenes -d debug -i ${phyID} --mode logger --freq 4900e6 --rate 20e6 --txcm 1 --rxcm 1
    csi@csi-X201:~$ ./rx.sh
    Change CPU frequency governor to performance ...
    CPU frequency governor has been set to performance for 4 core(s).
    Un-managing NICs from Network-Manager ...
    Disabling power management...
    Disconnecting Wi-Fi...
    Stopping monitor interfaces...
    Changing MAC address...
    Skip setting the mac address (00:16:ea:12:34:56) for Intel 5300 NIC (wlp2s0)...
    Adding monitor interfaces...
    Adding a monitor interface for phy0 (phy0), named phy0mon ...
    Adding a monitor interface for phy1 (phy1), named phy1mon ...
    Changing working frequency to 5200 HT20 ...
    Preperation is done.
    ----------------------
    Device Status of Wi-Fi NIC array "all":
    PhyPath DEV PHY [MON] DEV_MacAddr [MON_MacAddr] [CF] [BW] ProductName
    2 wlp3s0 phy1 phy1mon 00:16:ea:12:34:56 10:9a:dd:a6:3b:a8 5200 20 AR93xx Wireless Network Adapter 
    4 wlp2s0 phy0 phy0mon 00:21:6a:b2:36:06 00:21:6a:b2:36:06 5200 20 Ultimate N WiFi Link 5300 
    ----------------------
    [     0.001][Info]loading PicoScenes Platform...        
    [   256.939][Info]PicoScenes Platform version: 2021.0308.1534
    [   280.287][Info]PicoScenes Driver version: 20210222
    [   280.400][Debug]Try escalating PicoScenes's priority...
    [   280.459][Debug]Priority escalation succeeded!      
    [   281.581][Info]2 plugins are found...                    
    [   317.520][Warning]PicoScenes on SDR is not activated on this machine, because its CPU doesn't support AVX instruction set.
    [   483.142][Info]2 compatible Wi-Fi COTS NICs are found...
    [   638.615][Info]Command Execution Service started.  
    [   638.745][Detail]Execute command: "-d debug -i 2 --mode logger --freq 4900e6 --rate 20e6 --txcm 1 --rxcm 1"
    [   716.500][Trace]2(phy1) tunes baseband sampling rate (sf) to 20000000.0Hz in HT20 mode.
    [   718.511][Trace]2 tunes passband carrier frequency (cf) to 4900000000Hz with policy FastCC
    [   718.922][Info][2(phy1), mac=a6:3b:a8]: cf=4900.0000MHz, sf=20.0000MHz, mode=HT20, txcm = 1, rxcm = 1, txpower = 21, tx_ness = 0
    [   718.988][Detail]Device [2] calls 2 plugins to handle the command: -d debug --mode logger --freq 4900e6 --rate 20e6 --txcm 1 --rxcm 1
    [   770.491][Debug]Baseband DSP library is prefeteched successfully!
    [  9879.858][Detail]Packet (450B) received from device [2].
    [  9880.368][Debug]2(QCA9300)<--RxFrame:{RxS:[device=QCA9300, freq=4900, CBW=20, MCS=0, numSTS=1, GI=0.8us, UsrIdx/NUsr=(0/0), timestamp=10603002, NF=-95, RSS=53], ExtraInfo:[len=67, ver=0x134622e, mac_cur[4-6]=12:34:56, mac_rom[4-6]=a6:3b:a8, chansel=5352106, bmode=0, evm[0]=28, txcm=1, rxcm=1, txpower=21, cf=4900.000000MHz, last-tsf=4161578887, flags=9, cf_policy=FastCC, pll=(44, 5, 0)], RxCSI:[(device=QCA9300, format=HT, CBW=20, cf=4900.000000MHz, sf=20.000000MHz, subcarrierBW=312.500000KHz, dim(nTones,nSTS,nESS,nRx)=(56,1,0,1), raw=140B], MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=0, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=44469, txId=0], ExtraInfo:[len=59, ver=0x20191223, mac_cur[4-6]=12:34:56, mac_rom[4-6]=63:20:8b, chansel=5352106, bmode=0, txcm=1, rxcm=1, txpower=20, cf=4900.000000MHz, sf=20.000000MHz, tx-tsf=1580676, last-tsf=20433859, flags=9, tx_ness=0, pll=(44, 5, 0)]}
    [  9890.982][Detail]Packet (450B) received from device [2].
    [  9891.322][Debug]2(QCA9300)<--RxFrame:{RxS:[device=QCA9300, freq=4900, CBW=20, MCS=0, numSTS=1, GI=0.8us, UsrIdx/NUsr=(0/0), timestamp=10614814, NF=-95, RSS=51], ExtraInfo:[len=67, ver=0x134622e, mac_cur[4-6]=12:34:56, mac_rom[4-6]=a6:3b:a8, chansel=5352106, bmode=0, evm[0]=30, txcm=1, rxcm=1, txpower=21, cf=4900.000000MHz, last-tsf=4161578887, flags=9, cf_policy=FastCC, pll=(44, 5, 0)], RxCSI:[(device=QCA9300, format=HT, CBW=20, cf=4900.000000MHz, sf=20.000000MHz, subcarrierBW=312.500000KHz, dim(nTones,nSTS,nESS,nRx)=(56,1,0,1), raw=140B], MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=1, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=38935, txId=0], ExtraInfo:[len=59, ver=0x20191223, mac_cur[4-6]=12:34:56, mac_rom[4-6]=63:20:8b, chansel=5352106, bmode=0, txcm=1, rxcm=1, txpower=20, cf=4900.000000MHz, sf=20.000000MHz, tx-tsf=1586619, last-tsf=20433859, flags=9, tx_ness=0, pll=(44, 5, 0)]}
    [  9907.450][Detail]Packet (450B) received from device [2].
    [  9907.721][Debug]2(QCA9300)<--RxFrame:{RxS:[device=QCA9300, freq=4900, CBW=20, MCS=0, numSTS=1, GI=0.8us, UsrIdx/NUsr=(0/0), timestamp=10630893, NF=-95, RSS=52], ExtraInfo:[len=67, ver=0x134622e, mac_cur[4-6]=12:34:56, mac_rom[4-6]=a6:3b:a8, chansel=5352106, bmode=0, evm[0]=30, txcm=1, rxcm=1, txpower=21, cf=4900.000000MHz, last-tsf=4161578887, flags=9, cf_policy=FastCC, pll=(44, 5, 0)], RxCSI:[(device=QCA9300, format=HT, CBW=20, cf=4900.000000MHz, sf=20.000000MHz, subcarrierBW=312.500000KHz, dim(nTones,nSTS,nESS,nRx)=(56,1,0,1), raw=140B], MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=2, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=57181, txId=0], ExtraInfo:[len=59, ver=0x20191223, mac_cur[4-6]=12:34:56, mac_rom[4-6]=63:20:8b, chansel=5352106, bmode=0, txcm=1, rxcm=1, txpower=20, cf=4900.000000MHz, sf=20.000000MHz, tx-tsf=1592192, last-tsf=20433859, flags=9, tx_ness=0, pll=(44, 5, 0)]}
    [  9916.983][Detail]Packet (450B) received from device [2].
    [  9917.217][Debug]2(QCA9300)<--RxFrame:{RxS:[device=QCA9300, freq=4900, CBW=20, MCS=0, numSTS=1, GI=0.8us, UsrIdx/NUsr=(0/0), timestamp=10640448, NF=-95, RSS=50], ExtraInfo:[len=67, ver=0x134622e, mac_cur[4-6]=12:34:56, mac_rom[4-6]=a6:3b:a8, chansel=5352106, bmode=0, evm[0]=32, txcm=1, rxcm=1, txpower=21, cf=4900.000000MHz, last-tsf=4161578887, flags=9, cf_policy=FastCC, pll=(44, 5, 0)], RxCSI:[(device=QCA9300, format=HT, CBW=20, cf=4900.000000MHz, sf=20.000000MHz, subcarrierBW=312.500000KHz, dim(nTones,nSTS,nESS,nRx)=(56,1,0,1), raw=140B], MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=3, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=30197, txId=0], ExtraInfo:[len=59, ver=0x20191223, mac_cur[4-6]=12:34:56, mac_rom[4-6]=63:20:8b, chansel=5352106, bmode=0, txcm=1, rxcm=1, txpower=20, cf=4900.000000MHz, sf=20.000000MHz, tx-tsf=1597865, last-tsf=1592946, flags=9, tx_ness=0, pll=(44, 5, 0)]}
    [  9933.682][Detail]Packet (450B) received from device [2].
    [  9933.926][Debug]2(QCA9300)<--RxFrame:{RxS:[device=QCA9300, freq=4900, CBW=20, MCS=0, numSTS=1, GI=0.8us, UsrIdx/NUsr=(0/0), timestamp=10657570, NF=-95, RSS=51], ExtraInfo:[len=67, ver=0x134622e, mac_cur[4-6]=12:34:56, mac_rom[4-6]=a6:3b:a8, chansel=5352106, bmode=0, evm[0]=31, txcm=1, rxcm=1, txpower=21, cf=4900.000000MHz, last-tsf=4161578887, flags=9, cf_policy=FastCC, pll=(44, 5, 0)], RxCSI:[(device=QCA9300, format=HT, CBW=20, cf=4900.000000MHz, sf=20.000000MHz, subcarrierBW=312.500000KHz, dim(nTones,nSTS,nESS,nRx)=(56,1,0,1), raw=140B], MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=4, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=39267, txId=0], ExtraInfo:[len=59, ver=0x20191223, mac_cur[4-6]=12:34:56, mac_rom[4-6]=63:20:8b, chansel=5352106, bmode=0, txcm=1, rxcm=1, txpower=20, cf=4900.000000MHz, sf=20.000000MHz, tx-tsf=1603424, last-tsf=1592946, flags=9, tx_ness=0, pll=(44, 5, 0)]}
    ^C
    csi@csi-X201:~$ 

发送端：

.. code-block:: text

    csi@csi-X201:~$ cat ./tx.sh
    #!/bin/bash

    set -e

    array_prepare_for_picoscenes all "5200 HT20"

    phyID=2

    PicoScenes -d debug -i ${phyID} --mode injector --freq 4900e6 --rate 20e6 --delay 5e3 --repeat 5 --txcm 1 --rxcm 1 --mcs 0 --sts 1 --cbw 20
    csi@csi-X201:~$ ./tx.sh
    Change CPU frequency governor to performance ...
    [sudo] password for csi:  
    CPU frequency governor has been set to performance for 4 core(s).
    Un-managing NICs from Network-Manager ...
    Disabling power management...
    Disconnecting Wi-Fi...
    Stopping monitor interfaces...
    Changing MAC address...
    Skip setting the mac address (00:16:ea:12:34:56) for Intel 5300 NIC (wlp2s0)...
    Adding monitor interfaces...
    Adding a monitor interface for phy0 (phy0), named phy0mon ...
    Adding a monitor interface for phy1 (phy1), named phy1mon ...
    Changing working frequency to 5200 HT20 ...
    Preperation is done.
    ----------------------
    Device Status of Wi-Fi NIC array "all":
    PhyPath DEV PHY [MON] DEV_MacAddr [MON_MacAddr] [CF] [BW] ProductName
    2 wlp3s0 phy1 phy1mon 00:16:ea:12:34:56 00:0e:8e:63:20:8b 5200 20 AR93xx Wireless Network Adapter 
    4 wlp2s0 phy0 phy0mon 00:21:6a:14:d6:88 00:21:6a:14:d6:88 5200 20 Ultimate N WiFi Link 5300 
    ----------------------
    [     0.003][Info]loading PicoScenes Platform...        
    [   273.938][Info]PicoScenes Platform version: 2021.0308.1534
    [   292.305][Info]PicoScenes Driver version: 20210222
    [   292.410][Debug]Try escalating PicoScenes's priority...
    [   292.457][Debug]Priority escalation succeeded!      
    [   293.975][Info]2 plugins are found...                    
    [   332.340][Warning]PicoScenes on SDR is not activated on this machine, because its CPU doesn't support AVX instruction set.
    [   504.666][Info]2 compatible Wi-Fi COTS NICs are found...
    [   683.502][Info]Command Execution Service started.  
    [   683.639][Detail]Execute command: "-d debug -i 2 --mode injector --freq 4900e6 --rate 20e6 --delay 5e3 --repeat 5 --txcm 1 --rxcm 1 --mcs 0 --sts 1 --cbw 20"
    [   763.708][Trace]2(phy1) tunes baseband sampling rate (sf) to 20000000.0Hz in HT20 mode.
    [   765.620][Trace]2 tunes passband carrier frequency (cf) to 4900000000Hz with policy FastCC
    [   765.968][Info][2(phy1), mac=63:20:8b]: cf=4900.0000MHz, sf=20.0000MHz, mode=HT20, txcm = 1, rxcm = 1, txpower = 20, tx_ness = 0
    [   766.021][Detail]Device [2] calls 2 plugins to handle the command: -d debug --mode injector --freq 4900e6 --rate 20e6 --delay 5e3 --repeat 5 --txcm 1 --rxcm 1 --mcs 0 --sts 1 --cbw 20
    [   792.307][Info]EchoProbe job parameters: sf--> 20.0 : 0.0 : 20.0MHz, cf--> 4900.0 : 0.0 : 4900.0MHz, 0.005K repeats with 5000us interval 0s delayed start.
    [   793.136][Debug]2(QCA9300)-->TxFrame:{MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=0, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=44469, txId=0], tx_param[type=HT, CBW=20, MCS=0, numSTS=1, numESS=0, coding=BCC, GI=0.8us, sounding(11n) =1], Segments:(ExtraInfo:77B)}
    [   798.866][Debug]2(QCA9300)-->TxFrame:{MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=1, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=38935, txId=0], tx_param[type=HT, CBW=20, MCS=0, numSTS=1, numESS=0, coding=BCC, GI=0.8us, sounding(11n) =1], Segments:(ExtraInfo:77B)}
    [   804.617][Debug]2(QCA9300)-->TxFrame:{MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=2, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=57181, txId=0], tx_param[type=HT, CBW=20, MCS=0, numSTS=1, numESS=0, coding=BCC, GI=0.8us, sounding(11n) =1], Segments:(ExtraInfo:77B)}
    [   810.084][Debug]2(QCA9300)-->TxFrame:{MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=3, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=30197, txId=0], tx_param[type=HT, CBW=20, MCS=0, numSTS=1, numESS=0, coding=BCC, GI=0.8us, sounding(11n) =1], Segments:(ExtraInfo:77B)}
    [   815.718][Debug]2(QCA9300)-->TxFrame:{MACHeader:[dest[4-6]=12:34:56, src[4-6]=63:20:8b, seq=4, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=39267, txId=0], tx_param[type=HT, CBW=20, MCS=0, numSTS=1, numESS=0, coding=BCC, GI=0.8us, sounding(11n) =1], Segments:(ExtraInfo:77B)}
    [   820.850][Info]EchoProbe injector 2 @ cf=4900.000MHz, sf=20.000MHz, #.tx=5.
    [   821.066][Detail]Stopping Tx service for NIC 2...  
    [   831.274][Debug]Baseband DSP library is prefeteched successfully!
    [   921.259][Detail]Stopping FrontEnd Tx for NIC 2...
    ^C
    csi@csi-X201:~$ 

两台电脑扫频模式收发(initiator-responder，固定带宽，中心频率变化)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

当顺利完成两台电脑单收单发模式后，用户可以进一步测试两台电脑扫频模式收发用例。和单接收单发送模式相同的是，在实验完成后，会在接收端脚本目录发现一个后缀为 `.csi` 的文件，和单收发模式相同，用户可以通过 `matlab` 解析数据来进行后续数据分析

扫频模式的接收端 `shell` 脚本代码如下：

.. code-block:: bash

    #!/bin/bash
        
    set -e

    # array_prepare_for_picoscenes 参数详情见上一节

    array_prepare_for_picoscenes all "5200 HT20"

    phyID=2

    # --mode responder 指定网卡的工作模式为 responder，即
    # --freq 4900e6 指定网卡扫频接收时的初始中心频率，若扫频中心频率变化，则网卡的实际中心频率会进行变化，变化取决于扫频发送端中设置的扫频中心频点
    
    PicoScenes -d debug -i ${phyID} --mode responder --freq 4900e6 --rate 20e6 --txcm 1 --rxcm 1
    # end

扫频模式发送端的 `shell` 脚本代码如下:

.. code-block:: bash

    #!/bin/bash

    set -e

    array_prepare_for_picoscenes all "5200 HT20"

    phyID=2

    # 
    # --mode initiator 指定网卡的工作模式为initiator,即扫频模式(发送模式)
    # --repeat 100 表示在每一个规定的频点预计成功发送的包的个数，在本例中为100。当发送端发送的包到达接收端，接收端并返回给发送端，此时计数为1，即一个完整的循环称为一个计数。
    # --cf 4900e6:5e6:5000e6 表示发送端初始频点为4900e6Hz，在4900e6Hz成功发送100个包之后，中心频率将跳转至4905e6Hz，再次发送100个包。最终在5000e6Hz成功发送100个包以后测试完成
    # 即在理想情况下整个测试过程共发送2100个包
    # 注意在此处--freq和--cf的初始中心频率可以不同，但是接收端和发送端的--freq参数值必须一致

    PicoScenes -d trace -i ${phyID} --mode initiator --freq 4900e6 --rate 20e6 --cf 4900e6:5e6:5000e6 --delay 5e3 --repeat 100 --txcm 1 --rxcm 1 --mcs 0 --sts 1 --cbw 20
    #end

实验过程和两台电脑单手单发模式相同，可参考前一个测试用例代码，在此处不再赘述。

需要注意的是，在扫频模式收发结束后，在发送端和接收端均会生成一个后缀为 `.csi` 的文件，在接收端的文件前缀为 `EPR` ，在发送端的文件前缀为 `EPI` , 用户可根据前缀进行区分

接收端生成文件为：

.. code-block:: text

    csi@csi-X201:~$ ll *.csi
    -rw-rw-r-- 1 csi csi 43130 Dec 31 00:13 EPR_53400_191231_001324.csi
    csi@csi-X201:~$ 

发送端生成文件为：

.. code-block:: text

    csi@csi-X201:~$ ll *.csi
    -rw-rw-r-- 1 csi csi 72660 12月 31 08:13 EPI_53400_2_bb20.0M_191231_081321.csi
    csi@csi-X201:~$

实验的完整显示内容如下：

**注意！在本例中为了显示方便，将发送端的发送个数--repeat设置为10，并将发送端和接收端显示级别--debug调整为trace，可以更清晰地看见整个实验过程，用户实际操作时可根据需求更改**

接收端：

.. code-block:: text

    csi@csi-X201:~$ cat ./rx.sh 
    #!/bin/bash
        
    set -e

    array_prepare_for_picoscenes all "5200 HT20"

    phyID=2

    PicoScenes -d trace -i ${phyID} --mode responder --freq 4900e6 --rate 20e6 --txcm 1 --rxcm 1
    csi@csi-X201:~$ ./rx.sh 
    Change CPU frequency governor to performance ...
    CPU frequency governor has been set to performance for 4 core(s).
    Un-managing NICs from Network-Manager ...
    Disabling power management...
    Disconnecting Wi-Fi...
    Stopping monitor interfaces...
    Changing MAC address...
    Skip setting the mac address (00:16:ea:12:34:56) for Intel 5300 NIC (wlp2s0)...
    Adding monitor interfaces...
    Adding a monitor interface for phy0 (phy0), named phy0mon ...
    Adding a monitor interface for phy1 (phy1), named phy1mon ...
    Changing working frequency to 5200 HT20 ...
    Preperation is done.
    ----------------------
    Device Status of Wi-Fi NIC array "all":
    PhyPath DEV PHY [MON] DEV_MacAddr [MON_MacAddr] [CF] [BW] ProductName
    2 wlp3s0 phy1 phy1mon 00:16:ea:12:34:56 10:9a:dd:a6:3b:a8 5200 20 AR93xx Wireless Network Adapter 
    4 wlp2s0 phy0 phy0mon 00:21:6a:b2:36:06 00:21:6a:b2:36:06 5200 20 Ultimate N WiFi Link 5300 
    ----------------------
    [     0.001][Info]loading PicoScenes Platform...        
    [   256.690][Info]PicoScenes Platform version: 2021.0308.1534
    [   270.305][Info]PicoScenes Driver version: 20210222
    [   271.074][Info]2 plugins are found...                    
    [   296.075][Warning]PicoScenes on SDR is not activated on this machine, because its CPU doesn't support AVX instruction set.
    [   478.681][Info]2 compatible Wi-Fi COTS NICs are found...
    [   635.218][Info]Command Execution Service started.  
    [   718.042][Trace]2(phy1) tunes baseband sampling rate (sf) to 20000000.0Hz in HT20 mode.
    [   719.954][Trace]2 tunes passband carrier frequency (cf) to 4900000000Hz with policy FastCC
    [   720.206][Info][2(phy1), mac=a6:3b:a8]: cf=4900.0000MHz, sf=20.0000MHz, mode=HT20, txcm = 1, rxcm = 1, txpower = 21, tx_ness = 0
    [  4552.168][Info]EchoProbe responder shifting 2's CF to 4940.0MHz...
    [  4554.017][Trace]2 tunes passband carrier frequency (cf) to 4940000000Hz with policy FastCC
    [  5649.389][Info]EchoProbe responder shifting 2's CF to 4950.0MHz...
    [  5651.213][Trace]2 tunes passband carrier frequency (cf) to 4950000000Hz with policy FastCC
    [  6704.069][Info]EchoProbe responder shifting 2's CF to 4960.0MHz...
    [  6705.940][Trace]2 tunes passband carrier frequency (cf) to 4960000000Hz with policy FastCC
    [  7757.365][Info]EchoProbe responder shifting 2's CF to 4970.0MHz...
    [  7759.144][Trace]2 tunes passband carrier frequency (cf) to 4970000000Hz with policy FastCC
    [  9821.402][Info]EchoProbe responder shifting 2's CF to 4980.0MHz...
    [  9823.167][Trace]2 tunes passband carrier frequency (cf) to 4980000000Hz with policy FastCC
    [ 10977.271][Info]EchoProbe responder shifting 2's CF to 4990.0MHz...
    [ 10979.091][Trace]2 tunes passband carrier frequency (cf) to 4990000000Hz with policy FastCC
    [ 12158.368][Info]EchoProbe responder shifting 2's CF to 5000.0MHz...
    [ 12160.217][Trace]2 tunes passband carrier frequency (cf) to 5000000000Hz with policy FastCC
    ^C
    csi@csi-X201:~$

发送端：

.. code-block:: text

    csi@csi-X201:~$ cat ./tx.sh 
    #!/bin/bash

    set -e

    array_prepare_for_picoscenes all "5200 HT20"

    phyID=2

    PicoScenes -d trace -i ${phyID} --mode initiator --freq 4900e6 --rate 20e6 --cf 4940e6:10e6:5000e6 --delay 5e3 --repeat 10 --txcm 1 --rxcm 1 --mcs 0 --sts 1 --cbw 20
    csi@csi-X201:~$ ./tx.sh 
    Change CPU frequency governor to performance ...
    CPU frequency governor has been set to performance for 4 core(s).
    Un-managing NICs from Network-Manager ...
    Disabling power management...
    Disconnecting Wi-Fi...
    Stopping monitor interfaces...
    Changing MAC address...
    Skip setting the mac address (00:16:ea:12:34:56) for Intel 5300 NIC (wlp2s0)...
    Adding monitor interfaces...
    Adding a monitor interface for phy0 (phy0), named phy0mon ...
    Adding a monitor interface for phy1 (phy1), named phy1mon ...
    Changing working frequency to 5200 HT20 ...
    Preperation is done.
    ----------------------
    Device Status of Wi-Fi NIC array "all":
    PhyPath DEV PHY [MON] DEV_MacAddr [MON_MacAddr] [CF] [BW] ProductName
    2 wlp3s0 phy1 phy1mon 00:16:ea:12:34:56 00:0e:8e:63:20:8b 5200 20 AR93xx Wireless Network Adapter 
    4 wlp2s0 phy0 phy0mon 00:21:6a:14:d6:88 00:21:6a:14:d6:88 5200 20 Ultimate N WiFi Link 5300 
    ----------------------
    [     0.002][Info]loading PicoScenes Platform...        
    [   166.952][Info]PicoScenes Platform version: 2021.0308.1534
    [   176.155][Info]PicoScenes Driver version: 20210222
    [   176.566][Info]2 plugins are found...                    
    [   203.902][Warning]PicoScenes on SDR is not activated on this machine, because its CPU doesn't support AVX instruction set.
    [   425.015][Info]2 compatible Wi-Fi COTS NICs are found...
    [   576.996][Info]Command Execution Service started.  
    [   656.339][Trace]2(phy1) tunes baseband sampling rate (sf) to 20000000.0Hz in HT20 mode.
    [   658.225][Trace]2 tunes passband carrier frequency (cf) to 4900000000Hz with policy FastCC
    [   658.532][Info][2(phy1), mac=63:20:8b]: cf=4900.0000MHz, sf=20.0000MHz, mode=HT20, txcm = 1, rxcm = 1, txpower = 20, tx_ness = 0
    [   680.445][Info]EchoProbe job parameters: sf--> 20.0 : 0.0 : 20.0MHz, cf--> 4940.0 : 10.0 : 5000.0MHz, 0.01K repeats with 5000us interval 0s delayed start.
    [   680.554][Info]EchoProbe initiator shifting 2's carrier frequency to 4940.0MHz...
    [  1692.729][Trace]2 tunes passband carrier frequency (cf) to 4940000000Hz with policy FastCC
    [  1700.914][Info]EchoProbe responder confirms the channel changes.
    [  1702.644][Trace]2 tunes passband carrier frequency (cf) to 4940000000Hz with policy FastCC
    *.
    [  1778.561][Info]EchoProbe initiator 2 @ cf=4940.000MHz, sf=20.000MHz, #.tx=10, #.acked=10, echo_delay=2.8ms, success_rate=100.0%.
    [  1778.663][Info]EchoProbe initiator shifting 2's carrier frequency to 4950.0MHz...
    [  2790.666][Trace]2 tunes passband carrier frequency (cf) to 4950000000Hz with policy FastCC
    [  2798.679][Info]EchoProbe responder confirms the channel changes.
    [  2800.397][Trace]2 tunes passband carrier frequency (cf) to 4950000000Hz with policy FastCC
    *.
    [  2833.119][Info]EchoProbe initiator 2 @ cf=4950.000MHz, sf=20.000MHz, #.tx=10, #.acked=10, echo_delay=2.6ms, success_rate=100.0%.
    [  2833.195][Info]EchoProbe initiator shifting 2's carrier frequency to 4960.0MHz...
    [  3845.206][Trace]2 tunes passband carrier frequency (cf) to 4960000000Hz with policy FastCC
    [  3853.040][Info]EchoProbe responder confirms the channel changes.
    [  3854.755][Trace]2 tunes passband carrier frequency (cf) to 4960000000Hz with policy FastCC
    *.
    [  3886.725][Info]EchoProbe initiator 2 @ cf=4960.000MHz, sf=20.000MHz, #.tx=10, #.acked=10, echo_delay=2.5ms, success_rate=100.0%.
    [  3886.797][Info]EchoProbe initiator shifting 2's carrier frequency to 4970.0MHz...
    [  4898.764][Trace]2 tunes passband carrier frequency (cf) to 4970000000Hz with policy FastCC
    [  4906.575][Info]EchoProbe responder confirms the channel changes.
    [  4908.383][Trace]2 tunes passband carrier frequency (cf) to 4970000000Hz with policy FastCC
    *.
    [  5950.773][Info]EchoProbe initiator 2 @ cf=4970.000MHz, sf=20.000MHz, #.tx=11, #.acked=10, echo_delay=2.5ms, success_rate=90.9%.
    [  5950.856][Info]EchoProbe initiator shifting 2's carrier frequency to 4980.0MHz...
    [  6962.818][Trace]2 tunes passband carrier frequency (cf) to 4980000000Hz with policy FastCC
    [  6970.810][Info]EchoProbe responder confirms the channel changes.
    [  6972.562][Trace]2 tunes passband carrier frequency (cf) to 4980000000Hz with policy FastCC
    *.
    [  7098.942][Info]EchoProbe initiator 2 @ cf=4980.000MHz, sf=20.000MHz, #.tx=10, #.acked=10, echo_delay=11.9ms, success_rate=100.0%.
    [  7099.007][Info]EchoProbe initiator shifting 2's carrier frequency to 4990.0MHz...
    [  8111.054][Trace]2 tunes passband carrier frequency (cf) to 4990000000Hz with policy FastCC
    [  8117.864][Info]EchoProbe responder confirms the channel changes.
    [  8119.621][Trace]2 tunes passband carrier frequency (cf) to 4990000000Hz with policy FastCC
    *.
    [  8272.103][Info]EchoProbe initiator 2 @ cf=4990.000MHz, sf=20.000MHz, #.tx=10, #.acked=10, echo_delay=14.5ms, success_rate=100.0%.
    [  8272.197][Info]EchoProbe initiator shifting 2's carrier frequency to 5000.0MHz...
    [  9284.205][Trace]2 tunes passband carrier frequency (cf) to 5000000000Hz with policy FastCC
    [  9291.848][Info]EchoProbe responder confirms the channel changes.
    [  9293.700][Trace]2 tunes passband carrier frequency (cf) to 5000000000Hz with policy FastCC
    *.
    [ 10440.839][Info]EchoProbe initiator 2 @ cf=5000.000MHz, sf=20.000MHz, #.tx=11, #.acked=10, echo_delay=13.0ms, success_rate=90.9%.
    [ 10440.955][Trace]Job done! #.total_tx=72 #.total_acked=70, echo_delay=7.1ms, success_rate =97.2%.
    ^C
    csi@csi-X201:~$