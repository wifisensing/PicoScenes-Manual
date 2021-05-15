CSI Measurement using PicoScenes
=================================================

On this page, we list some of the most frequently used Wi-Fi sensing scenarios and how they are supported by PicoScenes. In each scenario, we provide a takeaway bash script that users can perform the experiment right away.


.. important:: In this section, we assume you have already installed the PicoScenes software and the supported hardware. Not sure for that? See :doc:`installation` ahead.

.. _specify_nic:

Before Getting Started: Device Naming
-----------------------------------------------------------------------------

In PicoScenes, a reliable and easy-to-use device naming protocol (for both the commercial Wi-Fi NIC and SDR devices) is required to support the multi-NIC concurrent operation. In the following, we introduce the naming protocols for the commercial Wi-Fi NICs, SDR and the Virtual SDR devices.

For Commercial Wi-Fi NICs
~~~~~~~~~~~~~~~~~~~~~~~~~~

Open a terminal and run ``array_status``. After a second or two, a list of all the PCI-E based Wi-Fi NICs will be shown in the terminal. The following screenshot shows a sample device list.

.. figure:: /images/array_status.png
   :figwidth: 600px
   :target: /images/array_status.png
   :align: center

   Each Wi-Fi NIC has `four` IDs.

Looking at the first four columns of the output, ``array_status`` provides four IDs for each NIC, namely, PhyPath, PhyId, DeviceId and MonId. We first explain the latter three IDs and then PhyPath.

- **PhyId**: this is the system level *Physical ID* assigned by the Linux `mac80211` module. This ID is mainly used for low-level hardware control. This ID is subjected to change on every reboot.
- **DevId**: this is the system level *Device ID* assigned by the Linux `mac80211` module. This ID is mainly used for normal Wi-Fi connections. This ID is subjected to change on every reboot.
- **MonId**: this is the *Monitor interface ID* for a Wi-Fi NIC. The monitor interface and its ID can be created and assigned by the user. This ID is mainly used for traffic monitoring and packet injection. User can change this ID at any time.

You may have noticed the problem that the system-assigned IDs are not consistent across reboots, which inconveniences the selection from multiple NICs. To overcome this problem, we devise a new ID, named PhyPath, which is as listed in the first column of the screenshot. The biggest advantage is that **PhyPath is bound to the PCI-E connection hierarchy, consistent across reboots and even system reinstallations**. For example, a Wi-Fi NIC with PhyPath ``3`` indicates that it is the third device in the PCI-E hierarchy, and a Wi-Fi NIC with PhyPath ``53`` indicates that the position of this NIC in the PCI-E hierarchy is the 3rd leaf node of the 5th branch node. PhyPath is supported throughout the PicoScenes system, including the PicoScenes program, plugins and bash scripts. We recommend users use PhyPath in all scenarios.

For USRP Devices
~~~~~~~~~~~~~~~~~~~~

We devise a simple and intuitive naming protocol for USRP devices: ``usrp<IPADDRESS_or_RESOURCEID_or_SERIALID_or_DEVICENAME>``. For example, for a USRP X310 device with ip-addr=192.168.40.2, serial=DID1234, name=myX310 or resourceId=RID4567, it can be represented by **four** IDs: ``usrp192.168.40.2``, ``usrpDID1234``, ``usrpmyX310`` or ``usrpRID4567``. This naming protocol also supports the combined form of multiple USRP devices. For example, the combination of two USRP X310 devices (with IP addresses of 192.168.40.2 and 192.168.41.2) can be represented by ``usrp192.168.40.2,192.168.41.2``.

.. important:: The order of the IP addresses affects the order of the TX/RX channels! For example, the 0th and 3rd channels of the combined USRP ``usrp192.168.40.2,192.168.41.2`` refer to the first and the the second channel of the devices with the IP addresses of 192.168.40.2 and 192.168.41.2, respectively.

For Virtual SDR Devices
~~~~~~~~~~~~~~~~~~~~~~~~~

The Virtual SDR device adopts the naming pattern of ``virtualsdr<ANY_GIVEN_ID>``, *e.g.*, ``virtualsdr0``, ``virtualsdr_astringId`` or the simplest ``virtualsdr``. Since a Virtual SDR device can have up to 8 TX/RX channels, we don't support multi-device combination for Virtual SDR devices.


CSI Measurement by PicoScenes on Commercial Wi-Fi NICs
-----------------------------------------------------------

.. _iwl5300-wifi-ap:

IWL5300 + Wi-Fi AP (Difficulty Level: Beginner)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The IWL5300 NIC can measure CSI for the 802.11n frames sent from the connected Wi-Fi AP. By creating Wi-Fi traffic, for example by `ping` command, we can obtain the CSI measurement. 

Assuming you have already connected the IWL5300 NIC to an 802.11n compatible Wi-Fi AP, then there are only three steps to measure CSI from IWL5300:

#. Lookup the IWL5300 NIC's PhyPath ID by ``array_status``. 
#. Assume the PhyPath is ``3``, then run command ``PicoScenes -d debug -i 3 --mode logger`` in a terminal.
#. Exit CSI logging by pressing Ctrl+C.

The above command has three program options *"-d debug -i 3 --mode logger"*. They can be interpreted as *"PicoScenes changes the display level log message to debug (-d debug); makes the device with an Id of 3 switch to the CSI logger mode (-i 3 --mode logger)"*. See :doc:`parameters` for more detailed explanations.

The logged CSI data is stored in a ``rx_<Id>_<Time>.csi`` file in the *present working directory*. Open MATLAB, drag the .csi file into the Command Window, the file will be parsed and stored as a MATLAB variable named *rx_<Id>_<Time>*.

If you want to learn more details, you may download and run the following bash script: 
:download:`2_2_1 <_static/2_2_1.sh>` 

.. hint:: The CSI measurement firmware of IWL5300 removes the encryption related functionalities, therefore it can connect to the password-free APs. PicoScenes also provides a convenient ``switch5300Firmware`` script to switch between the normal and CSI measurement firmwares for IWL5300 NICs. For more information, you may refer to :doc:`utilities`.

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

If you want to learn more in detail, please download the source code to view. 
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

If you want to learn more in detail, please download the source code to view. 
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

If you want to learn more in detail, please download the source code to view. 
:download:`2_2_4 <_static/2_2_4.sh>` 

.. _dual_nics_scan:

Two QCA9300/IWL5300 NICs performs round trip CSI measurement while scans wide spectrum (Difficulty Level: Medium)
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

If you want to learn more in detail, please download the source code to view. 
:download:`2_2_5 <_static/2_2_5.sh>` 

Two QCA9300 NICs scans both the spectrum and bandwidth (Difficulty Level: Medium)
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

If you want to learn more in detail, please download the source code to view. 
:download:`2_2_6 <_static/2_2_6.sh>` 

Two QCA9300 NICs scans both the spectrum and bandwidth, with advanced measurement settings (Difficulty Level: Medium Plus)
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

If you want to learn more in detail, please download the source code to view. 
:download:`2_2_7 <_static/2_2_7.sh>` 

SDR-based measurement scenarios
---------------------------------------------

PicoScenes embeds the high-performance software implementation of 802.11a/g/n/ac/ax between the SDR driver and high-level `Frontend` abstraction. In this way, for the higher level plugins, SDR are just the same as commercial Wi-Fi NICs. From the perspective of the PicoScenes command line interface, All you need to do to switch from commercial Wi-Fi NICs-based measurement to the SDR devices-based measurement is to replace the NIC ID to USRP ID, e.g., ``-i 3`` to ``-i usrp192.168.10.2``. `This rules applies to all the above measurement scenarios`. In the following, we only list several measurement scenarios exclusive to SDR-based frontends.

Listening to Wi-Fi Traffic, Measure CSI for 802.11a/g/n/ac/ax protocol frames (Difficulty Level: Beginner)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is the most frequently used CSI measurement scenario for SDR-based frontend. To fully demonstrate the capability of PicoScenes, we assume you use the powerful USRP X310 with UBX-160 daughterboard as the RF frontend, which supports up to 200 MHz baseband sampling rate and 10 to 6000 MHz carrier frequency range, the following bash script opens a 2x2 MIMO Rx channels, listens and measures CSI for all the overheard Wi-Fi packets in 5815 MHz channel with 40 MHz bandwidth, regardless of the protocols.

.. code-block:: bash

    #!/bin/sh -e 

    PicoScenes "-d debug;
                -i usrp192.168.40.2 --mode logger --freq 5815e6 --rate 40e6 --rx-cbw 40 --rx-channel 0,1 --rx-ant TX/RX --rx-gain 15 
                "

The above command introduces four SDR-exclusive and Rx-related options: ``--rx-cbw``, ``--rx-channel``, ``--rx-ant`` and ``--rx-gain``. ``--rx-cbw 40`` specifies the Rx baseband to decode any incoming Wi-Fi signals as 40 MHz CBW format. ``--rx-channel 0,1`` specifies to receives the signals from 0-th and 1st channels of X310, which enables the 2x2 receiver side MIMO. ``--rx-ant TX/TX`` specifies to use the TX/RX antenna as the Rx antenna for both the 0-th and 1st channels (Most USRP daughterboards has two antennas TX/RX and RX2. As the name implies TX/RX can be used for both transmission and reception). Last, ``--rx-gain 15`` amplifies the received signals by 15 dB to improve the Rx SNR, and this value should be adjusted according to the Tx end transmission power (--txpower option in PicoScenes) and the measurement scenario.  Users may refer to :doc:`parameters` for more detailed explanations.

If you want to learn more in detail, please download the source code to view. 
:download:`2_3_1 <_static/2_3_1.sh>` 

USRP injects Packets, QCA9300/IWL5300 measure CSI (Difficulty Level: Easy)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes can also inject 802.11a/g/n/ac/ax compatible packets. The following example bash script injects 802.11ac packets in 5815 MHz channel with 40 MHz bandwidth, two spatial streams (:math:`N_{STS}=2`) and MCS 4.

.. code-block:: bash

    #!/bin/sh -e 

    PicoScenes "-d debug;
                -i usrp192.168.40.2 --mode injector --freq 5815e6 --rate 50e6 --cbw 80 --code ldpc --format vht --tx-channel 0,1 --sts 2 --mcs 4 --txpower 15 
                "

The above command introduces two SDR-exclusive and Tx-related options: ``--format`` and ``--tx-channel``. ``--format vht`` specifies the PicoScenes baseband to transmit the signal in 802.11ac (Very High Throughput, VHT) format. ``--tx-channel 0,1`` assigns the 0-th and 1st channels for transmission to support the following ``--sts 2 --mcs 4`` MIMO transmission.

If you want to learn more in detail, please download the source code to view. 
:download:`2_3_2 <_static/2_3_2.sh>` 

Dual USRP, measure CSI under arbitrary bandwidth (Difficulty Level: Easy)
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

If you want to learn more in detail, please download the source code to view. 
:download:`2_3_3 <_static/2_3_3.sh>` 

Dual-USRP MIMO transmission or reception (Difficulty Level: Easy)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes can currently combine two USRPs to form a 4x4 MIMO array. The following bash script combines four USRP X310s (each with two UBX-160 daughterboards) two by two to demonstrate 4x4 MIMO packet injection and CSI measurement.

.. code-block:: bash

    #!/bin/sh -e 

    PicoScenes "-d debug;
                -i usrp192.168.42.2,192.168.43.2 --mode logger --freq 5815e6 --rate 20e6 --cbw 20 --rx-channel 0,1,2,3 --rx-gain 15; 
                -i usrp192.168.40.2,192.168.41.2 --mode injector --freq 5815e6 --rate 20e6 --cbw 20 --format vht --tx-channel 0,1,2,3 --sts 4 --mcs 1 --txpower 15 --repeat 1000 --delay 5e3;
                -q
                "

The above command combines 4 USRP X310s two by two to form the a 4x4 MIMO transmitter and 4x4 MIMO receiver. Both sides use ``--tx-channel 0,1,2,3`` and ``--rx-channel 0,1,2,3``, to specify 4 transmission/receiving antennas, respectively.

If you want to learn more in detail, please download the source code to view. 
:download:`2_3_4 <_static/2_3_4.sh>` 