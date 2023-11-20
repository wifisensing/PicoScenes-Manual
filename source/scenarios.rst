CSI Measurement using PicoScenes
=================================================

**Revised on Nov. 16, 2023**


On this page, we will demonstrate the methods of CSI measurement and various low-level controls on different hardware frontends. You can jump to the interested topics via following links:

#. :ref:`fundamentals`
#. :ref:`csi_by_sdr`
#. :ref:`ax200-measurements`
#. :ref:`csi-by-5300-and-9300`
#. :ref:`interoperability`

Before we proceed, it is assumed that you have already installed the PicoScenes software and the supported hardware. See :doc:`installation` for hardware and software installation guides.

.. _fundamentals:
Before Getting Started: Some Fundamentals
--------------------------------------------

Here we introduce two fundamentals :ref:`device_naming` and :ref:`fact-wifi-channels`.

.. _device_naming:
Device Naming
~~~~~~~~~~~~~~~~~

In order to mult-frontend operation, we devise an simply device naming protocol, which is elaborated in the follow section.

.. _naming_for_nics:
Device Naming for Commercial Wi-Fi NICs
+++++++++++++++++++++++++++++++++++++++++++++

PicoScenes provides a script named ``array_status``, which lists all the **PCI-E based Wi-Fi NICs**. A sample output is as below:

.. figure:: /images/array_status.png
   :figwidth: 700px
   :target: /images/array_status.png
   :align: center

   8 Wi-Fi NICs detected, and each has `four` IDs.

In the array_status output, there are four IDs for each NIC: *PhyPath*, *PhyId*, *DevId*, and *MonId*. Their explanations are shown below. Among them, we strongly **recommend using PhyPath ID** in all scenarios.

.. csv-table:: ID System for COTS NICs
    :header: "ID Type", "Description"
    :widths: auto

    "**PhyId**", "The *Physical ID* is assigned by the Linux mac80211 module at the system level, primarily used for low-level hardware control. The main drawback is that *Physical ID* may change upon each reboot*."
    "**DevId**", "The *Device ID* is also assigned by the Linux mac80211 module at the system level, mainly used for link-level Wi-Fi configuration. The main drawback is that *Device ID* may change upon each reboot*."
    "**MonId**", "The *Monitor interface ID* is created by user for the attached monitor interface. The main drawback is that the monitor interface does not exist by default."
    "**PhyPath (Recommended)**", "To address the issue of ID inconsistency, we introduce a new ID called *PhyPath*, listed in the first column of the ``array_status`` output. The main advantage of PhyPath is that **it remains consistent across reboots and even system reinstallations, because it is bound to the PCI-E connection hierarchy**. *PhyPath* is supported throughout the PicoScenes system, including the PicoScenes program, plugins, and bash scripts."

.. _naming-for-sdr:
Device Naming for SDR
+++++++++++++++++++++++++++++++++

Device naming for SDR devices has three subtypes: :ref:`naming_for_usrp`, :ref:`device-naming-for-hackrf-one`, and :ref:`device-naming-for-virtual-sdr`.

.. _naming_for_usrp:
Device Naming for NI USRP
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We devise a simple and scalable naming protocol for USRP devices. It has four forms:

- ``usrp``: Used in case of only one USRP device connected to computer. For example, only one USRP device is connected to computer, you can select this device with simply ``usrp``.
- ``usrp<IPADDRESS_or_RESOURCEID_or_SERIALID_or_DEVICENAME>``: Used in case of selecting one of multiple connected USRP devices. For example, in order to select a USRP X310 device (ip-addr=192.168.40.2, serial=DID1234, name=myX310, resourceId=RID4567) from multiple USRP devices connected, this device can be represented by any one of the four possible IDs: ``usrp192.168.40.2``, ``usrpDID1234``, ``usrpmyX310`` or ``usrpRID4567``.
-  ``usrp<IPADDRESS_or_RESOURCEID_or_SERIALID_or_DEVICENAME>,[multiple <IPADDRESS_or_RESOURCEID_or_SERIALID_or_DEVICENAME>]``: Used in case of combining multiple USRPs devices. For example, the combination of two USRP X310 devices (with IP addresses of 192.168.40.2 and 192.168.41.2) can be represented by ``usrp192.168.40.2,192.168.41.2``.
-  ``usrp<IPADDRESS0_IPADDRESS1>,[multiple <IPADDRESS0_IPADDRESS1>]``: Used in case of combining the two 10GbE connections of one or multiple USRP X310 devices. Assume you have two USRP X310 devices connected. The first USRP X310 device has two 10GbE connections with IP addresses of 192.168.30.2 and 192.168.40.2, and the second USRP X310 device has two 10GbE connections with IP addresses of 192.168.70.2 and 192.168.80.2. The combination of the two channels of the first X310 can be represented by ``usrp192.168.30.2_192.168.40.2``. The combination of the all four channels can be represented by ``usrp192.168.30.2_192.168.40.2,192.168.70.2_192.168.80.2``. The combination of the first two and the last one can be represented by ``usrp192.168.30.2_192.168.40.2,192.168.80.2``.

.. _device-naming-for-hackrf-one:
Device Naming for HackRF One
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

All HackRF One devices are named as ``hackrf<Device_Number>``, *e.g.*, ``hackrf0`` or ``hackrf1``. The starting device number is ``0``, and the device number with is the same order as the command ``SoapySDRUtil --find="driver=hackrf"`` lists.

.. _device-naming-for-virtual-sdr:
Device Naming for Virtual SDR
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The Virtual SDR device adopts the naming pattern of ``virtualsdr<ANY_GIVEN_ID>``, *e.g.*, ``virtualsdr0``, ``virtualsdr_astringId`` or the simplest ``virtualsdr``.

.. _fact-wifi-channels:
Basic Facts of Wi-Fi Channelization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Many PicoScenes users are confused about how to correctly specify Wi-Fi channels for COTS NICs and SDR devices. We create a big table :doc:`/channels` for reference.


.. _csi_by_sdr:
ISAC Research using NI USRP or HackRF One SDR
--------------------------------------------------

PicoScenes can drive SDR devices to transmit 802.11a/g/n/ac/ax/be format frames, receive frames, and measure the CSI data in real-time. In the following sections, we explore four major topics:

#. Receiving frames and measuring CSI by :ref:`sdr_rx`
#. Transmitting Frames by :ref:`sdr_tx`
#. Non-Standard Tx and Rx: :ref:`non-standard-tx-rx`
#. Concurrent multi-SDR operation :ref:`multi-SDR-operation`
#. Some advanced features: :ref:`experimental-features`

.. _sdr_rx:
Listening to Wi-Fi Traffic and Measuring CSI for 802.11a/g/n/ac/ax/be-Format Frame
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. _sdr-rx-20-cbw:
Listening to 20 MHz Bandwidth Channels
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

.. _sdr-rx-40-or-higher-cbw:
Listening to 40/80/160/320 MHz Bandwidth Channels
+++++++++++++++++++++++++++++++++++++++++++++++++++

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

    In this command, ``--rx-gain 20`` specifies a absolute Rx gain of 20 dBm.

#. Specifying the normalized Rx gain can be like: To set the Rx gain using a normalized value, you can use the ``--rx-gain`` option followed by the desired normalized gain value. For example:


    .. code-block:: bash

        PicoScenes "-d debug -i SDR_ID --mode logger --freq 2412 --plot --rx-gain 0.7"

    The ``--rx-gain 0.7`` specify a normalized Rx gain of 0.7, **equivalent to the 0.7 of the hardware-supported maximum Rx gain**. 

    If value specified to ``--rx-gain`` is greater than 1, the value is considered to be the absolute gain; otherwise the normalized gain values.
    
    .. hint:: PicoScenes sets ``--rx-gain`` to 0.65 by default.

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
    
    In this command, ``--rxcm 3`` specifies the *Rx chainmask* value of 3, indicating the use of the 1st and 2nd Rx antennas for Rx. The ``--rxcm`` option allows you to specify the antenna selection using a bitwise style: 1 for the 1st antenna, 2 for the 2nd antenna, 3 for the first 2 antennas, 4 for the 3rd antenna, 5 for the 1st and 3rd antennas, and so on.

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

.. important:: The order of the IP addresses affects the order of the TX/RX channels! For example, the 0th and 3rd channels of the combined USRP ``usrp192.168.40.2,192.168.41.2`` refer to the first and the the second channel of the devices with the IP addresses of 192.168.40.2 and 192.168.41.2, respectively.

Combining Multiple USRP Devices plus Dual-Connection
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Assuming you have two NI USRP X3x0 devices each equipped with two UBX-160 daughterboards, and assume each X3x0 device is dual-10GbE connected with IP Addresses of 192.168.30.2 and 192.168.31.2 for the first and 192.168.70.2 and 192.168.71.2 for the second, respectively. And also assume you have physically synchronized these two devices by either solution of :ref:`phase_sync_multiple_device`, you can achieve four-channel coherent Rx for a 160 MHz Wi-Fi channel by the following command:

.. code-block:: bash

    PicoScenes "-d debug -i usrp192.168.30.2_192.168.31.2,192.168.70.2_192.168.71.2 --mode logger --freq 5250 --preset RX_CBW_160 --rx-channel 0,1,2,3 --clock-source external --plot"

Please pay special attention to the comma(**,**) and underline (**_**) in the option ``-i usrp192.168.30.2_192.168.31.2,192.168.70.2_192.168.71.2``. It means to to use the dual 10GbE connection plus combining multiple USRP devices. You can refer to :ref:`naming_for_usrp` for the complete naming protocols for NI USRP devices.

.. _sdr_tx:

Transmitting 802.11a/g/n/ac/ax/be protocol frames using SDR Devices
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Single-Device Tx with Rich Low-Level Controls
++++++++++++++++++++++++++++++++++++++++++++++++++++++++

In the following examples, we demonstrate how to use PicoScenes to drive SDR device to transmit Wi-Fi packets with gradually enriched low-level controls. We assume your SDR ID is ``SDR_ID`` and your SDR supports sufficiently high sampling rate, like 200 MSPS or higher.

.. _sdr-tx-20-cbw:
Transmitting 20 MHz bandwidth 802.11n Format Frames
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you just want to transmit some 802.11n rate, 20 MHz bandwidth frames at 5900 MHz channel for CSI measurement, you can use the following command:

.. code-block:: bash

    PicoScenes "-d debug -i SDR_ID --freq 5900 --mode injector --repeat 1e5 --delay 5e3"

The new options ``--mode injector --repeat 1e5 --delay 5e3`` can be interpreted as:

- ``--mode injector``: Ask the SDR to operate at packet injector mode;
- ``--repeat 1e5``: Injector 10000 packets;
- ``--delay 5e3``: The inter-frame delay is 5000 microseconds.

.. hint:: PicoScenes uses 802.11n format for packet injection by default.

.. _sdr-tx-40-or-higher-cbw:
Transmitting 40/80/160/320 MHz bandwidth 802.11a/g/n/ac/ax/be Format Frames
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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


.. _non-standard-tx-rx-fixed-master-clock:
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


.. _multi-SDR-operation:
Concurrent Multi-SDR Operation on a Single Computer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You have two ways to let PicoScenes to control multiple SDR devices on a single computer:

#. Multi-instancing of PicoScenes main program

    Multi-instancing is the simplest yet brutal approach. As these is no communication between two PicoScenes instances, you cannot perform convenient controls, like simultaneous start/stop, or in-process cross-frontend data exchange.
    
#. Multi-Frontend control by a single PicoScenes instance

    PicoScenes supports concurrent multi-SDR operation. Assume you have two or more NI USRP devices installed on your computer and you want to use one SDR for Tx and the rest for Rx and CSI measurement. For example, if you want to use usrp192.168.30.2 for Tx, and the other SDR, like usrp192.168.40.2 and usrp192.168.50.2 for Rx, you can use the following command:

    .. code-block:: bash

        PicoScenes "-d debug; // PicoScenes CLI input supports per-line comments
                    -i usrp192.168.40.2 --freq 5955 --preset RX_CBW_40       --mode logger   --plot; // Put usrp192.168.40.2 to logger mode, this line is non-blocking;
                    -i usrp192.168.50.2 --freq 5955 --preset RX_CBW_40       --mode logger   --plot; // Put usrp192.168.50.2 to logger mode, this line is non-blocking;
                    -i usrp192.168.30.2 --freq 5955 --preset TX_CBW_40_EHTSU --mode injector --repeat 10000 --delay 5e3; // Let usrp192.168.30.2 do Tx, this line is blocking
                    -q
                    "

    The above command is a multi-line input, each line for a SDR device. The line separation is the semicolon (**;**). 

      - The 2nd and 3rd lines put SDR usrp192.168.40.2 and usrp192.168.50.2 to logger mode and activate the corresponding live-plot. Please note *the logger mode is non-blocking*. It is the non-blocking design that actually enables the multi-SDR concurrent operation.
      - The 4th line specifies SDR usrp192.168.30.2 to transmit 40 MHz CBW 802.11be Single-User (EHT-SU) format frames for 10000 times.
      - The last line ``-q`` or ``--quit`` means *exit the program when no jobs*.

    .. hint:: There is a more comprehensive explanation for this multi-line format, see :ref:`cli-format-explanation`.

.. _experimental-features:
Advanced Features
~~~~~~~~~~~~~~~~~~~~~~~~~

.. _signal-recording-replay:
Signal Recording and Replaying (Both Tx and Rx Ends)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++

- Signal Recording: PicoScenes provides a pair of intuitive options, ``--tx-to-file`` and ``--rx-to-file``, which allow users to save the I/Q baseband signals to be transmitted or received into a ".bbsignals" file. 
- Signal Replaying: PicoScenes offers another pair of options, ``--tx-from-file`` and ``--rx-from-file``, which enable users to transmit the signals stored in a ".bbsignals" file or use the signals stored in a ".bbsignals" file as the signals received in real-time.

Proper combinations of these four options can greatly facilitate ISAC research. Here we show two most useful cases.

Case 1: Overcoming Packet Loss by Live Recording + Offline Replaying
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

PicoScenes' software baseband implement, while highly performant, still experiences significant packet loss in high-bandwidth and multi-channel scenarios. However, this issue can be circumvented by employing a signal recording and offline analysis approach. For example, users can record 160 MHz CBW signals by the command. Press Ctrl+C to stop.

.. code-block:: bash

    PicoScenes "-d debug -i usrp --freq 5250 --preset RX_CBW_160 --rx-to-file cbw160_record"

This command records the I/Q baseband signals into a file named *cbw160_record.bbsignals*. Then you can replay this signals using the following command:

.. code-block:: bash

    PicoScenes "-d debug -i usrp --freq 5250 --preset RX_CBW_160 --rx-from-file cbw160_record --plot"

This "Live Recording + Offline Replaying" approach, overcoming the issue of packet loss, is suitable for timing insensitive ISAC research.

.. hint:: PicoScenes MATLAB Toolbox Core (PMT-Core) also provides a decoder for .bbsignals file. You can open the .bbsignals files by just dragging the file into the MATLAB Command Window.


Case 2: Signal-Level Tx and Rx Control
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can open the saved .bbsignals file in MATLAB, manipulate the signals in MATLAB, save the signals back into a .bbsignals file, and replay the modified signals by ``--tx-from-file`` or ``--rx-from-file`` command.

This capability enables users to have full control over the Tx or Rx signals. Lots of applications are awaiting to be explored.

.. note:: To save signals back into .bbsignals file, you can use ``writeBBSignals`` commands provided by PMT-Core.

.. _multi-csi-measurement:
Multiple CSI Measurements per Frame
+++++++++++++++++++++++++++++++++++++++++++++++++++++

PicoScenes implements two standard-compatible Multi-LTF-in-Single-Frame (MLSF) approaches, 802.11ax High Doppler-format frame, and 802.11n frame with Extra Spatial Sounding (ESS).

.. _tx-rx-midamble:
802.11ax High Doppler-Format Frames
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In order to combating the high-doppler effect in moving scenarios, the High Doppler-format inserts *additional midamble HE-LTFs* into the data part of a HE-SU format frame every 10 or 20 data OFDM symbols. PicoScenes implements the encoding and decoding of this feature. Once the frame is long enough (via A-MPDU), up to 39 CSI measurements can be measured by a single frame. Users can enable this feature by ``--high-doppler`` option like the following command:

.. code-block:: bash

    PicoScenes "-d debug -i usrp --freq 5240 --preset TX_CBW_20_HESU --high-doppler 10 --repeat 1e9 --delay 5e3"

This command transmits HE-SU High-Doppler mode frames, which inserts midamble HE-LTFs every 10 data OFDM symbols. ``--high-doppler`` option has two possible values, 10 or 20.

.. note:: High Doppler-format is an optional feature of 802.11ax standard. AX200/AX210 doesn't support this mode.

.. _tx-rx-ess:
802.11n Extra Spatial Sounding (ESS) Frames
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

ESS feature can insert <3 HT-LTFs immediate after the normal HT-LTFs :math:`N_{ess}`, allowing Rx end to measure more CSI than the number of spatial streams :math:`N_{sts}`. Users can enable this feature by ``--ess`` option like the following command:

.. code-block:: bash

    PicoScenes "-d debug -i usrp --freq 5240 --ess 2 --repeat 1e9 --delay 5e3"

This command transmits 802.11n frames with 2 additional ESS HT-LTFs (via option ``--ess 2``).

.. note:: ESS is an optional feature of 802.11n standard. QCA9300 and IWL5300 support this feature, while AX200/AX210 not.

.. _channel-impairment-simulation:
Channel Impairment Simulation
++++++++++++++++++++++++++++++++++

.. todo:: need to be verified.

.. _dual-split-merge:
Dual-Channel Spectrum Splitting and Stitching (Experimental)
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

.. _parallel-decoding:
Multi-Thread Rx Decoding (Experimental)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

PicoScenes Rx baseband decoder features an experimental multi-threading capability, allowing pp to :math:`N_{CPU}` times increase in decoding performance. Enabling this feature is easy like used in the following example:

.. code-block:: bash

    PicoScenes "-d debug -i usrp --freq 5250 --preset RX_CBW_160 --mode logger --plot --mt 5" #<- Run on the first computer (Rx end)

The ``--mt 5`` option instructs the Rx decoder to use 5 threads in parallel decoding.


.. _ax200-measurements:
CSI Measurement using AX200/AX210 NICs
-----------------------------------------------------------

CSI extraction on Intel AX210/AX200 and particularly the 6 GHz band access are the exclusive features of PicoScenes platform. In this section, we showcase the most frequently used ISAC research scenarios:

#. :ref:`ax200-wifi-ap`
#. :ref:`ax200-monitor`
#. :ref:`ax200-monitor-injection`
#. :ref:`ax200-monitor-injection-mcs-antenna`
#. :ref:`live-channel-bw-changing`
#. :ref:`Multi-NIC-on-Single-Computer`

.. _ax200-wifi-ap:
CSI Measurement from Associated Wi-Fi AP
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

Fully-Passive CSI Measurement in Monitor Mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The AX200/AX210 NIC is capable of measuring CSI for the 802.11a/g/n/ac/ax frames observed in monitor mode. In this mode, the AX200/AX210 can passively measure CSI for all frames transmitted on the same channel, enabling association-free and injection-free fully passive CSI measurement.

To enable fully-passive CSI measurement, follow these three steps:

#. Determine the PhyPath ID of the NIC by running the ``array_status`` command in a terminal. Let's assume the PhyPath ID is ``3``.
#. Put the NIC into monitor mode by executing the command ``array_prepare_for_picoscenes 3 <CHANNEL_CONFIG>``. Replace *<CHANNEL_CONFIG>* with the desired channel configuration, which should be specified in the same format as the *freq* setting of the Linux *iw set freq* command. For example, it could be "2412 HT20", "5200 HT40-", "5745 80 5775", and so on. See :doc:`/channels` for details.
#. Run the command:

    .. code-block:: bash
    
        PicoScenes "-d debug -i 3 --mode logger --plot"

#. Once you have collected sufficient CSI data, exit PicoScenes by pressing Ctrl+C.

The above command has four program options *"-d debug -i 3 --mode logger --plot"*. These options have the same behavior as described in the :ref:`ax200-wifi-ap` Section.

The logged CSI data is stored in a file named ``rx_<Id>_<Time>.csi``, located in the *present working directory*. To analyze the data, open MATLAB and drag the .csi file into the *Command Window*. The file will be parsed and stored as a MATLAB variable named *rx_<Id>_<Time>*.

.. _ax200-monitor-injection:
Packet Injection based CSI Measurement (Tx with 802.11a/g/n/ac/ax Format and 20/40/80/160 MHz CBW)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The PicoScenes Driver enables AX200/AX210 to *packet-inject* 802.11a/g/n/ac/ax format frames with 20/40/80/160 MHz bandwidth and up to 2x2 MIMO. By combining this capability with the CSI measurement ability shown in the :ref:`ax200-monitor` section, PicoScenes provides fine-grained low-level control for CSI measurement.

To enable this test, you need two computers, each equipped with an AX200/AX210 NIC. Follow these three steps:

#. Determine the PhyPath ID of each NIC by using the ``array_status`` command. Let's assume the PhyPath ID is ``3`` for the first computer and ``4`` for the second.
#. Put both NICs into monitor mode by executing the command ``array_prepare_for_picoscenes <PHYPath ID> <CHANNEL_CONFIG>``. Replace *<CHANNEL_CONFIG>* with the desired channel configuration. In this scenario, we assume the researchers want to measure 160 MHz channel CSI. Run the following commands on the respective computers:

    .. code-block:: bash
        
        array_prepare_for_picoscenes 3 "5640 160 5250" #<-- Run on the first computer 
        array_prepare_for_picoscenes 4 "5640 160 5250" #<-- Run on the second computer
    
    Here, ``5640 160 5250`` represents a 160 MHz bandwidth channel centered at 5250 MHz with the primary channel at 5640 MHz. See :doc:`/channels` for details.

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

.. _ax200-monitor-injection-mcs-antenna:
Packet Injection with MCS Setting and Antenna Selection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

.. _live-channel-bw-changing:
Changing Channel and bandwidth in Realtime
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes provides ``--channel`` option to change channel settings in real-time, without re-execution of ``array_prepare_for_picoscenes`` script. For example, assuming you AX210/AX200 NIC, let's say ID <3>, is working at a 80 MHz CBW channel "5180 80 5210" (See :doc:`/channels` for details). Now if you want your NIC to listen to a 160 MHz CBW channel "5955 160 6025", you can directly run the command:

.. code-block:: bash

    PicoScenes "-d debug -i 3 --channel '5955 160 6025' --preset TX_CBW_160_HESU --mode logger --plot"

the option ``--channel '5955 160 6025'`` directly changes the channels without ``array_prepare_for_picoscenes``.

.. _Multi-NIC-on-Single-Computer:
Concurrent Multi-NIC Operation on a Single Computer
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes supports to install and control Wi-Fi NICs on a single computer. For multi-NIC installation, see :ref:`multi-nic-installation`. Assume you have two or more AX210 or AX200 NICs installed on your computer and you want to use one NIC for Tx and the rest for Rx and CSI measurement. For example, if you want to use NIC <3> for Tx, and the other NICs, like <4> and <5>, for Rx, you can use the following two commands:

.. code-block:: bash

    array_prepare_for_picoscenes "3 4 5" "5955 160 6025"

    PicoScenes "-d debug; // PicoScenes CLI input supports per-line comments
                -i 5 --mode logger   --plot; // Put <5> to logger mode, this line is non-blocking;
                -i 4 --mode logger   --plot; // Put <4> to logger mode, this line is non-blocking;
                -i 3 --mode injector --preset TX_CBW_160_HESU --repeat 1e5 --delay 5e3; // Let <3> do Tx, this line is blocking
                -q // program quit when Tx finished."

These two commands needs some explanations:

- The ``array_prepare_for_picoscenes`` adds monitor interfaces for the 3/4/5 NICs and change their working channels to '5955 160 6025'. See :doc:`/channels` for more examples. 
- The CLI input is a multi-line input, each line for a NIC. The line separation is the semicolon (**;**). 

  - The 2nd and 3rd lines put NIC <4> and <5> to logger mode and activate the corresponding live-plot. Please note *the logger mode is non-blocking*. It is the non-blocking design that actually enables the multi-NIC concurrent Rx and CSI measurement.
  - The 4th line specifies NIC <3> to transmit 160 MHz CBW HESU format frames for 10000 times.
  - The last line ``-q`` or ``--quit`` means *exit the program when no jobs*.

.. hint:: There is a more comprehensive explanation for this multi-line format, see :ref:`cli-format-explanation`.

.. _csi-by-5300-and-9300:
CSI Measurement using IWL5300 and QCA9300 NICs
-----------------------------------------------------------

IWL5300 and QCA9300 are classic Wi-Fi NICs released decade ago. Before AX210/AX200, we have invested lots of time on integrating them into PicoScenes platform. In this section, we cover the following major topics:

#. :ref:`iwl5300-wifi-ap`
#. :ref:`packet-injection-qcq9300-iwl5300`
#. :ref:`multi-nic-qca9300-iwl5300`
#. :ref:`qca9300_non-standard`

.. _iwl5300-wifi-ap:
CSI Measurement from Associated AP by IWL5300 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The IWL5300 NIC can also measure CSI for the 802.11n frames sent from the connected Wi-Fi AP. Assuming you have already connected the IWL5300 NIC to an 802.11n compatible Wi-Fi AP, then there are three steps to measure CSI from IWL5300:

#. Switching to CSI-extractable firmware. IWL5300 CSI extraction functionality relies on a customized firmware. PicoScenes provides ``switch5300Firmware`` command to switch between the *ordinary* and *CSI-extractable* firmware, see  :doc:`utilities` for more details. The following command switches to CSI-extractable firmware:

    .. code-block:: bash

        switch5300Firmware csi

#. Assuming the PhyPath ID is ``3``, execute the following command:

    .. code-block:: bash
    
        PicoScenes "-d debug -i 3 --mode logger --plot"

    The aforementioned command consists of four program options: *"-d debug -i 3 --mode logger --plot"*. These options can be interpreted as follows:

      - ``-d debug``: Modifies the display level of the logging service to debug;
      - ``-i 3 --mode logger``: Switches the device <3> to CSI logger mode;
      - ``--plot``: Live-plots the CSI measurements.

    For more detailed explanations, please see the :doc:`parameters` section.

#. Once you have collected sufficient CSI data, exit PicoScenes by pressing Ctrl+C. 

    The logged CSI data is stored in a file named ``rx_<Id>_<Time>.csi``, located in the *present working directory* of the first computer. To analyze the data, open MATLAB and drag the .csi file into the *Command Window*. The file will be parsed and stored as a MATLAB variable named *rx_<Id>_<Time>*.

.. hint:: 

    - The CSI measurement firmware of IWL5300 removes the encryption related functionalities, therefore it can only connect to the password-free open APs.
    - **QCA9300 does not support CSI measurement from the unmodified Wi-Fi AP associated**, because QCA9300 measures CSI for only the 802.11n frames hacked with *HT_Sounding* flag, which is not common case for Wi-Fi AP. A possible workaround is `Atheros CSI Tool <https://wands.sg/research/wifi/AtherosCSI/>`_, which uses the QCA9300-based AP and hacked the AP end.


.. _packet-injection-qcq9300-iwl5300:
Packet Injection based CSI Measurement
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes supports packet injection functionality using QCA9300 or IWL5300 as for AX210/AX200. Users can follow this guide :ref:`ax200-monitor-injection` to perform packet injection-based CSI measurement using QCA9300 and IWL5300. There are two things worth noting:

- Both QCA9300 and IWL5300 are 802.11n compatible NICs, supports up to 40 MHz CBW and MCS 7. Thus, users should ``array_prepare_for_picoscenes`` both models with 40 MHz CBW channels. See ::doc:`/channels` for details.
- There are *asymmetric interoperability issues* among QCA9300, IWL5300, AX210/AX200 and SDR devices, see :ref:`interoperability` for details.

.. _multi-nic-qca9300-iwl5300:
Concurrent Multi-NIC Operation for QCA9300 and IWL5300
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Similar to AX210/AX200, PicoScenes also supports multi-NIC operation for both the QCA9300 and IWL5300 models. Users can follow this guide:ref:`Multi-NIC-on-Single-Computer` to perform multi-NIC CSI measurement on QCA9300 and IWL5300, and do notice interoperability issue in :ref:`packet-injection-qcq9300-iwl5300`.

.. _qca9300_non-standard:
QCA9300 Operating with Non-Standard Channel, bandwidth, and Manual Rx Gain
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes provide low-level controls for QCA9300 in terms of carrier frequency, sampling rate, and manual Rx-gain.

- Carrier Frequency: QCA9300 hardware can actually operate in [2.2 - 2.9] GHz and [4.4 - 6.1] GHz range. Users can use ``--freq`` option to specify it, *e.g.*, ``--freq 2300e6``.
- Bandwidth: PicoScenes supports altering an ordinary 20 MHz CBW channel (HT20) to 2.5/5/7.5/10../30 MHz actual sampling rate, and 5/10/15/20..60 MHz actual sampling rate for an ordinary 40 MHz CBW channel (HT40+/-). Users can use  ``--rate`` option to specify it, *e.g.*, ``--rate 5e6``.
- Rx-Gain: PicoScenes supports overriding the automatic gain control (AGC) on QCA9300 with manual GC within a range of [0 - 66] dBm. Users can use ``--rx-gain`` to specify it, *e.g.*, ``--rx-gain 40``.
- AGC: Users can re-activate AGC for QCA9300 by option ``--agc``.

.. _interoperability:
Interoperability among SDR and COTS NICs
--------------------------------------------

The following table shows the interoperability among PicoScenes-supported devices. Each grid lists the transmission formats that can trigger frame reception and CSI measurement.

.. csv-table:: 
    :widths: 10,30,30,30,30

    "", "SDR (RX)", "AX210/AX200 (RX)", "QCA9300 (RX)[#]_", "IWL5300 (RX)[1]_"
    "SDR (TX)", "**Perfect**", "
    11a/g/n/ac/ax

    20/40/80/160 CBW

    Up to 2x2 MIMO

    No support for High-Doppler and ESS", "
    11n only

    20/40 CBW

    Up to 3x3 MIMO

    Support non-standard channel/bandwidth

    Support ESS", "
    11n only

    20/40 CBW

    Up to 3x3 MIMO
    
    Support ESS"
    "AX210/AX200 (TX)", "
    11a/g/n/ac/ax
    
    20/40/80/160 CBW
    
    Up to 2x2 MIMO
    ", "
    
    11a/g/n/ac/ax
    
    20/40/80/160 CBW
    
    Up to 2x2 MIMO
    ", "
    
    **Unavailable**
    ", "
    
    11n only
    
    20/40 CBW
    
    Up to 2x2 MIMO"
    "QCA9300 (TX)", "
    
    11n only
    
    20/40 CBW
    
    Up to 3x3 MIMO
    
    Support non-standard channel/bandwidth
    
    Support ESS", "
    
    11n only
    
    20/40 CBW
    
    Up to 2x2 MIMO", "
    
    11n only
    
    20/40 CBW
    
    Up to 3x3 MIMO
    
    Support non-standard channel/bandwidth
    
    Support ESS", "
    
    11n only
    
    20/40 CBW
    
    Up to 3x3 MIMO
    
    Support ESS"
    "IWL5300 (TX)", "
    
    11n only
    
    20/40 CBW
    
    Up to 3x3 MIMO", "
    
    11n only
    
    20/40 CBW
    
    Up to 2x2 MIMO", "
    
    **Unavailable**", "
    
    11n only
    
    20/40 CBW
    
    Up to 3x3 MIMO
    "

.. [#] QCA9300 measures CSI only for 802.11n format frames with *HT-Sound* flag *ON*; while IWL5300 does not measures CSI for *HT-Sound=ON* frames. This contradiction means QCA9300 and IWL5300 cannot measure CSI for same frames. PicoScenes by default sets *HT-Sound=ON* for 802.11n frames. For IWL5300 Rx end, users should append ``--5300`` to Tx end commands.