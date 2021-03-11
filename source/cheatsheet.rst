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

本个用例代码的作用在于将一台电脑设置为发送端，将另一台电脑设置为接收端进行一次测试。在测试完成后，用户将在接收端 `shell(.sh)` 脚本所在目录发现一个后缀为 `.csi` 的文件。在后续操作中，用户可以通过 `matlab` 解析 `.csi` 文件来得到本次测试的具体数据，从而进行后续的数据分析以及实验改进。

发送端的 `shell` 脚本代码如下：

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

.. TODO:添加array_status和array_prepare_for_picoscenes运行图

接收端的 `shell` 脚本代码如下:

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

用户可以分别粘贴发送端脚本代码和接收端脚本代码到发送端电脑和接收端电脑，然后运行两个脚本来进行实验，实验过程如下：

1. 修改发送端脚本名称为 `tx.sh` ,并使用 `chmod +x tx.sh` 赋予可执行权限；修改接收端脚本名称为 `rx.sh` ，并赋予可执行权限；

2. 进入 `rx.sh` 所在目录，并在当前目录打开终端，在终端运行 `./rx.sh`，显示类似如下信息则表示接收端成功打开；

.. TODO: 添加接收端成功运行代码

3. 进入 `tx.sh` 所在目录，并在当前目录打开终端，在终端运行 `./tx.sh`，显示类似如下信息则表示发送端成功打开；

.. TODO: 添加发收端成功运行代码

4. 当发送端发送完成的时候即表示实验结束，可以按 `Ctrl + C` 来关闭 `PicoScenes` 的发送端和接收端。

实验测试完成后，在接收端脚本目录可以看见一个后缀为 `.csi` 的文件，则表示实验成功。

.. TODO: 添加csi文件截图或者ls结果