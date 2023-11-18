PicoScenes License Plan (PSLP) 
=======================================

The PicoScenes License Plan (PSLP) plays a vital role in supporting the long-term development of the PicoScenes system. The current (November 2023) PSLP version is v1.0.

Introducing PSLP
---------------------

PSLP v1.0 offers two license options: 

- **Free License (PSLP-FL)**: PSLP-FL is free of charge but comes with limited access to advanced features.
- **Pro License (PSLP-PRO)**: PSLP-PRO users pay a minimal license fee and gain full access to all PicoScenes features along with timely technical support. It has two subtypes:
    - **Transferable License (PSLP-PRO-TL)**: It allows users to activate and use the license on a single computer. Users can conveniently transfer the license between computers as needed, providing flexibility for multi-device usage scenarios.
    - **Device-Bound License (PSLP-PRO-DBL)**: *This option is only available in mainland China*. **This option binds a Pro License to a newly-bought NI USRP device from our partner store.** Compared to PSLP-PRO-TL, users of PSLP-PRO-DBL gain immediate and full access to the licensed features without explicit activation and online validation. This model is suitable for researches on newly-bought NI USRP hardware, offering faster program start, and long-term offline operation. *We offer discounted bundle pricing for this option*.

.. csv-table:: Comparisons of PSLP Options
    :header: "PSLP Option", "Pros", "Cons"

    "PSLP-FL", "
    - Nice documentation on usage at `ps.zpj.io <https://ps.zpj.io>`_
    - Regular upgrades via Debian *apt* facility
    - Supporting to run self-made PicoScenes plugin
    - Public technical support via `Issue Tracker <https://gitlab.com/wifisensing/picoscenes-issue-tracker>`_", "
    - Limited advanced features.
    - Online validation (frequent)"
    "PSLP-PRO-TL", "
    - *All Pro features listed in * :ref:`PSLP-License-Details`
    - *Accessing all advanced features*
    - *Timely technical support on IM*
    - Transferable to other computers", "
    - Online validation (less frequent)"
    "PSLP-PRO-DBL", "
    - *All Pro features listed in * :ref:`PSLP-License-Details`
    - *Accessing all advanced features*
    - *Timely technical support on IM*
    - **Discounted bundle pricing**
    - Out-of-box access to full feature 
    - Faster program start
    - Long-term offline operating", "
    - Device bound, not transferable
    - Only for NI USRP SDR devices
    - *Available only in China mainland*"

.. note:: PSLP-PUL v0.8.1 is converted to PSLP-PRO-TL in v1.0 automatically.

.. _PSLP-License-Details:

PSLP Details (v1.0)
-----------------------------

We divide the PSLP into three aspects: :ref:`license_technical_support`, :ref:`license_hardware_features`, and :ref:`license_platform_features`.

.. _license_technical_support:
Technical Support
++++++++++++++++++

.. csv-table:: PSLP Technical Support
    :header: "Feature", "Feature Description","FL","PRO (Both TL and DBL)"
    :widths: 30, 60,15,12

    "Good documentation","https://ps.zpj.io","**✓**","**✓**"
    "Issue tracker-based technical support","https://gitlab.com/wifisensing/picoscenes-issue-tracker","**✓**","**✓**"
    "Very timely technical support via IM","Providing quick technical support on WeChat or other IM","","**✓**"

.. _license_hardware_features:
Hardware Features
+++++++++++++++++++++++

PSLP has different feature access for different hardware: :ref:`license_sdr`, :ref:`license_ax210`, :ref:`license_ax200`, :ref:`license_qca9300` and :ref:`license_iwl5300`.


.. _license_sdr:
SDR (NI USRP Hardware and HackRF One)
+++++++++++++++++++++++++++++++++++++++++
.. csv-table:: Features Supported By USRP
    :header: "Feature", "Feature Description","FL","PRO (Both TL and DBL)"
    :widths: 30,50,20,12

    "Support NI USRP Models","See :ref:`csi_by_sdr`. Tests passed on B210/N210/X310/N310; E3x0/X4x0 not tested.","**✓**","**✓**"
    "Support HackRF One", "See :ref:`csi_by_sdr`","**✓**","**✓**"
    "Multi-USRP Combination","See :ref:`multi-channel-rx-single`, :ref:`multi-channel-rx-multi`, and :ref:`multi-channel-tx`","","**✓**"
    "Operating at non-Standard Channel (Carrier Frequency)","Frequency must be supported by hardware. See :ref:`non-standard-tx-rx`.","✓(Limited, [2.3-2.6] GHz only)","**✓**"
    "Operating with Non-Standard Bandwidth (Sampling Rate)","Sampling rate must be supported by hardware. See :ref:`non-standard-tx-rx`.","✓(Limited, 10 MHz and 30 MHz only)","**✓**"
    "Tx Gain Control","See :ref:`tx-gain-control`","**✓**","**✓**"
    "Rx Gain Control","See :ref:`rx-gain-control`","**✓**","**✓**"
    "Tx Chain Specification","See :ref:`multi-channel-tx`","✓(Limited, up to 2 channels)","**✓**"
    "Rx Chain Specification","See :ref:`multi-channel-rx-single` and :ref:`multi-channel-rx-multi`","✓(Limited, up to 2 channels)","**✓**"
    "Record Tx Baseband signal","Record Tx baseband signal to file (.bbsignals format)","","**✓**"
    "Replay Tx Baseband signal","Transmit the pre-generated or recorded Tx baseband signal","","**✓**"
    "Record Rx baseband signal","Record Rx baseband signals to file, i.e., the raw I/Q signals","**✓**","**✓**"
    "Replay Rx baseband signal","Override the Rx stream with the pre-generated or recorded Rx signals, suitable for off-line Rx signal decoding","**✓**","**✓**"
    "TX CFO","Resample the Tx baseband signal and exert extra Carrier Frequency Offset (CFO)","","**✓**"
    "TX SFO","Resample the Tx baseband signal and exert extra Sampling Frequency Offset (SFO)","","**✓**"
    "RX CFO","Resample the Rx baseband signal and exert extra Carrier Frequency Offset (CFO)","","**✓**"
    "RX SFO","Resample the Rx baseband signal and exert extra Sampling Frequency Offset (SFO)","","**✓**"
    "Tx Resampling","Up-sampling the Tx baseband signal to W/A USRP integer factor problem","✓(Limited, only 1.0 and 1.25)","**✓**"
    "Rx Resampling","Down-sampling the Rx baseband signal to W/A USRP integer factor problem","✓(Limited, only 0.8 and 1.0)","**✓**"
    "Tx I/Q Imbalance","Add Tx I/Q imbalance factor (mag and phase)","","**✓**"
    "Rx I/Q Imbalance","Add Rx I/Q imbalance factor (mag and phase)","","**✓**"
    "CSI measurement for frames with 20 MHz bandwidth","Note: packet loss is inevitable for software-based SDR baseband. MIMO/ large bandwidth/LDPC/MU-MIMO/OFDMA will cause more packet loss.","✓(Limited, up to 2x2 MIMO)","**✓**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for USRP (Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**"
    "Inject packets that can trigger CSI measurement on QCA9300","Setting HT-rate flag not_sounding=Off by default","**✓**","**✓**"
    "CSI measurement for frames with 40/80/160 MHz bandwidth","Note: packet loss is inevitable for software-based SDR baseband. MIMO/ large bandwidth/LDPC/MU-MIMO/OFDMA will cause more packet loss.","","**✓**"
    "Packet Injection in 11a/g/n/ac/ax format with 20 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","✓(Limited, up to 2x2 MIMO)","**✓**"
    "Inject ESS-enabled 11n frames","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","","**✓**"
    "Packet Injection in 11a/g/n/ac/ax format with 40/80/160 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 80/160 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","","**✓**"
    "Batch Frame generation + Batch Packet Injection","Pre-generate frame signals with precise inter-frame spacing","","**✓**"
    "Tx Signal Precoding for 11n/ac/ax","Tx signal precoding can be used to realize beamforming, phased array and arbitrary signal equalization","","**✓**"
    "CSI measurement for any source MAC address","CSI measurement for all the overheard frames which are with different source MAC address","✓(limited, just for the first 6 received MAC addresses)","**✓**"
    "Support external clock source","MIMO Cable/External Clock/GPS clock","**✓**","**✓**"
    "Tx MIMO Beamforming","Specifying Tx steering matrix, used for beamforming and phased array","","**✓**"
    "Obtain the L-LTF CSI","Return the L-LTF based CSI estimation","","**✓**"
    "Obtain Pilot-subcarrier based CSI","Return the CSI composed of per-OFDM symbol pilot subcarriers","","**✓**"
    "Obtain complete Rx baseband signal","Return the complete multi-channel baseband signals, starting from L-STF part","**✓**","**✓**"

.. _license_ax210:
AX210
+++++++++++++++++++++++

**AX210 inherits other features of AX200**

.. csv-table:: Features Supported By Ax210
    :header: "Feature", "Feature Description","FL","PRO (Both TL and DBL)"
    :widths: 30, 50, 20,12

    "6-GHz Band Access","Accessing the full 6-GHz band [5955, 7115] MHz","✓(limited,accessible frequency band is [5955,6415] MHz)","**✓**"

.. _license_ax200:
AX200
+++++++++++++++++++++++

.. csv-table:: Features Supported By Ax200
    :header: "Feature", "Feature Description","FL","PRO (Both TL and DBL)"
    :widths: 30, 50, 20,12,9

    "CSI measurement via AP connection","CSI measurement by connecting to Wi-Fi AP, supporting all protocol (11a/g/n/ac/ax), all bandwidths (20/40/80/160 MHz) and all bands (2.4/5 GHz)","**✓**","**✓**"
    "CSI measurement by “Monitor mode + Packet Injection”","CSI measurement for the overheard frames in monitor mode, supporting all protocols (11a/g/n/ac/ax), all bandwidths (20/40/80/160 MHz) and all bands (2.4/5 GHz)","**✓**","**✓**"
    "Packet Injection in 11a/g/n/ac/ax format with 20/40 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","**✓**","**✓**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for AX200(Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**"
    "Change channel and bandwidth in real-time","Direct channel/CBW changing via API or command options","**✓**","**✓**"
    "Packet Injection in 11ac/ax format with 80/160 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 80/160 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","✓(limited, packet injection rate < = 45pkts)","**✓**"
    "CSI measurement for all source MAC address","CSI measurement for all the overheard frames which are with different source MAC address","✓(limited，just for the first 6 received MAC addresses)","**✓**"
    "Obtain Fine-Timing Measurement (FTM) clock count","The raw clock count from the 320 MHz baseband clock. About 4s a round. Useful for precise synchronization","","**✓**"
    "CSI measurement for the specified frame types","CSI measurement for the specified frame types, e.g., measuring CSI only for Beacon Frames","","**✓**"
    "Get more complete CSI information","Get reserved CSI header field","","**✓**"

.. _license_qca9300:
QCA9300
+++++++++++++++++++++++
.. csv-table:: Features Supported By QCA9300
    :header: "Feature", "Feature Description","FL","PRO (Both TL and DBL)"
    :widths: 30, 50, 20,12,9

    "CSI measurement by “Monitor mode + Packet Injection”","QCA9300 NIC hardware reports CSI only for 11n frames with HT-rate flag not_sounding=of","**✓**","**✓**"
    "Packet Injection in 11a/g/n/ac/ax format with 20/40 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800 ns Guard Interval (GI), BCC/LDPC coding and not_sounding flag. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","**✓**","**✓**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for QCA9300(Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**"
    "Tx chain specification","Specify which Tx chains are used for Tx","**✓**","**✓**"
    "Rx chain specification","Specify which Rx chains are used for Rx","**✓**","**✓**"
    "CSI measurement for 11n frames with ESS feature on","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","**✓**","**✓**"
    "Access non-standard carrier frequency range","QCA9300 NIC hardware can operate in [2.2-2.9] and [4.4-6.1] GHz carrier frequency range with fine granularity","✓Limited, [2.3-2.6] GHz only","**✓**"
    "Access non-standard baseband sampling rate","QCA9300 NIC baseband can operate in [2.5-80] MHz baseband sampling rate with 2.5 MHz step","✓(Limited, 10/30 MHz only)","**✓**"
    "Manual Rx gain control","Turning off the hardware AGC and obtaining stable CSI measurement. Manual Rx control within [0, 66] dBm.","✓(Limited, [0-22] dBm only)","**✓**"
    "Inject ESS-enabled 11n frames","Achieving dual-CSI measurement from 1-stream packet on IWL5300/QCA9300/USRP receiver. AX200/AX210 doesn’t support ESS measurement","","**✓**"

.. _license_iwl5300:
IWL5300
+++++++++++++++++++++++
.. csv-table:: Features Supported By IWL5300
    :header: "Feature", "Feature Description","FL","PRO (Both TL and DBL)"
    :widths: 30, 50, 20,12,9

    "CSI measurement via AP connection","IWL5300 must be connected to 11n format Open System AP","**✓**","**✓**"
    "CSI measurement by “Monitor mode + Packet Injection”","IWL5300 reports CSI only for the 11n frames sent to a magic MAC address","**✓**","**✓**"
    "Packet Injection with 11a/g/n format","Capable of specifying 20/40 MHz bandwidth, MCS, MIMO, 400/800 ns GI","**✓**","**✓**"
    "Channel changing and bandwidth in real-time","Direct channel/CBW changing via API or command options","**✓**","**✓**"
    "Switch IWL5300 firmware without reboot","Switch between the special CSI measurement and ordinary firmware","**✓**","**✓**"
    "Tx chain specification","Specify which Tx chains are used for Tx","**✓**","**✓**"
    "Rx chain specification","Specify which Rx chains are used for Rx","**✓**","**✓**"
    "CSI measurement for 11n frames with ESS","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","**✓**","**✓**"


.. _license_platform_features:
Platform Features
+++++++++++++++++++++++
.. csv-table:: Platform Features
    :header: "Feature", "Feature Description","FL","PRO (Both TL and DBL)"
    :widths: 30, 60, 15,12

    "Debian apt-based installation, upgrade and uninstallation","Fresh new installation can be as short as 10 minutes.","**✓**","**✓**"
    "PicoScenes MATLAB Toolbox","Parsing the .csi file in MATLAB; auto-upgradable","**✓**","**✓**"
    "Using and Developing PicoScenes Plugins","PicoScenes Plugin Development Kit is open sourced","**✓**","**✓**"
    "Concurrent Multi-process of PicoScenes","Multi-Process may be easier for certain complex control","","**✓**"
    "Multiple COTS NICs or SDR Devices","Support Multi-NIC/USRP hybrid frontend array","✓(limited, 2 device max)","**✓**"

.. _pricing:

Pricing
-----------------


.. _payment:

Payment
-----------------

The license fee of PSLP v1.0 PRO is **8688 RMB or 1360 USD**.

**Bulk purchase discount:** purchasing N, N ≤ 7 subscriptions in one-time bulk will have a discount of  (N−1)*8% , e.g., 16% discount for 3 subscriptions in a one-time purchase. In addition, subscribing 2/3 years can have an extra 9%/18% discount. 

.. PicoScenes team will optimize the PSLP every two months and raise the subscription fee about 100 USD。

中国区用户点此淘宝链接 `PicoScenes软件订阅 <https://item.taobao.com/item.htm?id=660337543983>`_ 下单，可开具正规电子发票

The overseas payment channel is still under construction.