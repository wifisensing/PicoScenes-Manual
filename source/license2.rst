PicoScenes License Plan (PSLP) 
=======================================

The PicoScenes License Plan (PSLP) plays a vital role in supporting the long-term development of the PicoScenes system.

Currently, PSLP v1.0 offers two license options: 

- **Free License** (FL): The FL is free of charge but comes with limited access to advanced features. 
- **Power User License** (PUL): PUL users pay a minimal license fee and gain full access to all PicoScenes features along with timely technical support. It has two subtype:

    - **Transferable License (PUL-TL)**: The PUL-TL allows users to activate and use the license on different computers. However, only one computer can access the license at a time. Users can conveniently transfer the license between computers as needed, providing flexibility for multi-device usage scenarios.
    - **Device-Bound License (PUL-DBL)**: The PUL-DBL directly binds the license to a specific COTS NICs or NI USRP devices. Users gain immediate and full access to the licensed features without the need for activation, once the licensed device is detected by the PicoScenes platform software. This model is suitable for dedicated access on specific devices, offering enhanced security and control.

.. csv-table:: Comparisons of PSLP Options
    :header: "PSLP Option", "Pros", "Cons", "Price"

    "PSLP-FL", "
    - Nice documentation on usage at `ps.zpj.io <https://ps.zpj.io>`_
    - Regular upgrades via Debian *apt* facility
    - Supporting to run self-made PicoScenes plugin
    - Public technical support via `Issue Tracker <https://gitlab.com/wifisensing/picoscenes-issue-tracker>`_", "
    - No advanced features. See :ref:`PSLP-License-Details` for details.
    - Online validation (frequent)", "Free"
    "PSLP-TL", "
    - *All Pros of PSLP-FL* 
    - *Accessing all advanced features*
    - *Timely technical support on IM*
    - Transferable to other computers", "
    - Online validation (less frequent)", "4366 RMB or 600 USD"
    "PSLP-DBL", "
    - *All Pros of PSLP-FL*
    - *Accessing all advanced features*
    - *Timely technical support on IM*
    - Faster program start
    - Long-term offline operating", "
    - Device bound, not transferable
    - Only for NI USRP SDR devices
    - *Available only in China mainland*", "
    - 3000 RMB or 400 USD or,
    - Discounted bundle pricing with NI USRP hardware"

.. csv-table:: Comparisons of PSLP Options
    :header: "", "PSLP-FL (Free)", "PSLP-TL (Paid)", "PSLP-DBL (Paid)"

    "**Pros**", "
    - Nice documentation on usage at `ps.zpj.io <https://ps.zpj.io>`_
    - Regular upgrades via Debian *apt* facility
    - Supporting to run self-made PicoScenes plugin
    - Public technical support via `Issue Tracker <https://gitlab.com/wifisensing/picoscenes-issue-tracker>`_", "
    - *All Pros of PSLP-FL* 
    - *Accessing all advanced features*
    - *Timely technical support on IM*
    - Transferable to other computers", "
    - *All Pros of PSLP-FL*
    - *Accessing all advanced features*
    - *Timely technical support on IM*
    - Faster program start
    - Long-term offline operating"
    "**Cons**", "
    - No advanced features. See :ref:`PSLP-License-Details` for details.
    - Online validation (frequent)", "
    - Online validation (less frequent)", "
    - Device bound, not transferable
    - Only for NI USRP SDR devices
    - *Available only in China mainland*"
        "**Pricing**", "Free", "4366 RMB or 600 USD", "
    - 3000 RMB or 400 USD or,
    - Discounted bundle pricing with NI USRP hardware"

.. _PSLP-License-Details:

PSLP v1.0
-----------------------------

We divide the PSLP into three large feature sets: :ref:`license_techinical_support`, :ref:`license_platform_features`, and support for CSI hardware (:ref:`license_ax210`, :ref:`license_ax200`, :ref:`license_qca9300`, :ref:`license_iwl5300`, and SDR)**.

.. _license_techinical_support:
Technical Support
^^^^^^^^^^^^^^^^^^

.. csv-table:: Three Aspects Of Technical Support
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 60,15,12,9

    "Good documentation","https://ps.zpj.io","**✓**","**✓**","**v1.0**"
    "Issue tracker-based technical support","https://gitlab.com/wifisensing/picoscenes-issue-tracker","**✓**","**✓**","**v1.0**"
    "Very timely and targeted technical support via IM","Providing quick technical support on WeChat or other IM","","**✓**","**v1.0**"

.. _license_platform_features:
Platform Features
^^^^^^^^^^^^^^^^^^^^^^^
.. csv-table:: Platform Features
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 60, 15,12,9

    "Debian apt-based installation, upgrade and uninstallation","Fresh new installation can be as short as 10 minutes.","**✓**","**✓**","**v1.0**"
    "PicoScenes MATLAB Toolbox","Parsing the .csi file in MATLAB; auto-upgradable","**✓**","**✓**","**v1.0**"
    "Using and Developing PicoScenes Plugins","PicoScenes Plugin Development Kit is open sourced","**✓**","**✓**","**v1.0**"
    "Concurrent Multi-process of PicoScenes","Multi-Process may be easier for certain complex control","","**✓**","**v1.0**"
    "Multiple COTS NICs or SDR Devices","Support Multi-NIC/USRP hybrid frontend array","✓(limited, 2 device max)","**✓**","**v1.0**"

.. _license_ax210:
AX210
^^^^^^^^^^^^^^^^^^^^^^^

**AX210 inherits other features of AX200**

.. csv-table:: Features Supported By Ax210
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 50, 20,12,9

    "6-GHz Band Access","Accessing the full 6-GHz band [5955, 7115] MHz","✓(limited,accessible frequency band is [5955,6415] MHz)","**✓**","**v1.0**"

.. _license_ax200:
AX200
^^^^^^^^^^^^^^^^^^^^^^^

.. csv-table:: Features Supported By Ax200
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 50, 20,12,9

    "CSI measurement via AP connection","CSI measurement by connecting to Wi-Fi AP, supporting all protocol (11a/g/n/ac/ax), all bandwidths (20/40/80/160 MHz) and all bands (2.4/5 GHz)","**✓**","**✓**","**v1.0**"
    "CSI measurement by “Monitor mode + Packet Injection”","CSI measurement for the overheard frames in monitor mode, supporting all protocols (11a/g/n/ac/ax), all bandwidths (20/40/80/160 MHz) and all bands (2.4/5 GHz)","**✓**","**✓**","**v1.0**"
    "Packet Injection in 11a/g/n/ac/ax format with 20/40 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","**✓**","**✓**","**v1.0**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for AX200(Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**","**v1.0**"
    "Change channel and bandwidth in real-time","Direct channel/CBW changing via API or command options","**✓**","**✓**","**v1.0**"
    "Packet Injection in 11ac/ax format with 80/160 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 80/160 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","✓(limited, packet injection rate < = 45pkts)","**✓**","**v1.0**"
    "CSI measurement for all source MAC address","CSI measurement for all the overheard frames which are with different source MAC address","✓(limited，just for the first 6 received MAC addresses)","**✓**","**v1.0**"
    "Obtain Fine-Timing Measurement (FTM) clock count","The raw clock count from the 320 MHz baseband clock. About 4s a round. Useful for precise synchronization","","**✓**","**v1.0**"
    "CSI measurement for the specified frame types","CSI measurement for the specified frame types, e.g., measuring CSI only for Beacon Frames","","**✓**","**v1.0**"
    "Get more complete CSI information","Get reserved CSI header field","","**✓**","**v1.0**"

.. _license_qca9300:
QCA9300
^^^^^^^^^^^^^^^^^^^^^^^
.. csv-table:: Features Supported By QCA9300
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 50, 20,12,9

    "CSI measurement by “Monitor mode + Packet Injection”","QCA9300 NIC hardware reports CSI only for 11n frames with HT-rate flag not_sounding=of","**✓**","**✓**","**v1.0**"
    "Packet Injection in 11a/g/n/ac/ax format with 20/40 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800 ns Guard Interval (GI), BCC/LDPC coding and not_sounding flag. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","**✓**","**✓**","**v1.0**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for QCA9300(Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**","**v1.0**"
    "Tx chain specification","Specify which Tx chains are used for Tx","**✓**","**✓**","**v1.0**"
    "Rx chain specification","Specify which Rx chains are used for Rx","**✓**","**✓**","**v1.0**"
    "CSI measurement for 11n frames with ESS feature on","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","**✓**","**✓**","**v1.0**"
    "Access non-standard carrier frequency range","QCA9300 NIC hardware can operate in [2.2-2.9] and [4.4-6.1] GHz carrier frequency range with fine granularity","✓Limited, [2.3-2.6] GHz only","**✓**","**v1.0**"
    "Access non-standard baseband sampling rate","QCA9300 NIC baseband can operate in [2.5-80] MHz baseband sampling rate with 2.5 MHz step","✓(Limited, 10/30 MHz only)","**✓**","**v1.0**"
    "Manual Rx gain control","Turning off the hardware AGC and obtaining stable CSI measurement. Manual Rx control within [0, 66] dBm.","✓(Limited, [0-22] dBm only)","**✓**","**v1.0**"
    "Inject ESS-enabled 11n frames","Achieving dual-CSI measurement from 1-stream packet on IWL5300/QCA9300/USRP receiver. AX200/AX210 doesn’t support ESS measurement","","**✓**","**v1.0**"

.. _license_iwl5300:
IWL5300
^^^^^^^^^^^^^^^^^^^^^^^
.. csv-table:: Features Supported By IWL5300
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30, 50, 20,12,9

    "CSI measurement via AP connection","IWL5300 must be connected to 11n format Open System AP","**✓**","**✓**","**v1.0**"
    "CSI measurement by “Monitor mode + Packet Injection”","IWL5300 reports CSI only for the 11n frames sent to a magic MAC address","**✓**","**✓**","**v1.0**"
    "Packet Injection with 11a/g/n format","Capable of specifying 20/40 MHz bandwidth, MCS, MIMO, 400/800 ns GI","**✓**","**✓**","**v1.0**"
    "Channel changing and bandwidth in real-time","Direct channel/CBW changing via API or command options","**✓**","**✓**","**v1.0**"
    "Switch IWL5300 firmware without reboot","Switch between the special CSI measurement and ordinary firmware","**✓**","**✓**","**v1.0**"
    "Tx chain specification","Specify which Tx chains are used for Tx","**✓**","**✓**","**v1.0**"
    "Rx chain specification","Specify which Rx chains are used for Rx","**✓**","**✓**","**v1.0**"
    "CSI measurement for 11n frames with ESS","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","**✓**","**✓**","**v1.0**"

USRP
^^^^^^^^^^^^^^^^^^^^^^^
.. csv-table:: Features Supported By USRP
    :header: "Feature", "Feature Description","FL","PUL","Version"
    :widths: 30,50,20,12,9

    "Support all USRP models","Tests pass on B210/N210/X310/N310; E3x0/X4x0 not tested","**✓**","**✓**","**v1.0**"
    "Multi-USRP combination","Multiple N2x0 or X3x0 USRPs can be merged into one MIMO USRP","","**✓**","**v1.0**"
    "Access non-standard carrier frequency range","Should be within the range of USRP daughterboard","✓(Limited, [2.3-2.6] GHz only)","**✓**","**v1.0**"
    "Access non-standard sampling rate range","Should be within the range of USRP motherboard","✓(Limited, 10/30 MHz only)","**✓**","**v1.0**"
    "Manual Rx gain control","PicoScenes on SDR does not implement AGC, therefore manual RX gain control","**✓**","**✓**","**v1.0**"
    "Tx chain specification","Specify which Tx chains are used for Tx","✓(Limited, up to 2 channels)","**✓**","**v1.0**"
    "Tx chain specification","Specify which Rx chains are used for Rx","✓(Limited, up to 2 channels)","**✓**","**v1.0**"
    "Record Tx baseband signal","Record Tx baseband signal to file","","**✓**","**v1.0**"
    "Replay Tx baseband signa","Transmit the pre-generated or recorded Tx baseband signal","","**✓**","**v1.0**"
    "Record Rx baseband signal","Record Rx baseband signals to file, i.e., the raw I/Q signals","**✓**","**✓**","**v1.0**"
    "Replay Rx baseband signal","Override the Rx stream with the pre-generated or recorded Rx signals, suitable for off-line Rx signal decoding","**✓**","**✓**","**v1.0**"
    "TX CFO","Resample the Tx baseband signal and exert extra Carrier Frequency Offset (CFO)","","**✓**","**v1.0**"
    "TX SFO","Resample the Tx baseband signal and exert extra Sampling Frequency Offset (SFO)","","**✓**","**v1.0**"
    "RX CFO","Resample the Rx baseband signal and exert extra Carrier Frequency Offset (CFO)","","**✓**","**v1.0**"
    "RX SFO","Resample the Rx baseband signal and exert extra Sampling Frequency Offset (SFO)","","**✓**","**v1.0**"
    "Tx Resampling","Up-sampling the Tx baseband signal to W/A USRP integer factor problem","✓(Limited, only 1.0 and 1.25)","**✓**","**v1.0**"
    "Rx Resampling","Down-sampling the Rx baseband signal to W/A USRP integer factor problem","✓(Limited, only 0.8 and 1.0)","**✓**","**v1.0**"
    "Tx I/Q Imbalance","Add Tx I/Q imbalance factor (mag and phase)","","**✓**","**v1.0**"
    "Rx I/Q Imbalance","Add Rx I/Q imbalance factor (mag and phase)","","**✓**","**v1.0**"
    "CSI measurement for frames with 20 MHz bandwidth","Note: packet loss is inevitable for software-based SDR baseband. MIMO/ large bandwidth/LDPC/MU-MIMO/OFDMA will cause more packet loss.","✓(Limited, up to 2x2 MIMO)","**✓**","**v1.0**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for USRP (Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**","**v1.0**"
    "Inject packets that can trigger CSI measurement on QCA9300","Setting HT-rate flag not_sounding=Off by default","**✓**","**✓**","**v1.0**"
    "CSI measurement for frames with 40/80/160 MHz bandwidth","Note: packet loss is inevitable for software-based SDR baseband. MIMO/ large bandwidth/LDPC/MU-MIMO/OFDMA will cause more packet loss.","","**✓**","**v1.0**"
    "Packet Injection in 11a/g/n/ac/ax format with 20 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","✓(Limited, up to 2x2 MIMO)","**✓**","**v1.0**"
    "Inject ESS-enabled 11n frames","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","","**✓**","**v1.0**"
    "Packet Injection in 11a/g/n/ac/ax format with 40/80/160 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 80/160 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","","**✓**","**v1.0**"
    "Batch Frame generation + Batch Packet Injection","Pre-generate frame signals with precise inter-frame spacing","","**✓**","**v1.0**"
    "Tx Signal Precoding for 11n/ac/ax","Tx signal precoding can be used to realize beamforming, phased array and arbitrary signal equalization","","**✓**","**v1.0**"
    "CSI measurement for any source MAC address","CSI measurement for all the overheard frames which are with different source MAC address","✓(limited, just for the first 6 received MAC addresses)","**✓**","**v1.0**"
    "Support external clock source","MIMO Cable/External Clock/GPS clock","**✓**","**✓**","**v1.0**"
    "Tx MIMO Beamforming","Specifying Tx steering matrix, used for beamforming and phased array","","**✓**","**v1.0**"
    "Obtain the L-LTF CSI","Return the L-LTF based CSI estimation","","**✓**","**v1.0**"
    "Obtain Pilot-subcarrier based CSI","Return the CSI composed of per-OFDM symbol pilot subcarriers","","**✓**","**v1.0**"
    "Obtain complete Rx baseband signal","Return the complete multi-channel baseband signals, starting from L-STF part","**✓**","**✓**","**v1.0**"

.. _payment:

Payment
-----------------

The license fee of PLSP v1.0 PUL is **8688 RMB or 1360 USD**.

**Bulk purchase discount:** purchasing N, N ≤ 7 subscriptions in one-time bulk will have a discount of  (N−1)*8% , e.g., 16% discount for 3 subscriptions in a one-time purchase. In addition, subscribing 2/3 years can have an extra 9%/18% discount. 

.. PicoScenes team will optimize the PLSP every two months and raise the subscription fee about 100 USD。

中国区用户点此淘宝链接 `PicoScenes软件订阅 <https://item.taobao.com/item.htm?id=660337543983>`_ 下单，可开具正规电子发票

The overseas payment channel is still under construction.