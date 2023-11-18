CSI Measurement using PicoScenes
=================================================

**Revised on Nov. 16, 2023**

On this page, we provide a list of commonly used Wi-Fi ISAC research scenarios and how they can be achieved using PicoScenes.
Before we proceed, it is assumed that you have already installed the PicoScenes software and the supported hardware. Not sure if you have done that? Please refer to the installation guide :doc:`installation` for more information.

Before Getting Started: Some Fundamentals
--------------------------------------------

Here we introduce two fundamentals:  Wi-Fi channelization and device naming protocol.

Basic Facts of Wi-Fi Channelization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Many PicoScenes users are confused about how to correctly specify Wi-Fi channels for COTS NICs and SDR devices. We create a big table :doc:`/channels` for reference.

.. _device_naming:

Device Naming
~~~~~~~~~~~~~~~~~

In PicoScenes, a reliable and user-friendly device naming protocol is necessary to support the concurrent operation of multiple Wi-Fi NICs and SDR devices. In the following sections, we will introduce the naming protocols for commercial Wi-Fi NICs, SDR devices, and Virtual SDR devices.

.. _naming_for_nics:

Device Naming for Commercial Wi-Fi NICs
+++++++++++++++++++++++++++++++++++++++++

Open a terminal and run the command ``array_status``. A list of all the PCI-E based Wi-Fi NICs will be displayed in the terminal. The sample device list below shows an example of the output:

.. figure:: /images/array_status.png
   :figwidth: 600px
   :target: /images/array_status.png
   :align: center

   Each Wi-Fi NIC has `four` IDs.

In the array_status output, there are four IDs provided for each NIC: *PhyPath*, *PhyId*, *DevId*, and *MonId*. Let's first explain the latter three IDs, followed by *PhyPath*.

- **PhyId**: This is the *Physical ID* assigned by the Linux mac80211 module at the system level, primarily used for low-level hardware control. *It may change upon each reboot*.
- **DevId**: This is the *Device ID* assigned by the Linux mac80211 module at the system level, mainly used for normal Wi-Fi connections. *It may change upon each reboot*.
- **MonId**: This is the *Monitor interface ID* for a Wi-Fi NIC, primarily used for traffic monitoring and packet injection. *Users can change this ID at any time*.
- **PhyPath (Recommended)**: To address the issue of inconsistent system-assigned IDs across reboots, we introduce a new ID called *PhyPath*, listed in the first column of the ``array_status`` output. The main advantage of PhyPath is that **it remains consistent across reboots and even system reinstallations as it is bound to the PCI-E connection hierarchy**. For example, a Wi-Fi NIC with PhyPath ``3`` indicates it is the third device in the PCI-E hierarchy, while a Wi-Fi NIC with PhyPath ``53`` indicates it is the 3rd leaf node of the 5th branch node in the PCI-E hierarchy. *PhyPath* is supported throughout the PicoScenes system, including the PicoScenes program, plugins, and bash scripts. **We highly recommend using PhyPath in all scenarios**.

.. _naming_for_usrp:

Device Naming for NI USRP
+++++++++++++++++++++++++++++++++

We devise a simple and scalable naming protocol for USRP devices. It has four forms:

- ``usrp``: Used in case of only one USRP device connected to computer. For example, only one USRP device is connected to computer, you can select this device with simply ``usrp``.
- ``usrp<IPADDRESS_or_RESOURCEID_or_SERIALID_or_DEVICENAME>``: Used in case of selecting one of multiple connected USRP devices. For example, in order to select a USRP X310 device (ip-addr=192.168.40.2, serial=DID1234, name=myX310, resourceId=RID4567) from multiple USRP devices connected, this device can be represented by any one of the four possible IDs: ``usrp192.168.40.2``, ``usrpDID1234``, ``usrpmyX310`` or ``usrpRID4567``.
-  ``usrp<IPADDRESS_or_RESOURCEID_or_SERIALID_or_DEVICENAME>,[multiple <IPADDRESS_or_RESOURCEID_or_SERIALID_or_DEVICENAME>]``: Used in case of combining multiple USRPs devices. For example, the combination of two USRP X310 devices (with IP addresses of 192.168.40.2 and 192.168.41.2) can be represented by ``usrp192.168.40.2,192.168.41.2``.
-  ``usrp<IPADDRESS0_IPADDRESS1>,[multiple <IPADDRESS0_IPADDRESS1>]``: Used in case of combining the two 10GbE connections of one or multiple USRP X310 devices. Assume you have two USRP X310 devices connected. The first USRP X310 device has two 10GbE connections with IP addresses of 192.168.30.2 and 192.168.40.2, and the second USRP X310 device has two 10GbE connections with IP addresses of 192.168.70.2 and 192.168.80.2. The combination of the two channels of the first X310 can be represented by ``usrp192.168.30.2_192.168.40.2``. The combination of the all four channels can be represented by ``usrp192.168.30.2_192.168.40.2,192.168.70.2_192.168.80.2``. The combination of the first two and the last one can be represented by ``usrp192.168.30.2_192.168.40.2,192.168.80.2``.

.. important:: The order of the IP addresses affects the order of the TX/RX channels! For example, the 0th and 3rd channels of the combined USRP ``usrp192.168.40.2,192.168.41.2`` refer to the first and the the second channel of the devices with the IP addresses of 192.168.40.2 and 192.168.41.2, respectively.

Device Naming for HackRF One
+++++++++++++++++++++++++++++++++++++++

All HackRF One devices are named as ``hackrf<Device_Number>``, *e.g.*, ``hackrf0`` or ``hackrf1``. The starting device number is ``0``, and the device number with is the same order as the command ``SoapySDRUtil --find="driver=hackrf"`` lists.

Device Naming for Virtual SDR
++++++++++++++++++++++++++++++++++++++++

The Virtual SDR device adopts the naming pattern of ``virtualsdr<ANY_GIVEN_ID>``, *e.g.*, ``virtualsdr0``, ``virtualsdr_astringId`` or the simplest ``virtualsdr``.

.. _ax200-measurements:

CSI Measurement using AX200/AX210 NICs
-----------------------------------------------------------


.. _ax200-wifi-ap:

AX200/AX210 + Wi-Fi AP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The AX200/AX210 NIC can measure CSI for the 802.11a/g/n/ac/ax frames transmitted by the associated Wi-Fi AP. By generating sufficient Wi-Fi traffic, such as using the *ping* command, we can obtain CSI measurements.

To measure CSI from the AX200/AX210, follow these three steps:

#. Determine the NIC's PhyPath ID by running the ``array_status`` command in a terminal. For device naming conventions for commercial NICs, please refer to the :ref:`naming_for_nics` section.
#. Assuming the PhyPath ID is ``3``, execute the following command:

    .. code-block:: bash
    
        PicoScenes "-d debug -i 3 --mode logger --plot"

    The aforementioned command consists of four program options: *"-d debug -i 3 --mode logger --plot"*. These options can be interpreted as follows:

      - ``-d debug``: Modifies the display level of the logging service to debug;
      - ``-i 3 --mode logger``: Switches the device <3> to CSI logger mode;
      - ``--plot``: Live-plots the CSI measurements.

    For more detailed explanations, please see the :doc:`parameters` section.

#. Once you have collected sufficient CSI data, exit PicoScenes by pressing Ctrl+C. 

The logged CSI data is stored in a file named ``rx_<PHYPath>_<Time>.csi``, located in the *present working directory*. To analyze the data, open MATLAB and drag the .csi file into the *Command Window*. The file will be parsed and stored as a MATLAB variable named *rx_<PHYPath>_<Time>*.

.. _ax200-monitor:

Single AX200/AX210 in Monitor Mode (Fully-Passive CSI Measurement Mode)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The AX200/AX210 NIC is capable of measuring CSI for the 802.11a/g/n/ac/ax frames observed in monitor mode. In this mode, the AX200/AX210 can passively measure CSI for all frames transmitted on the same channel, enabling association-free and injection-free fully passive CSI measurement.

To enable fully-passive CSI measurement, follow these three steps:

#. Determine the PhyPath ID of the NIC by running the ``array_status`` command in a terminal. Let's assume the PhyPath ID is ``3``.
#. Put the NIC into monitor mode by executing the command ``array_prepare_for_picoscenes 3 <CHANNEL_CONFIG>``. Replace *<CHANNEL_CONFIG>* with the desired channel configuration, which should be specified in the same format as the *freq* setting of the Linux *iw set freq* command. For example, it could be "2412 HT20", "5200 HT40-", "5745 80 5775", and so on.
#. Run the command:

    .. code-block:: bash
    
        PicoScenes "-d debug -i 3 --mode logger --plot"

#. Once you have collected sufficient CSI data, exit PicoScenes by pressing Ctrl+C.

The above command has four program options *"-d debug -i 3 --mode logger --plot"*. These options have the same behavior as described in the :ref:`ax200-wifi-ap` Section.

The logged CSI data is stored in a file named ``rx_<Id>_<Time>.csi``, located in the *present working directory*. To analyze the data, open MATLAB and drag the .csi file into the *Command Window*. The file will be parsed and stored as a MATLAB variable named *rx_<Id>_<Time>*.

.. _ax200-monitor-injection:

Two AX200/AX210 NICs with Monitor Mode + Packet Injection (802.11a/g/n/ac/ax Format + 20/40/80/160 MHz Bandwidth)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The PicoScenes Driver enables AX200/AX210 to *packet-inject* 802.11a/g/n/ac/ax format frames with 20/40/80/160 MHz bandwidth and up to 2x2 MIMO. By combining this capability with the CSI measurement ability shown in the :ref:`ax200-monitor` section, PicoScenes provides fine-grained low-level control for CSI measurement.

To enable this test, you need two computers, each equipped with an AX200/AX210 NIC. Follow these three steps:

#. Determine the PhyPath ID of each NIC by using the ``array_status`` command. Let's assume the PhyPath ID is ``3`` for the first computer and ``4`` for the second.
#. Put both NICs into monitor mode by executing the command ``array_prepare_for_picoscenes <PHYPath ID> <CHANNEL_CONFIG>``. Replace *<CHANNEL_CONFIG>* with the desired channel configuration. In this scenario, we assume the researchers want to measure 160 MHz channel CSI. Run the following commands on the respective computers:

    .. code-block:: bash
        
        array_prepare_for_picoscenes 3 "5640 160 5250" #<-- Run on the first computer 
        array_prepare_for_picoscenes 4 "5640 160 5250" #<-- Run on the second computer
    
    Here, ``5640 160 5250`` represents a 160 MHz bandwidth channel centered at 5250 MHz with the primary channel at 5640 MHz.

#. On the first computer, run the following command in a terminal:

    .. code-block:: bash

        PicoScenes "-d debug -i 3 --mode logger --plot"

#. On the second computer, assuming the researchers want to measure 160 MHz bandwidth 802.11ax format CSI, run the following command in a terminal:

    .. code-block:: bash

        PicoScenes "-d debug -i 4 --mode injector --preset TX_CBW_160_HESU --repeat 1e5 --delay 5e3"
        
    The command options for the second computer, *"-d debug -i 4 --mode injector --preset TX_CBW_160_HESU --repeat 1e5 --delay 5e3"*, have the following interpretations:

    - ``-d debug``: Modifies the display level of the logging service to debug;
    - ``-i 4 --mode injector``: Switches the device <4> to packet injector mode;
    - ``--preset TX_CBW_160_HESU``: Specifies the Tx packet format using a preset named ``TX_CBW_160_HESU``, which means "Tx, channel bandwidth (CBW) 160 MHz, format=HESU (802.11ax single-user)".
    - ``--repeat 1e5``: Transmits (or packet injects) 100,000 packets.
    - ``--delay 5e3``: Sets the inter-packet delay to 5,000 microseconds.

#. Once you have collected sufficient CSI data on the first computer, exit PicoScenes by pressing Ctrl+C.

    The logged CSI data is stored in a file named ``rx_<Id>_<Time>.csi``, located in the *present working directory* of the first computer. To analyze the data, open MATLAB and drag the .csi file into the *Command Window*. The file will be parsed and stored as a MATLAB variable named *rx_<Id>_<Time>*.

.. hint:: You can refer to :doc:`/presets` for full list of presets.

Two AX200/AX210 NICs with Monitor Mode + Packet Injection with MCS and Antenna Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes allows users to specify the MCS value and Tx/Rx antenna selection for AX200/AX210. To demonstrate this, we will modify the commands for the :ref:`ax200-monitor-injection` scenario.

On the first computer, if you want to use only the 1st antenna for Rx, modify the command as follows:

.. code-block:: bash

    PicoScenes "-d debug -i 3 --mode logger --rxcm 1 --plot"

The additional ``--rxcm 1`` option sets the Rx chainmask to 1, indicating the use of the 1st antenna for Rx. The ``--rxcm`` option allows you to specify the antenna selection using a bit-wise style: 1 for the 1st antenna, 2 for the 2nd antenna, 3 for the first 2 antennas, 4 for the 3rd antenna, 5 for the 1st and 3rd antennas, and so on. 

On the second computer, if you want to use only the 2nd antenna for Tx and specify the MCS value as 5, modify the command as follows:

.. code-block:: bash

    PicoScenes "-d debug -i 4 --mode injector --preset TX_CBW_160_HESU --repeat 1e5 --delay 5e3 --txcm 2 --mcs 5"

The additional ``--txcm 2`` option sets the Tx chainmask to 2, indicating the use of the 2nd antenna for Tx. The ``--txcm`` option has the same value style as `--rxcm`, but for transmission. The `--mcs 5` option sets the Tx MCS to 5.

If you want to measure the largest CSI with 160 MHz bandwidth and 2x2 MIMO, further modifications are required. On the first computer, to receive 2x2 MIMO frames, you need to use 2 antennas for Rx. You can explicitly set ``--rxcm 3`` as shown below or just remove the `--rxcm` option, which defaults to using ``--rxcm 3``:

.. code-block:: bash

    PicoScenes "-d debug -i 3 --mode logger --rxcm 3 --plot"

On the second computer, to transmit 2x2 MIMO frames, you also need to use 2 antennas for Tx. You can explicitly set ``--txcm 3``` as shown below or just remove the ``--txcm`` option, which defaults to using ``--txcm 3``:

.. code-block:: bash

    PicoScenes "-d debug -i 4 --mode injector --preset TX_CBW_160_HESU --repeat 1e5 --delay 5e3 --mcs 5 --sts 2"

The additional ``--sts 2`` option sets the number of Space-Time Stream (:math:`N_{STS}=2`) to 2, indicating to use two antennas to transmit 2x2 MIMO frames.

.. _csi_by_sdr:
CSI Measurement using NI USRP or HackRF One SDR
--------------------------------------------------

PicoScenes can drive SDR devices to transmit 802.11a/g/n/ac/ax/be format frames, receive frames, and measure the CSI data in real-time. The usage is similar to that of COTS NICs, simplifying the adoption of SDR devices in Wi-Fi ISAC research.


.. _sdr_rx:

Listening to Wi-Fi Traffic and measuring CSI for 802.11a/g/n/ac/ax/be protocol frames
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Listening to a 20 MHz bandwidth channel
+++++++++++++++++++++++++++++++++++++++++++

In the simplest form, if you want to listen to the Wi-Fi traffic of a 20 MHz bandwidth channel centered at 2412 MHz using an SDR device with the ID ``SDR_ID``, you can use the following command:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --mode logger --freq 2412 --plot"

The command options, *"-d debug -i SDR_ID --freq 2412  --mode logger --plot"*, have the following interpretations:

   - ``-d debug``: Modifies the display level of the logging service to debug;
   - ``-i SDR_ID --mode logger``: Switches the device ``SDR_ID`` to CSI logger mode;
   - ``--freq 2412``: Change the center frequency of device ``SDR_ID`` to 2412 MHz;
   - ``--plot``: Live-plots the CSI measurements.

.. hint:: PicoScenes sets many Rx parameters by default, such as using the *RX_CBW_20* preset, using the Tx/Rx antenna port, using the normalized 0.65 Rx gain, *etc*. 

Listening to 40/80/160 MHz Bandwidth Channels
+++++++++++++++++++++++++++++++++++++++++++++++

In this case, if you want to listen to the Wi-Fi traffic on a 40 MHz bandwidth channel centered at 5190 MHz (or "5180 HT40+" or "5200 HT40-") using an SDR device with the ID `SDR_ID`, you can use the following command:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --mode logger --freq 5190 --preset RX_CBW_40 --plot"

The command options, *"-d debug -i SDR_ID --mode logger --freq 5190 --preset RX_CBW_40 --plot"*, have the following interpretations:

  - ``-d debug``: Modifies the display level of the logging service to debug;
  - ``-i SDR_ID --mode logger``: Switches the device ``SDR_ID`` to CSI logger mode;
  - ``--freq 2412``: Change the center frequency of device ``SDR_ID`` to 2412 MHz;
  - ``--preset RX_CBW_40``: Uses the Rx preset named `RX_CBW_40`, which boosts the Rx sampling rate to 40 MHz and tells the baseband to treat the received signals as being sampled with a 40 MHz rate.
  - ``--plot``: Live-plots the CSI measurements.

Similarly, if you want to listen to an 80 MHz bandwidth channel centered at 5210 MHz using an SDR device with the ID `SDR_ID`, you can use the following command:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --mode logger --freq 5210 --preset RX_CBW_80 --plot"

Similarly, if you want to listen to a 160 MHz bandwidth channel centered at 5250 MHz using an SDR device with the ID `SDR_ID`, you can use the following command:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --mode logger --freq 5250 --preset RX_CBW_160 --plot"

.. hint:: You can refer to :doc:`/presets` for full list of presets.

.. important:: Not all SDR devices support the 40/80/160 MHz sampling rate. For example, HackRF One with a maximum of 20 MHz sampling rate, does not support 40 MHz or wider sampling rate. Whist the NI USRP X3x0 Series or other advanced models has a maximum of over 200 MHz sampling rate, supporting the 40/80/160 MHz bandwidth channels.

.. _antenna_selection:
Antenna Selection (Only for NI USRP Device)
+++++++++++++++++++++++++++++++++++++++++++++++++

NI USRP features two antenna ports for each RF channel, **TX/RX** and **RX2**. PicoScenes provides a pair of options for Tx/Rx antenna selection: ``--tx-ant`` and ``--rx-ant``. For example, If you want to use RX2 antenna port for signal receiving, you can add ``--rx-ant`` to the above command:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --mode logger --freq 5250 --preset RX_CBW_160 --rx-ant RX2 --plot"

.. important:: **PicoScenes uses the TX/RX port of each RF channel by default**.

.. _rx-gain-control:
Rx Gain Control: Manual GC and AGC
+++++++++++++++++++++++++++++++++++++++++++++++

Proper Rx gain, or Rx signal amplification level, is crucial for Rx decoding performance and CSI measurement quality. Depending on the distance and strength of the transmitted signal, you may need to adjust the Rx gain. PicoScenes provides two ways to specify the Rx gain: using the **absolute gain value** or the **normalized gain value**.


#. Specifying the absolute Rx gain: To set the Rx gain to a specific value, you can use the ``--rx-gain`` option followed by the desired gain value in dBm. For example:

    .. code-block:: bash

        PicoScenes "-d debug -i SDR_ID --mode logger --freq 2412 --plot --rx-gain 20"

    In this command, ``--rx-gain 20`` specifies an Rx gain of 20 dBm.

#. Specifying the normalized Rx gain can be like: To set the Rx gain using a normalized value, you can use the ``--rx-gain`` option followed by the desired normalized gain value. For example:


    .. code-block:: bash

        PicoScenes "-d debug -i SDR_ID --mode logger --freq 2412 --plot --rx-gain 0.7"

    The ``--rx-gain 0.7`` specify a normalized Rx gain value of 0.7, *equivalent to the 0.7 of the hardware-supported maximum Rx gain*. 

    If value specified to ``--rx-gain`` is greater than 1, the value is considered to be the absolute gain; otherwise the normalized gain values.
    
    .. hint:: PicoScenes sets the Rx gain to 0.65 by default.

#. Some SDR devices support automatic gain control (AGC), such as the NI USRP B210. To enable AGC, you can use the ``--agc`` option. For example:

    .. code-block:: bash

        PicoScenes "-d debug -i A_B210_SDR --mode logger --freq 2412 --plot --agc"
    
    This command enables AGC for the SDR device with the ID A_B210_SDR.

.. _multi-channel-rx-single:

Multi-Channel Rx by Single NI USRP Device
++++++++++++++++++++++++++++++++++++++++++++++++++

PicoScenes supports *multi-channel Rx* and even *multi-USRP combined multi-channel Rx*. For example, the NI USRP B210, X310 and other advanced models have two or more independent RF channels. PicoScenes supports receiving dual/multi-channel signals and decoding MIMO frames.

#. Single USRP Device - Dual/Multi-Channel Rx. 

    For example, if you want to use an X310 or other multi-channel USRP devices to listen to Wi-Fi traffic on the 40 MHz channel centered at 5190 MHz (the *5180 HT40+* or *5200 HT40-* channel)  with two Rx channels, you can use the following command:


    .. code-block:: bash

        PicoScenes "-d debug -i usrp --mode logger --freq 5190 --preset RX_CBW_40 --rxcm 3 --plot"
    
    In this command, ``--rxcm 3 ``specifies the *Rx chainmask* value of 3, indicating the use of the 1st and 2nd Rx antennas for Rx. The ``--rxcm`` option allows you to specify the antenna selection using a bitwise style: 1 for the 1st antenna, 2 for the 2nd antenna, 3 for the first 2 antennas, 4 for the 3rd antenna, 5 for the 1st and 3rd antennas, and so on.

    If you want to use an X310 or other multi-channel USRP devices to listen to Wi-Fi traffic on the 80 MHz channel centered at 5210 MHz with two Rx channels, you can use the following command:

    .. code-block:: bash

        PicoScenes "-d debug -i usrp --mode logger --freq 5210 --preset RX_CBW_80 --rxcm 3 --plot"

#. Single USRP Device - Dual/Multi-Channel Rx with Dual 10GbE connections. 

    The previous option cannot support the dual-channel signal receiving and decoding for a 160 MHz channel, because the dual-channel 160 MHz-rate signal receiving requires up to 12.8Gbps Ethernet bandwidth which exceeds the limit of a single 10GbE connection. Therefore, you have to use the dual 10GbE connection to satisfy this bandwidth. Assuming the dual-10GbE connection is correctly set up with IP address of 192.168.30.2 and 192.168.40.2, you can use the following command to perform dual-channel receiving for a 160 MHz bandwidth channel centered at 5250 MHz:

    .. code-block:: bash

        PicoScenes "-d debug -i usrp192.168.30.2_192.168.40.2 --mode logger --freq 5250 --preset RX_CBW_160 --rxcm 3 --plot"

    .. hint:: You can follow the guides below to setup dual 10GbE connections for the X3x0 and N3x0 series.

        - X3x0 Series: `Using Dual 10 Gigabit Ethernet on the USRP X300/X310 <https://kb.ettus.com/Using_Dual_10_Gigabit_Ethernet_on_the_USRP_X300/X310>`_
        - N3x0 Series: `USRP N300/N310/N320/N321 Getting Started Guide - Dual 10Gb Streaming <https://kb.ettus.com/USRP_N300/N310/N320/N321_Getting_Started_Guide#Dual_10Gb_Streaming_SFP_Ports_0.2F1>`_

.. _multi-channel-rx-multi:

Multi-Channel Rx by Multiple NI USRP Devices
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

PicoScenes supports to combine multiple NI USRP devices of the same model into a single, virtual devices, providing higher level of MIMO and larger cross-antenna phase coherency. Taking the NI USRP X310 as an example, if you have two X310 devices and each is equipped with dual UBX-160 daughterboard, **we can achieve four-channel phase coherent Rx if they are properly combined and synchronized**.
    
.. _phase_sync_multiple_device:

Clock Synchronization across Multiple USRP Devices
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We recommend two options to achieve clock synchronization across multiple USRP devices:

#. For all device, by a central clock distribution module (**Recommended**). We recommend to the 8-port `OctoClock-G <https://www.ettus.com/all-products/OctoClock-G/>`_ or `OctoClock <https://www.ettus.com/all-products/octoclock/>`_ to distribute clock signals for all NI USRP devices.

#. For NI USRP X3x0 model, By Ref clock export. X3x0 model has *PPS OUT* and *TRIG OUT* ports that can be directly feed into another X3x0 devices, or feed into a clock distribution module.

Combining Multiple USRP devices
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Assume you have two NI USRP X3x0 devices each equipped with two UBX-160 daughterboards, and with IP Addresses of 192.168.30.2 and 192.168.70.2, respectively. And also assume you have physically synchronized these two devices by either solution of :ref:`phase_sync_multiple_device`, you can achieve four-channel coherent Rx by the following command:

.. code-block:: bash

    PicoScenes "-d debug -i usrp192.168.30.2,192.168.70.2 --mode logger --freq 5190 --preset RX_CBW_40 --rx-channel 0,1,2,3 --clock-source external --plot"

In this command, please pay special attention to the comma (**,**) in the option ``-i usrp192.168.30.2,192.168.70.2``. It means to combine multiple USRP devices. You can refer to :ref:`naming_for_usrp` for the complete naming protocols for NI USRP devices. The option ``--rx-channel`` is equivalent to ``--rxcm`` introduced aforementioned, and ``--rx-channel 0,1,2,3`` is equivalent to ``--rxcm 15`` meaning to use all four RF channels for receiving. Then option ``--clock-source external`` tell USRP to use external clock signals for the frequency generations for the LO and ADC/DAC pair.

Combining Multiple USRP Devices plus Dual-Connection
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Assuming you have two NI USRP X3x0 devices each equipped with two UBX-160 daughterboards, and assume each X3x0 device is dual-10GbE connected with IP Addresses of 192.168.30.2 and 192.168.31.2 for the first and 192.168.70.2 and 192.168.71.2 for the second, respectively. And also assume you have physically synchronized these two devices by either solution of :ref:`phase_sync_multiple_device`, you can achieve four-channel coherent Rx for a 160 MHz Wi-Fi channel by the following command:

.. code-block:: bash

    PicoScenes "-d debug -i usrp192.168.30.2_192.168.31.2,192.168.70.2_192.168.71.2 --mode logger --freq 5250 --preset RX_CBW_160 --rx-channel 0,1,2,3 --clock-source external --plot"

Please pay special attention to the comma(**,**) and underline (**_**) in the option ``-i usrp192.168.30.2_192.168.31.2,192.168.70.2_192.168.71.2``. It means to to use the dual 10GbE connection plus combining multiple USRP devices. You can refer to :ref:`naming_for_usrp` for the complete naming protocols for NI USRP devices.

.. _sdr_tx:

Transmit 802.11a/g/n/ac/ax/be protocol frames using SDR Devices
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Single-Device Tx with Rich Low-Level Controls
++++++++++++++++++++++++++++++++++++++++++++++++++++++++

In the following examples, we demonstrate how to use PicoScenes to drive SDR device to transmit Wi-Fi packets with gradually enriched low-level controls. We assume your SDR ID is ``SDR_ID`` and your SDR supports sufficiently high sampling rate, like 200 MSPS or higher.

Transmit 20 MHz bandwidth 802.11n Format Frames
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you just want to transmit some 802.11n rate, 20 MHz bandwidth frames at 5900 MHz channel for CSI measurement, you can use the following command:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --freq 5900 --mode injector --repeat 1e5 --delay 5e3"

The new options ``--mode injector --repeat 1e5 --delay 5e3`` can be interpreted as:

- ``--mode injector``: Ask the SDR to operate at packet injector mode;
- ``--repeat 1e5``: Injector 10000 packets;
- ``--delay 5e3``: The inter-frame delay is 5000 microseconds.

.. hint:: PicoScenes uses 802.11n format for packet injection by default.

Transmit 20/40/80/160 MHz bandwidth 802.11a/g/n/ac/ax Format Frames
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can use the powerful ``--preset`` options to specify bandwidth and format, like:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --freq 5900 --mode injector --preset TX_CBW_160_EHTSU --repeat 1e5 --delay 5e3"

This commands transmit Wi-Fi 7 (EHT-SU) format 160 MHz channel bandwidth (CBW) frames.

.. hint:: You can refer to :doc:`/presets` for full list of presets.

.. _tx-gain-control:
Tx Gain Control
^^^^^^^^^^^^^^^^^^^^^^

PicoScenes uses ``--txpower`` option for Tx power specification. Same as ``--rx-gain`` exemplified in :ref:`rx-gain-control`, ``--txpower`` also has two modes: **absolute Tx gain value** and **normalized Tx gain value**.

The following command specifies 15 dBm Tx gain for packet injection:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --freq 5900 --mode injector --repeat 1e5 --delay 5e3 --txpower 15"

The following command specifies 0.8 of the maximum Tx gain for packet injection:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --freq 5900 --mode injector --repeat 1e5 --delay 5e3 --txpower 0.8"

.. hint:: PicoScenes specifies ``--txpower 0.7`` by default.

.. _multi-channel-tx:
Multi-Channel (RF Chain) and MIMO Tx with NI USRP Devices
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

PicoScenes supports multi-channel transmission using NI USRP devices either by a single device or by combining multiple devices. 

The device naming and synchronization are identical to that of multi-channel signal receiving aforementioned in :ref:`multi-channel-rx-single`, :ref:`multi-channel-rx-multi` and :ref:`naming_for_usrp`.

Multi-Channel (RF Chain) Tx for 1-STS frame with NI USRP Device
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In this scenario, assume your USRP device ID id ``usrp192.168.30.2,192.168.70.2``, you can use the following command to transmit a 1-STS frame by multiple antennas:

.. code-block:: bash

    PicoScenes "-d debug -i usrp192.168.30.2,192.168.70.2 --freq 5900 --mode injector --repeat 1e5 --delay 5e3 --clock-source external --preset TX_CBW_40_EHTSU --tx-channel 0,1,2,3"

In this command the ``--tx-channel`` option, equivalent to the `--txcm` option, specifies the Tx channel or chain mask. ``--tx-channel 0,1,2,3`` is equivalent to ``--txcm 15`` indicating all four RF channels are used for Tx. It is important to understand that **multi-channel Tx is not necessarily MIMO transmission**.

.. hint:: Due to the cyclic shift delay (CSD) requirement by 802.11 standard, even for a 1-STS frame, the signals transmitted on each Tx channel is different, more specifically, cyclic delayed among antennas.

Multi-Channel (RF Chain) Tx for MIMO frame with NI USRP Device
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In this scenario, assume your USRP device ID id ``usrp192.168.30.2,192.168.70.2``, you can use the following command to transmit a MIMO frame by multiple antennas:

.. code-block:: bash

    PicoScenes "-d debug -i usrp192.168.30.2,192.168.70.2 --freq 5900 --mode injector --repeat 1e5 --delay 5e3 --clock-source external --preset TX_CBW_40_EHTSU --tx-channel 0,1,2,3 --sts 4"

In this command the ``--sts 4`` specifies to :math:`N_{STS}=4` (or 4x4 MIMO transmission) to transmit the frames.

.. _non-standard-tx-rx:
Transmission, Reception and CSI Measurement with Non-Standard Channel and Bandwidth
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. warning:: You MUST respect the RF spectrum regulations of your country/location. PicoScenes platform is a research-purpose software. It is your responsibility to make sure that you are in compliance with all suitable laws.

In previous two sections :ref:`sdr_rx` and :ref:`sdr_tx`, all Tx/Rx parameters are compatible with the official Wi-Fi *numerology*, which guarantees the interoperability between SDR device and COTS NICs, which **allows users to transmit frames with SDR and measure CSI with COTS NICs, or the reverse**. To maintain this interoperability, we use ``--preset`` conventions to specify various low-level parameters for SDR. In this section, we demonstrate several commonly used non-standard cases and explain some key parameters.

Change Baseband Bandwidth (Sampling Rate) with NI USRP B2x0 Series
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

NI USRP B2x0 features a fractional baseband clocking architecture, *i.e.*, the baseband sampling rate can be any values within its clocking range. Assuming you want to up-clock the standard 20 MHz channel to 30 MHz (50% more bandwidth or sampling rate) at 5955 MHz channel, you can use the following commands:

.. code-block:: bash

    PicoScenes "-d debug -i usrp --freq 5955 --rate 30e6 --mode logger --plot" #<- Run on the first computer (Rx end)
    PicoScenes "-d debug -i usrp --freq 5955 --rate 30e6 --mode injector --repeat 1e9 --delay 5e3" #<- Run on the second computer (Tx end)

The ``--rate 30e6`` option specifies to clock the baseband at 30 MHz rate.

.. hint:: PicoScenes sets ``--rate`` to 20 MHz by default. If the ``--preset`` option appears, it will override the defaults. And If both ``--preset`` and ``--rate`` appear explicitly, the ``--rate`` overrides ``--preset``.


Non-Standard Tx/Rx with NI USRP N2x0/X3x0/N3x0 Series
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Two reasons complicates the arbitrary bandwidth changing for the N2x0/X3x0/N3x0 Series devices: 

    - Fixed master clock rate: contrary to NI USRP B210, which has a flexible master clock rate, the master clock rate is fixed 100 MHz for N2x0, 184.32 MHz **or** 200 MHz for X3x0, and 200 **or** 245.76 **or** 250 MHz for N3x0.
    - *Integer-N* clocking: The actual baseband sampling rate (both DAC and ADC) can only be :math:`F_{master}/N, N\in \mathbb{Z}^+`, *e.g.* N2x0 can clocks its baseband rate to 50/33.3/25/20/10... MHz.

PicoScenes workarounds this problem by *in-baseband digital resampling*, *i.e.*, up/down-sampling the baseband signals to match the actual hardware sampling rate. For example, neither X3x0 or N3x0 supports the native 160 MHz sampling, what actually happens behind ``--preset TX_CBW_160_EHTSU`` and ``--preset RX_CBW_160`` is 200 MHz actual sampling rate plus 1.25x Tx up-sampling and 0.8x Rx down-sampling.

The following commands are equivalent to ``--preset TX_CBW_160_EHTSU`` and ``--preset RX_CBW_160``:

.. code-block:: bash

    PicoScenes "-d debug -i usrp --freq 5250 --rate 200e6 --rx-resample-ratio 0.8 --rx-cbw 160 --mode logger --plot" #<- Run on the first computer (Rx end)
    PicoScenes "-d debug -i usrp --freq 5250 --rate 200e6 --tx-resample-ratio 1.25 --cbw 160 --format EHTSU --coding LDPC --mode injector --repeat 1e9 --delay 5e3" #<- Run on the second computer (Tx end)

These options can be interpreted as:

- ``--rx-resample-ratio 0.8``: Down-sampling the 200 MHz rate received signals by 0.8 to 160 MHz rate, 1.0 by default;
- ``--rx-cbw 160``: Tell PicoScenes baseband decoder to treat the incoming signals as 160 MHz channel bandwidth (CBW) format, 20 MHz CBW by default;
- ``--tx-resample-ratio 1.25``: Up-sampling the 160 MHz CBW format signals by 1.25x to 200 MHz rate, 1.0 by default;
- ``--cbw 160``: Tx baseband encoder to generate 160 MHz CBW format, 20 MHz CBW by default;
- ``--format EHTSU``: Tx frame format is 11be (EHT) Single-User (EHTSU) format, HT (11n) format by default;
- ``--coding LDPC``: Tx frame coding scheme uses the LDPC coding, BCC coding by default;

You can alter the parameters of the above commands to achieve non-standard Tx/Rx and CSI measurement. For example, you can super-sample 20 MHz channel with 40 MHz rate by ``--rate 40e6 --rx-resample-ratio 0.5`` at Rx end, or ``--rate 40e6 --tx-resample-ratio 2`` at Tx end.

.. hint:: *In-baseband Digital Resampling* is a computation intensive task. It lows performance and general throughput.

.. _experimental_features:
Experimental Features
~~~~~~~~~~~~~~~~~~~~~~~~~

.. _dual_split_merge:
Dual-Channel Spectrum Splitting and Stitching
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

PicoScenes supports combining two channels operating at adjacent frequencies with the same bandwidth, achieving a similar effect to doubling the sampling rate of a single channel. This method allows surpassing the limitation of the maximum hardware sampling rate, such as achieving an equivalent 400 MHz sampling rate using the NI USRP X310 which has a maximum of 200 MHz sampling rate.

Assume you have two NI USRP X310 (with two UBX-160 daughterboards) and each is equipped with dual connection (usrp192.168.30.2_192.168.31.2 for the Rx end, and usrp192.168.40.2_192.168.41.2 for the Tx end). If you want to transmit and receive 802.11 EHT-SU 320 MHz channel bandwidth (CBW) frames at 5600 MHz using NI USRP X310 devices. You can use the following commands:

.. code-block:: bash

    PicoScenes "-d debug -i usrp192.168.30.2_192.168.31.2 --freq 5520 5680 --rate 200e6  --rx-resample-ratio 0.8 --merge --rx-cbw 320 --rxcm 3 --mode logger   --plot" #<- Run on the first computer (Rx end)
    PicoScenes "-d debug -i usrp192.168.40.2_192.168.41.2 --freq 5520 5680 --rate 200e6 --tx-resample-ratio 1.25 --split    --cbw 320 --txcm 3 --mode injector --format EHTSU --coding LDPC --repeat 1e9 --delay 5e5" #<- Run on the second computer (Tx end)

Several key options are explained as below:

- ``--freq 5520 5680``: ``--freq`` supports multi-channel setting. To transmit 320 MHz CBW frame at 5600 MHz, two X310 channels should center at 5520 MHz and 5680 MHz.
- ``--rate 200e6  --rx-resample-ratio 0.8``: To receive 320 MHz CBW frame at 5600 MHz, two X310 channels should center at 5520 MHz and 5680 MHz and operate at 160 MHz. However, NI USRP X310 doesn't support 160 MHz, therefore, Rx signals are resampled to 160 MHz.
- ``--rate 200e6 --tx-resample-ratio 1.25``: To transmit 320 MHz CBW frame at 5600 MHz, two X310 channels should center at 5520 MHz and 5680 MHz and operate at 160 MHz. However, NI USRP X310 doesn't support 160 MHz, therefore, Tx signals are resampled to 160 MHz.
- ``--merge``: Rx end merges dual-channel signals into a 400 MHz higher sampling rate stream (then down-sampled by 0.8x);
- ``--split``: Tx end splits the 400 MHz rate I/Q streams into two 200 MHz rate streams (before splitting, up-sampled by 1.25x);
- ``--rx-cbw 320`` and ``--cbw 320``: Specify baseband decoder/encoder to operate at 320 MHz CBW mode;

.. hint:: The two frequencies specified to ``--freq`` can be any two hardware-supported frequencies, enabling more research flexibility.

.. note:: The 320 MHz sampling together with intensive *In-baseband Digital Resampling* are extremely CPU-intensive. Very high packet loss should be expected.

.. _parallel_decoding:
Multi-Thread Rx Decoding
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

PicoScenes Rx baseband decoder features an experimental multi-threading capability, allowing pp to :math:`N_{CPU}` times increase in decoding performance. Enabling this feature is easy like used in the following example:

.. code-block:: bash

    PicoScenes "-d debug -i usrp --freq 5250 --preset RX_CBW_160 --mode logger --plot --mt 5" #<- Run on the first computer (Rx end)

The ``--mt 5`` option instructs the Rx decoder to use 5 threads in parallel decoding.

.. note:: The following sections are not revised, the old version.

USRP injects Packets while QCA9300/IWL5300 NICs measure CSI (Difficulty Level: Easy)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes can also inject 802.11a/g/n/ac/ax compatible packets. The following example bash script injects 802.11ac packets in 5815 MHz channel with 40 MHz bandwidth, two spatial streams (:math:`N_{STS}=2`) and MCS 4.

.. code-block:: bash

    #!/bin/sh -e 

    PicoScenes "-d debug;
                -i usrp192.168.40.2 --mode injector --freq 5815e6 --rate 50e6 --cbw 80 --code ldpc --format vht --tx-channel 0,1 --sts 2 --mcs 4 --txpower 15 
                "

The above command introduces two SDR-exclusive and Tx-related options: ``--format`` and ``--tx-channel``. ``--format vht`` specifies the PicoScenes baseband to transmit the signal in 802.11ac (Very High Throughput, VHT) format. ``--tx-channel 0,1`` assigns the 0-th and 1st channels for transmission to support the following ``--sts 2 --mcs 4`` MIMO transmission.

You may download and run the complete takeaway bash script for this scenario at 
:download:`2_3_2 <_static/2_3_2.sh>` 

Two USRPs measure CSI under arbitrary bandwidth (Difficulty Level: Easy)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

USRP N210 and X310 cannot tune the baseband sampling rate to any specified bandwidth. For example, USRP X310, with 200 MHz master clock rate, can only tune to :math:`\frac{200}{n}, n\in\mathcal{N}^+` MHz rates, like 200/100/66.67/50/40/33.3 ... MHz. In order to support other sampling rates, like 80/160 MHz bandwidth in 802.11ac/ax protocols, PicoScenes introduces resampling ratio for both the Tx and Rx. The following bash script demonstrates the packet injection and CSI measurement 160 MHz bandwidth.

.. code-block:: bash

    #!/bin/sh -e 

    PicoScenes "-d debug;
                -i usrp192.168.41.2 --mode logger --freq 5815e6 --rate 200e6 --rx-resample-ratio 0.8 --cbw 160 --code ldpc --rx-channel 0,1 --rx-gain 15; 
                -i usrp192.168.40.2 --mode injector --freq 5815e6 --rate 200e6 --tx-resample-ratio 1.25 --cbw 160 --code ldpc --format vht --tx-channel 0,1 --sts 2 --mcs 1 --txpower 15 --repeat 1000 --delay 5e3;
                -q
                "

The above command tunes both the baseband sampling rate of the Tx and Rx end to a 200 MHz, which is a hardware-supported sampling rate by X310. To transmit and receive 160 MHz bandwidth signal, both ends use ``--tx-resample-ratio 1.25`` and ``--rx-resample-ratio 0.8`` to resamples the signals. More specifically, Tx end interpolates the baseband generated signal by 1.25x so that the transmission of 1.25x interpolated signals in 200 MHz is equivalent to 160 MHz bandwidth signal. Rx end decimates the raw received signals by 0.8x so that the 200 MHz sampled signals can be down-clocked to 160 MHz.

You may download and run the complete takeaway bash script for this scenario at 
:download:`2_3_3 <_static/2_3_3.sh>` 

Multi-USRP-based MIMO transmission and reception (Difficulty Level: Easy)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes can combine at most four USRP X310 devices to form a 8x8 MIMO array (each X310 with two independent TX/RX channels). The following bash script uses two USRP X310-based 4x4 MIMO arrays (four X310 devices and eight channels totally) to perform the simple packet injection and CSI measurement.

.. code-block:: bash

    #!/bin/sh -e 

    PicoScenes "-d debug;
                -i usrp192.168.42.2,192.168.43.2 --mode logger --freq 5815e6 --rate 20e6 --cbw 20 --rx-channel 0,1,2,3 --rx-gain 15; 
                -i usrp192.168.40.2,192.168.41.2 --mode injector --freq 5815e6 --rate 20e6 --cbw 20 --format vht --tx-channel 0,1,2,3 --sts 4 --mcs 1 --txpower 15 --repeat 1000 --delay 5e3;
                -q
                "

The above command uses 4 USRP X310s to form the a 4x4 MIMO transmitter and a 4x4 MIMO receiver. Both sides use ``--tx-channel 0,1,2,3`` and ``--rx-channel 0,1,2,3``, to specify 4 transmission/reception channels, respectively.

You may download and run the complete takeaway bash script for this scenario at 
:download:`2_3_4 <_static/2_3_4.sh>` 


CSI Measurement using IWL5300/QCA9300 NICs
-----------------------------------------------------------

.. _iwl5300-wifi-ap:

IWL5300 + Wi-Fi AP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The IWL5300 NIC can also measure CSI for the 802.11n frames sent from the connected Wi-Fi AP.
Assuming you have already connected the IWL5300 NIC to an 802.11n compatible Wi-Fi AP, then there are four steps to measure CSI from IWL5300:

#. Switching the default IWL 5300 firmware to the spatial CSI-extractable firmware. We provide an one-key solution by ``switch5300Firmware csi``.
#. Lookup the IWL5300 NIC's PhyPath ID by ``array_status``. 
#. Assume the PhyPath is ``3``, then run command ``PicoScenes -d debug -i 3 --mode logger`` in a terminal.
#. Exit CSI logging by pressing Ctrl+C.

The above command has three program options *"-d debug -i 3 --mode logger"*. They can be interpreted as *"PicoScenes changes the display level log message to debug (-d debug); makes the device with an Id of 3 switch to the CSI logger mode (-i 3 --mode logger)"*. See :doc:`parameters` for more detailed explanations.

The logged CSI data is stored in a ``rx_<Id>_<Time>.csi`` file in the *present working directory*. Open MATLAB, drag the .csi file into the Command Window, the file will be parsed and stored as a MATLAB variable named *rx_<Id>_<Time>*.

You may download and run the complete takeaway bash script for this scenario at 
:download:`2_2_1 <_static/2_2_1.sh>` 

.. hint:: The CSI measurement firmware of IWL5300 removes the encryption related functionalities, therefore it can only connect to the password-free open APs. PicoScenes also provides a convenient ``switch5300Firmware`` script to switch between the normal and CSI measurement firmwares for IWL5300 NICs. For more information, you may refer to :doc:`utilities`.

.. _dual_nic_separate_machine:

Two QCA9300/IWL5300 NICs installed on two PCs, in monitor + injection mode (Difficulty Level: Easy)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Monitor mode + packet injection is the most used CSI measurement setup in the previous research. PicoScenes significantly improves the measurement experience in three aspects:

- enables QCA9300 (Tx) -> IWL5300 (Rx) CSI measurement [not possible with Atheros CSI Tool]
- enables monitor mode + packet injection style measurement for QCA9300 [not possible with Atheros CSI Tool]
- adds an intuitive bash script ``array_prepare_for_picoscenes`` to put Wi-Fi NICs into monitor mode, to detach the NIC from the system Network Manager, etc. See also :doc:`utilities`. 

Based on these improvements, CSI measurement in monitor + injection mode is simplified to only five steps:

#. On both side, Lookup the Wi-Fi NIC's PhyPath ID by ``array_status``;
#. On both side, run ``array_prepare_for_picoscenes <NIC_PHYPath> <freq> <mode>`` to put the Wi-Fi NICs into monitor mode with the given channel frequency and HT mode. You may specify the frequency and mode values to any supported Wi-Fi channels, such as "2412 HT20', "2432 HT40-",  "5815 HT40+", etc. You can even omit <freq> and <mode>; in this case, "5200 HT20" will be the default.
#. Assuming a QCA9300 NIC is the Rx side (CSI measurement side), run ``PicoScenes -d debug -i <NIC_PHYPath> --mode logger`` and wait for packet injection;
#. Assuming another QCA9300 NIC is the Tx side (packet injector side), run ``PicoScenes -d debug -i <NIC_PHYPath> --mode injector --repeat 1000 --delay 5000 -q``
#. Rx end exists CSI logging by pressing Ctrl+C

The explanations to the commands are as follows.
    
- The Rx end has the identical program options as the last scenarios. See also :ref:`iwl5300-wifi-ap`.
- The Tx end options ``PicoScenes -d debug -i <NIC_PHYPath> --mode injector --repeat 1000 --delay 5000 -q`` can be interpreted as *"PicoScenes changes the display level of log message to debug (-d debug); make device <AnyId=NIC_PHYPath> switch to CSI injector mode (-i <NIC_PHYPath> --mode injector); injector will inject 1000 packets (--repeat 1000) with 200 Hz injection rate or with 5000us interval (--delay 5000); when injector finishes the job, PicoScenes quits (-q)"*. See :doc:`parameters` for more detailed explanations.

The above commands assume that both the Tx and Rx ends are QCA9300 NICs. If the Tx/Rx combination changes, users may need to change the command. The details are listed below.

.. csv-table:: Cross-Model CSI Measurement Detail
    :header: "Tx End Model", "Rx End Model", "Note"
    :widths: 20, 20, 60

    "QCA9300", "QCA9300", use the Tx and Rx above commands
    "QCA9300", "IWL5300", append ``--5300`` to the Tx end command
    "IWL5300", "QCA9300", PicoScenes DO NOT SUPPORTED
    "IWL5300", "IWL5300", use the above Tx and Rx commands

You may download and run the complete takeaway bash scripts for this scenario at 
:download:`2_2_2-1 <_static/2_2_2-1.sh>` 
:download:`2_2_2-2 <_static/2_2_2-2.sh>` 

.. _dual_nics_on_one_machine:

Two QCA9300/IWL5300 NICs installed on one single PC, in monitor + injection mode (Difficulty Level: Easy)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The measurement in this scenario leverages the multi-NIC concurrent operation functionality. PicoScenes adopts an intuitive CLI interface, allowing users to specify concurrent operations for multiple NICs. Since the commands used in this scenario remain the same as the last scenario, users should refer to ::ref:`dual_nic_separate_machine` to understand the meaning of commands first.

Let assume Wi-Fi NICs with PhyPath ``3`` and ``4`` are the *injector* and *logger*, respectively,  the following bash script performs the monitor + injection on two NICs installed in one single host PC:

.. code-block:: bash
    
    #!/bin/sh -e 

    array_prepare_for_picoscenes "3 4" "2412 HT20"

    PicoScenes "-d debug;
                -i 4 --mode logger; // this command line format support comments. Comments start with //
                -i 3 --mode injector --repeat 1000 --delay 5000; // NIC <3> in injector mode, injects 1000 packets with 5000us interval
                -q // -q is a shortcut for --quit"

The first convenient feature is that ``array_prepare_for_picoscenes`` provides multi-NIC specification capability, which, in the above command, specify both ``3`` and ``4`` to work at 2412 MHz with HT20 channel mode.

For the PicoScenes command, this enhanced version wraps the Tx and Rx commands as one long string input. A semicolon separates the commands for each NIC. You can also add comments as exemplified in the command.

PicoScenes parses this long string by first localizing the semicolons and then splitting the long command into multiple per-NIC command strings. It then parses and executes the per-NIC command strings in order. 

You may download and run the complete takeaway bash script for this scenario at 
:download:`2_2_3 <_static/2_2_3.sh>` 

Two QCA9300/IWL5300 NICs performs round trip CSI measurement (Difficulty Level: Easy)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: To simplify the description, in the following scenarios, we assume both (or multiple) devices are all connected to one single PC, and we use the long-string style command interface to control PicoScenes and hardware. Users should refer to ::ref:`dual_nics_on_one_machine` to understand the long string command style.

In this experiment, two NICS will perform the round-trip CSI measurement. The exact protocol is as below:

#. Prepare both NICs to the same channel and channel mode.
#. NIC A injects packets in 802.11n format;
#. NIC B receives the packet and measure the CSI;
#. NIC B replied to NIC A in 802.11n format and *optionally* package the measured CSI as payload;
#. NIC A receives the reply from NIC B and measure the CSI. Until now, a round-trip CSI measurement finishes.
#. Optionally, if NIC B packages B's measured CSI as payload, then NIC A obtains the CSI measurements from both directions immediately.

Despite a pretty simple protocol, the above CSI measurement protocol cannot be realized by the previous CSI tools because they don't integrate the packet injection control, not to mention the difference between QCA9300/IWL5300.

PicoScenes realizes the above round-trip CSI measurement via EchoProbe plugin. Besides the simple *injector* and *logger* modes used in the above scenarios, EchoProbe also provides *initiator* and *responder* modes, which are dedicated for round-trip CSI measurement. The following bash script realizes the measurement:

.. code-block:: bash

    #!/bin/sh -e 

    array_prepare_for_picoscenes "3 4" "2412 HT20"

    PicoScenes "-d debug;
                -i 4 --mode responder;
                -i 3 --mode initiator --repeat 1000 --delay 5000;
                -q"

The above command puts NIC ``4`` into responder mode and let NIC ``3``, initiate and repeat the round-trip CSI measurement for 1000 times with a 5000us interval. Compared to the last scenario, the only difference is the mode. NIC ``4`` works in responder mode, and NIC 3 works in initiator mode. The internal logics of both modes are as follows.

- Responder mode: besides the basic CSI logging functionality, *responder* mode checks the frame content, and immediately reply the frame if it is a `EchoProbe ProbeRequest` frame;
- Initiator mode: besides the basic frame injection functionality, *initiator* mode uses an internal `timeout and re-transmission` mechanism to realize the round-trip CSI measurement. 

You may download and run the complete takeaway bash script for this scenario at 
:download:`2_2_4 <_static/2_2_4.sh>` 

.. _dual_nics_scan:

Two QCA9300/IWL5300 NICs perform the round trip CSI measurement while scanning large spectrum (Difficulty Level: Medium)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the experiment, both NICs will perform continuous CSI measurements over a large spectrum. PicoScenes (or EchoProbe plugin) leverages the bi-directional communication ability of *Initiator* and *Responder* modes to synchronize the frequency hopping. The following command performs the continuous CSI measurement over the entire 2.4 GHz band with a 5 MHz step. And in each carrier frequency, 100 round-trip measurements are performed.

.. code-block:: bash

    #!/bin/sh -e 

    array_prepare_for_picoscenes "3 4" "2412 HT20"

    PicoScenes "-d debug;
                -i 4 --freq 2412e6 --mode responder;
                -i 3 --freq 2412e6 --mode initiator --repeat 100 --delay 5000 --cf 2412e6:5e6:2484e6;
                -q"

The above command adds two new options, ``--freq`` and ``--cf``. ``--freq``, as the name implies, specifies the current NIC's working carrier frequency. It supports the scientific notion; thus, ``--freq 2412e6`` means to tune the NIC's carrier frequency to 2412 MHz. ``--cf`` specify the range and step for spectrum scanning. It adopts the  MATLAB-style `begin:step:end` format to specify the starting frequency, frequency interval per step and ending frequency. ``--cf 2412e6:5e6:2484e6`` in the above command indicates to scan the spectrum from 2412 MHz to 2484 MHz with a 5 MHz step. It is worth noting that ``--freq`` is not internally related to ``--cf``. It just specifies the initial working frequency.




.. note:: IWL5300 doesn't support the arbitrary tuning for carrier frequency; therefore, it only supports the standardized channel frequencies.


.. warning:: The spectrum scanning is based on round-trip communication, not pre-scheduled. If the round-trip measurement fails due to excessive retransmission, the spectrum scanning will fail. 

You may download and run the complete takeaway bash script for this scenario at 
:download:`2_2_5 <_static/2_2_5.sh>` 

Two QCA9300 NICs scan both the spectrum and bandwidth (Difficulty Level: Medium)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This experiment add just two new options to the above scenario. See ::ref:`dual_nics_scan` first. The following the bash script that scans both the carrier frequency and bandwidth. The carrier frequency is the `inner loop` and bandwidth is the `outer loop`.


.. code-block:: bash

    #!/bin/sh -e 

    array_prepare_for_picoscenes "3 4" "2412 HT20"

    PicoScenes "-d debug;
                -i 4 --freq 2412e6 --rate 20e6 --mode responder;
                -i 3 --freq 2412e6 --rate 20e6 --mode initiator --repeat 100 --delay 5000 --cf 2412e6:5e6:2484e6 --sf 20e6:5e6:40e6;
                -q"


The two new options are ``--rate`` and ``--sf``. ``--rate`` specifies the initial bandwidth; it is not related to ``--sf`` option. ``--sf`` specifies the bandwidth scanning range and has the same MATLAB-like style.

You may download and run the complete takeaway bash script for this scenario at 
:download:`2_2_6 <_static/2_2_6.sh>` 

Two QCA9300 NICs scan both the spectrum and bandwidth w/ advanced measurement settings (Difficulty Level: Medium Plus)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following script is based on the last scenario ::ref:`dual_nics_scan`, but adds a few more options to demonstrate the advanced measurement settings.

.. code-block:: bash

    #!/bin/sh -e 

    array_prepare_for_picoscenes "3 4" "5200 HT40-" # Don't miss the quotation marks for the channel specification!

    PicoScenes "-d debug;
                -i 4 --freq 2412e6 --rate 20e6 --mode responder --rxcm 3 --cbw 40 --sts 2 --txcm 5 -ess 1 --txpower 15 --coding ldpc;
                -i 3 --freq 2412e6 --rate 20e6 --mode initiator --repeat 100 --delay 5000 --cf 2412e6:5e6:2484e6 --sf 20e6:5e6:40e6 --cbw 20 --sts 2 --mcs 0 --gi 400 --txcm 3 --ack-mcs 3  --ack-type header;
                -q"


The above commands demonstrates the mostly used Tx/Rx options, namely ``--cbw``, ``--sts``, ``--mcs``, ``--txcm``, ``--rxcm``, ``--gi`, ``--ess``, ``--txpower``, ``--coding``, and two EchoProbe ACK options ``--ack-mcs`` and ``--ack-type``. ``--cbw`` indicates to transmit the frame in HT40 format. ``--sts`` and ``--mcs`` specify the number of space-time stream (:math:`N_{STS}`) and MCS. ``--txcm`` and ``--rxcm`` are the Tx/Rx chain mask, ``--txcm 5`` means using the 1st and 3rd antennas for transmission, and ``--rxcm 3`` means using the 1st and 2nd antenna for receiving. ``--gi 400`` enables the Short Guard Interval (400ns) for HT-data potion. ``--ess 1`` means adding one extra spatial sounding HT-LTF. Adding the two conventional spatial stream (``--sts 2``) and one extra spatial stream, the transmitted packet has three HT-LTF, thus, three CSI measurement. ``--txpower 15`` specifies the transmission power to be 15 dBm. Last, ``--coding ldpc`` specifies the NIC baseband to encode the packet using low-density parity-check (LDPC) coding scheme.

EchoProbe plugin also introduces several options to control the transmission of reply frames. ``--ack-mcs 3`` tells the responder to use MCS=3 if the responder doesn't specify MCS explicitly. There are also ``--ack-sts``, ``--ack-gi`` and ``--ack-cbw`` options. ``--ack-type header`` tells the responder not to reply the full CSI but only a header. Users may refer to :doc:`parameters` for more detailed explanations.


.. important:: PicoScenes uses the 802.11ac/ax style MCS/STS definition which decouples :math:`N_{STS}` (``--sts``) and per-stream MCS (``--mcs``). For example, MCS=9 in 802.11n version is represented by two terms in 802.11ac/ax: :math:`N_{STS}=2` (``--sts 2``) and MCS=1 (``--mcs 1``). 

You may download and run the complete takeaway bash script for this scenario at 
:download:`2_2_7 <_static/2_2_7.sh>` 