PicoScenes License Plan (PSLP) 
=======================================

License mechanism is a promising way to ensure more sustainable development of the PicoScenes system. For PicoScenes, we call it PicoScenes License Plan (PSLP). 

The current PSLP version is v0.8.1


PSLP v0.8.1
-----------------------------------------------

PSLP v0.8.1 is the August. 2022 version of PSLP. 

.. **TL;DR**: PSLP v0.8.1 offers **two license options, free and paid**. Compared to v0.1.11, this version relax several key features to Free License Users. The subscription fee of the paid license is still **8688 RMB or 1360 USD/computer/year** with an extra bulk purchase discount.

**License Types**: PSLP v0.8.1 has two license options: **Free License (FL)** and **Power User License (PUL)**. FL is permanently free of charge but with limited access to some advanced features. The PUL grants user to use all PicoScenes features on one computer, and users will pay the annual subscription fee. The PUL subscribers can switch their PULs to different computers.

**License Items**: The differences between FL and PUL are listed in :ref:`PSLP-License-Details`. This table is the most detailed list of the PicoScenes features.The accountability for this key license document can be tracked back to `this git commit <https://gitlab.com/wifisensing/PicoScenes-Manual/-/commit/7516ad5f81a3537ef20ad97abfc8602b21ed698f>`_ of the source code of this documentation site.

**License Timing**: From August 16, 2022, the v0.8.1 license was officially launched. After that, PicoScenes program will automatically switch to the FL v0.8.1 by default. The PUL subscriber can activate their PUL v0.8.1 using a license key or file.

PSLP Revision Update Log
-------------------------
.. csv-table:: PSLP Revision Update Log
    :header: "Affected PSLP Version", "Modifications"
    :widths: 30, 70

    "v0.1.10 -> v0.1.11","Add AX210 section"
    "v0.1.11 -> v0.2","Several key features relaxed for FL users"
    "v0.2 -> v0.2.2","Minor tweaks; More permissions are given for FL users"
    "v0.2.2 -> v0.2.3","Disable —tx-from-file and —tx-to-file options for FL users"
    "v0.2.3 -> v0.8.1","Access reserved CSI headers Infomation for PUL and give some permissions for FL users"

.. _PSLP-License-Details:

PSLP License Details v0.8.1
-----------------------------

Compared with the previous version, PSLP v0.8.1 allows to access reserved CSI headers Infomation for PUL users and give some permissions for FL users,including access to the 6G band and allow to Packet Injection in 11ac/ax format with 80/160MHz Channel bandwidth.

We divide the PSLP into three large feature sets: **the technical support**, **platform features**, and **support for CSI hardware (AX210, AX200, QCA9300, IWL5300, and USRP)**.

Technical Support
^^^^^^^^^^^^^^^^^^

According to the trail feedbacks over the past six months, **the main difference between FL and PUL is not the technical level, but technical support.**

.. csv-table:: Three Aspects Of Technical Support
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 60,15,12,9

    "Good documentation","https://ps.zpj.io","**✓**","**✓**","**v0.8.1**"
    "Issue tracker-based technical support","Reply in at most 36 hours","**✓**","**✓**","**v0.8.1**"
    "Very timely and targeted technical support via IM","Establish special technical support group on WeChat or other IM, providing real-time technical support if possible. Reply in 12 hours at most.","","**✓**","**v0.8.1**"

Platform Features
^^^^^^^^^^^^^^^^^^^^^^^
.. csv-table:: Platform Features
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 60, 15,12,9

    "Debian apt-based installation, upgrade and uninstallation","Fresh new installation can be as short as 10 minutes.","**✓**","**✓**","**v0.8.1**"
    "PicoScenes MATLAB Toolbox","Parsing the .csi file in MATLAB; auto-upgradable","**✓**","**✓**","**v0.8.1**"
    "PicoScenes Python Toolbox","Parsing the .csi file in Python","**✓**","**✓**","**v0.8.1**"
    "CSI live plot","Rx end plots CSI magnitude and phase in real time","**✓**","**✓**","**v0.8.1**"
    "PicoScenes Data format with forward compatibility","Forward compatibility guarantees the correct parsing of the old .csi data format during the future upgrade","**✓**","**✓**","**v0.8.1**"
    "Rich NIC control scripts","PCIE hierarchy-based NIC naming, batch configuration, etc.","**✓**","**✓**","**v0.8.1**"
    "Using and Developing PicoScenes Plugins","PicoScenes Plugin Development Kit is open sourced","**✓**","**✓**","**v0.8.1**"
    "Concurrent Multi-process of PicoScenes","Multi-Process may be easier for certain complex control","","**✓**","**v0.8.1**"
    "Multi-NIC or FrontEnd (>=2 COTS NICs or USRP)","Support Multi-NIC/USRP hybrid frontend array","✓(limited，2 frontends max)","**✓**","**v0.8.1**"

AX210
^^^^^^^^^^^^^^^^^^^^^^^

**AX210 inherits other features of AX200**

.. csv-table:: Features Supported By Ax210
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 50, 20,12,9

    "6-GHz Band Access","Accessing the full 6-GHz band [5955, 7115] MHz","✓(limited,accessible frequency band is [5955,6415] MHz)","**✓**","**v0.8.1**"

AX200
^^^^^^^^^^^^^^^^^^^^^^^

.. csv-table:: Features Supported By Ax200
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 50, 20,12,9

    "CSI measurement via AP connection","CSI measurement by connecting to Wi-Fi AP, supporting all protocol (11a/g/n/ac/ax), all bandwidths (20/40/80/160 MHz) and all bands (2.4/5 GHz)","**✓**","**✓**","**v0.8.1**"
    "CSI measurement by “Monitor mode + Packet Injection”","CSI measurement for the overheard frames in monitor mode, supporting all protocols (11a/g/n/ac/ax), all bandwidths (20/40/80/160 MHz) and all bands (2.4/5 GHz)","**✓**","**✓**","**v0.8.1**"
    "Packet Injection in 11a/g/n/ac/ax format with 20/40 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","**✓**","**✓**","**v0.8.1**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for AX200(Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**","**v0.8.1**"
    "Change channel and bandwidth in real-time","Direct channel/CBW changing via API or command options","**✓**","**✓**","**v0.8.1**"
    "Packet Injection in 11ac/ax format with 80/160 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 80/160 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","✓(limited, packet injection rate < = 45pkts)","**✓**","**v0.8.1**"
    "CSI measurement for all source MAC address","CSI measurement for all the overheard frames which are with different source MAC address","✓(limited，just for the first 6 received MAC addresses)","**✓**","**v0.8.1**"
    "Obtain Fine-Timing Measurement (FTM) clock count","The raw clock count from the 320 MHz baseband clock. About 4s a round. Useful for precise synchronization","","**✓**","**v0.8.1**"
    "CSI measurement for the specified frame types","CSI measurement for the specified frame types, e.g., measuring CSI only for Beacon Frames","","**✓**","**v0.8.1**"
    "Get more complete CSI information","Get reserved CSI header field","","**✓**","**v0.8.1**"

QCA9300
^^^^^^^^^^^^^^^^^^^^^^^
.. csv-table:: Features Supported By QCA9300
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 50, 20,12,9

    "CSI measurement by “Monitor mode + Packet Injection”","QCA9300 NIC hardware reports CSI only for 11n frames with HT-rate flag not_sounding=of","**✓**","**✓**","**v0.8.1**"
    "Packet Injection in 11a/g/n/ac/ax format with 20/40 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800 ns Guard Interval (GI), BCC/LDPC coding and not_sounding flag. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","**✓**","**✓**","**v0.8.1**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for QCA9300(Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**","**v0.8.1**"
    "Tx chain specification","Specify which Tx chains are used for Tx","**✓**","**✓**","**v0.8.1**"
    "Rx chain specification","Specify which Rx chains are used for Rx","**✓**","**✓**","**v0.8.1**"
    "CSI measurement for 11n frames with ESS feature on","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","**✓**","**✓**","**v0.8.1**"
    "Access non-standard carrier frequency range","QCA9300 NIC hardware can operate in [2.2-2.9] and [4.4-6.1] GHz carrier frequency range with fine granularity","✓Limited, [2.3-2.6] GHz only","**✓**","**v0.8.1**"
    "Access non-standard baseband sampling rate","QCA9300 NIC baseband can operate in [2.5-80] MHz baseband sampling rate with 2.5 MHz step","✓(Limited, 10/30 MHz only)","**✓**","**v0.8.1**"
    "Manual Rx gain control","Turning off the hardware AGC and obtaining stable CSI measurement. Manual Rx control within [0, 66] dBm.","✓(Limited, [0-22] dBm only)","**✓**","**v0.8.1**"
    "Inject ESS-enabled 11n frames","Achieving dual-CSI measurement from 1-stream packet on IWL5300/QCA9300/USRP receiver. AX200/AX210 doesn’t support ESS measurement","","**✓**","**v0.8.1**"

IWL5300
^^^^^^^^^^^^^^^^^^^^^^^
.. csv-table:: Features Supported By IWL5300
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 50, 20,12,9

    "CSI measurement via AP connection","IWL5300 must be connected to 11n format Open System AP","**✓**","**✓**","**v0.8.1**"
    "CSI measurement by “Monitor mode + Packet Injection”","IWL5300 reports CSI only for the 11n frames sent to a magic MAC address","**✓**","**✓**","**v0.8.1**"
    "Packet Injection with 11a/g/n format","Capable of specifying 20/40 MHz bandwidth, MCS, MIMO, 400/800 ns GI","**✓**","**✓**","**v0.8.1**"
    "Channel changing and bandwidth in real-time","Direct channel/CBW changing via API or command options","**✓**","**✓**","**v0.8.1**"
    "Switch IWL5300 firmware without reboot","Switch between the special CSI measurement and ordinary firmware","**✓**","**✓**","**v0.8.1**"
    "Tx chain specification","Specify which Tx chains are used for Tx","**✓**","**✓**","**v0.8.1**"
    "Rx chain specification","Specify which Rx chains are used for Rx","**✓**","**✓**","**v0.8.1**"
    "CSI measurement for 11n frames with ESS","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","**✓**","**✓**","**v0.8.1**"

USRP
^^^^^^^^^^^^^^^^^^^^^^^
.. csv-table:: Features Supported By USRP
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30,50,20,12,9

    "Support all USRP models","Tests pass on B210/N210/X310/N310; E3x0/X4x0 not tested","**✓**","**✓**","**v0.8.1**"
    "Multi-USRP combination","Multiple N2x0 or X3x0 USRPs can be merged into one MIMO USRP","","**✓**","**v0.8.1**"
    "Access non-standard carrier frequency range","Should be within the range of USRP daughterboard","✓(Limited, [2.3-2.6] GHz only)","**✓**","**v0.8.1**"
    "Access non-standard sampling rate range","Should be within the range of USRP motherboard","✓(Limited, 10/30 MHz only)","**✓**","**v0.8.1**"
    "Manual Rx gain control","PicoScenes on SDR does not implement AGC, therefore manual RX gain control","**✓**","**✓**","**v0.8.1**"
    "Tx chain specification","Specify which Tx chains are used for Tx","✓(Limited, up to 2 channels)","**✓**","**v0.8.1**"
    "Tx chain specification","Specify which Rx chains are used for Rx","✓(Limited, up to 2 channels)","**✓**","**v0.8.1**"
    "Record Tx baseband signal","Record Tx baseband signal to file","","**✓**","**v0.8.1**"
    "Replay Tx baseband signa","Transmit the pre-generated or recorded Tx baseband signal","","**✓**","**v0.8.1**"
    "Record Rx baseband signal","Record Rx baseband signals to file, i.e., the raw I/Q signals","**✓**","**✓**","**v0.8.1**"
    "Replay Rx baseband signal","Override the Rx stream with the pre-generated or recorded Rx signals, suitable for off-line Rx signal decoding","**✓**","**✓**","**v0.8.1**"
    "TX CFO","Resample the Tx baseband signal and exert extra Carrier Frequency Offset (CFO)","","**✓**","**v0.8.1**"
    "TX SFO","Resample the Tx baseband signal and exert extra Sampling Frequency Offset (SFO)","","**✓**","**v0.8.1**"
    "RX CFO","Resample the Rx baseband signal and exert extra Carrier Frequency Offset (CFO)","","**✓**","**v0.8.1**"
    "RX SFO","Resample the Rx baseband signal and exert extra Sampling Frequency Offset (SFO)","","**✓**","**v0.8.1**"
    "Tx Resampling","Up-sampling the Tx baseband signal to W/A USRP integer factor problem","✓(Limited, only 1.0 and 1.25)","**✓**","**v0.8.1**"
    "Rx Resampling","Down-sampling the Rx baseband signal to W/A USRP integer factor problem","✓(Limited, only 0.8 and 1.0)","**✓**","**v0.8.1**"
    "Tx I/Q Imbalance","Add Tx I/Q imbalance factor (mag and phase)","","**✓**","**v0.8.1**"
    "Rx I/Q Imbalance","Add Rx I/Q imbalance factor (mag and phase)","","**✓**","**v0.8.1**"
    "CSI measurement for frames with 20 MHz bandwidth","Note: packet loss is inevitable for software-based SDR baseband. MIMO/ large bandwidth/LDPC/MU-MIMO/OFDMA will cause more packet loss.","✓(Limited, up to 2x2 MIMO)","**✓**","**v0.8.1**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for USRP (Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**","**v0.8.1**"
    "Inject packets that can trigger CSI measurement on QCA9300","Setting HT-rate flag not_sounding=Off by default","**✓**","**✓**","**v0.8.1**"
    "CSI measurement for frames with 40/80/160 MHz bandwidth","Note: packet loss is inevitable for software-based SDR baseband. MIMO/ large bandwidth/LDPC/MU-MIMO/OFDMA will cause more packet loss.","","**✓**","**v0.8.1**"
    "Packet Injection in 11a/g/n/ac/ax format with 20 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","✓(Limited, up to 2x2 MIMO)","**✓**","**v0.8.1**"
    "Inject ESS-enabled 11n frames","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","","**✓**","**v0.8.1**"
    "Packet Injection in 11a/g/n/ac/ax format with 40/80/160 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 80/160 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","","**✓**","**v0.8.1**"
    "Batch Frame generation + Batch Packet Injection","Pre-generate frame signals with precise inter-frame spacing","","**✓**","**v0.8.1**"
    "Tx Signal Precoding for 11n/ac/ax","Tx signal precoding can be used to realize beamforming, phased array and arbitrary signal equalization","","**✓**","**v0.8.1**"
    "CSI measurement for any source MAC address","CSI measurement for all the overheard frames which are with different source MAC address","✓(limited, just for the first 6 received MAC addresses)","**✓**","**v0.8.1**"
    "Support external clock source","MIMO Cable/External Clock/GPS clock","**✓**","**✓**","**v0.8.1**"
    "Tx MIMO Beamforming","Specifying Tx steering matrix, used for beamforming and phased array","","**✓**","**v0.8.1**"
    "Obtain the L-LTF CSI","Return the L-LTF based CSI estimation","","**✓**","**v0.8.1**"
    "Obtain Pilot-subcarrier based CSI","Return the CSI composed of per-OFDM symbol pilot subcarriers","","**✓**","**v0.8.1**"
    "Obtain complete Rx baseband signal","Return the complete multi-channel baseband signals, starting from L-STF part","**✓**","**✓**","**v0.8.1**"

.. _payment:

Payment
-----------------

The subscription fee of PLSP v0.8.1 PUL is **8688 RMB or 1360 USD/computer/year**. 

**Bulk purchase discount:** purchasing N, N ≤ 7 subscriptions in one-time bulk will have a discount of  (N−1)*8% , e.g., 16% discount for 3 subscriptions in a one-time purchase. In addition, subscribing 2/3 years can have an extra 9%/18% discount. 

.. PicoScenes team will optimize the PLSP every two months and raise the subscription fee about 100 USD。

中国区用户点此淘宝链接 `PicoScenes软件订阅 <https://item.taobao.com/item.htm?id=660337543983>`_ 下单，可开具正规电子发票

The overseas payment channel is still under construction.