PicoScenes License Plan (PSLP) 
=======================================

The PicoScenes License Plan (PSLP) plays a vital role in supporting the long-term development of the PicoScenes system. The current (November 2023) PSLP version is v1.0.

Introducing PSLP
---------------------

PSLP v1.0 offers two license options: 

- **Free (PSLP-FL)**: PSLP-FL is free of charge but comes with limited access to advanced features.
- **Pro (PSLP-PRO)**: PSLP-PRO users pay a minimal license fee and gain full access to all PicoScenes features along with timely technical support. It has two subtypes:
    - **Transferable License (PSLP-PRO-TL)**: It allows users to activate and use the license on a single computer. Users can conveniently transfer the license between computers as needed, providing flexibility for multi-device usage scenarios.
    - **Device-Bound License (PSLP-PRO-DBL)**: *This option is only available in mainland China*. **This option binds a Pro to a newly-bought NI USRP device from our partner store.** Compared to PSLP-PRO-TL, users of PSLP-PRO-DBL gain immediate and full access to the licensed features without explicit activation and online validation. This model is suitable for researches on newly-bought NI USRP hardware, offering faster program start, and long-term offline operation. *We offer discounted bundle pricing for this option*.

.. csv-table:: Comparisons of PSLP Options
    :header: "PSLP Option", "Pros", "Cons"

    "PSLP-FL", "
    - Nice documentation on usage at `ps.zpj.io <https://ps.zpj.io>`_
    - Installation and upgrade via Debian *apt* facility
    - Support running self-made PicoScenes plugin
    - Public technical support via `Issue Tracker <https://gitlab.com/wifisensing/picoscenes-issue-tracker>`_", "
    - Limited/No advanced features
    - Online validation (frequent)"
    "PSLP-PRO-TL", "
    - *All Pro features* in :ref:`PSLP-License-Details`
    - *Timely technical support on IM*
    - Transferable to other computers", "
    - Online validation (less frequent)"
    "PSLP-PRO-DBL", "
    - *All Pro features* in :ref:`PSLP-License-Details`
    - *Timely technical support on IM*
    - **Discounted bundle pricing**
    - Out-of-box experience
    - Faster program start
    - Long-term offline operating", "
    - Device bound, not transferable
    - Only for NI USRP SDR devices
    - *Available only in China mainland*"

.. note:: PSLP-PUL v0.8.1 is converted to PSLP-PRO-TL in v1.0 automatically.

.. _PSLP-License-Details:

Details of PSLP v1.0
-----------------------------

We divide the PSLP into three aspects: :ref:`license_technical_support`, :ref:`license_hardware_features`, and :ref:`license_platform_features`.

.. _license_technical_support:
Technical Support
++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "Good documentation","https://ps.zpj.io","**✓**","**✓**"
    "Issue tracker-based technical support","https://gitlab.com/wifisensing/picoscenes-issue-tracker","**✓**","**✓**"
    "Very timely technical support via IM","Providing quick technical support on WeChat or other IM","","**✓**"

.. _license_hardware_features:
Hardware Features
+++++++++++++++++++++++

PSLP has different feature access for different hardware: :ref:`license_sdr`, :ref:`license_ax200`, :ref:`license_qca9300` and :ref:`license_iwl5300`.


.. _license_sdr:
SDR (NI USRP Hardware and HackRF One)
+++++++++++++++++++++++++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "SDR Hardware Support","NI USRP and HackRF One. See :ref:`csi_by_sdr`","**✓**","**✓**"
    "Transmit 11a/g/n/ac/ax/be-Format Frames with 20 MHz CBW ","See :ref:`sdr-tx-20-cbw`","**✓** (Up to 2x2 MIMO)","**✓**"
    "Transmit 11a/g/n/ac/ax/be-Format Frames with 40/80/160/320 MHz CBW","Support up to Wi-Fi 7 and 320 MHz CBW. See :ref:`sdr-tx-40-or-higher-cbw`","","**✓**"
    "Receiving and Measuring CSI for 20 MHz CBW Frames","See :ref:`sdr-rx-20-cbw`","**✓** (Up to 2x2 MIMO)","**✓**"
    "Receiving and Measuring CSI for 40/80/160/320 MHz CBW Frames","Support up to Wi-Fi 7 and 320 MHz CBW. See :ref:`sdr-rx-40-or-higher-cbw`","","**✓**"
    "Rx Multi-Thread Decoding", "Improve Rx decoding performance significantly. See :ref:`parallel-decoding`", "**✓** (Up to 2)","**✓**"
    "Tx/Rx Gain Control","Manual Tx/Rx gain control, and Rx AGC. See :ref:`tx-gain-control` and :ref:`rx-gain-control`","**✓**","**✓**"
    "Tx Chain Specification","Multi-(RF) Channel and MIMO Transmission. See :ref:`multi-channel-tx`","**✓** (Up to 2 channels)","**✓**"
    "Rx Chain Specification","Multi-(RF) Channel Reception. See :ref:`multi-channel-rx-single` and :ref:`multi-channel-rx-multi`","**✓** (Up to 2 channels)","**✓**"
    "Antenna Selection","See :ref:`antenna_selection`","**✓**","**✓**"
    "Operating in Non-Standard Channel (Carrier Frequency)","Operating at any hardware-supported frequency. See :ref:`non-standard-tx-rx`.","**✓** ([2.3-2.6] GHz)","**✓**"
    "Operating with Non-Standard Bandwidth (Sampling Rate)","Operating with any hardware-supported sampling rate.  See :ref:`non-standard-tx-rx`.","**✓** (Only 10 and 30 MHz)","**✓**"
    "Record and Replay Tx/Rx Baseband Signals","Record Tx/Rx baseband signals, and replay them during offline analysis. See :ref:`signal-recording-replay`","","**✓**"
    "Tx/Rx Resampling","Realizing arbitrary bandwidth Tx/Rx on USPRs with fixed master clock rate. See :ref:`non-standard-tx-rx-fixed-master-clock`.","**✓** (Only 1.0 and 1.25)","**✓**"
    "Support External Clock Source","Achieving cross-device clock/phase synchronization. See :ref:`phase_sync_multiple_device`","**✓**","**✓**"
    "Multi-USRP Combination","Combining multiple USRP devices into a virtual and larger USRP with more synchronized channels. See :ref:`multi-channel-rx-single`, :ref:`multi-channel-rx-multi`, and :ref:`multi-channel-tx`","","**✓**"
    "Multi-Channel Splitting and Stitching", "Want to sampling a 400 MHz channel by a dual-channel 200 MHz max USRP X3x0/N3x0? See :ref:`dual-split-merge`", "","**✓**"
    "Multiple CSI Measurement per Frame","Supporting up to 39 CSI measurements from a single frame. See :ref:`multi-csi-measurement`.","","**✓**"
    "Channel Impairment Simulation (CFO, SFO, I/Q Imbalance)","Simulating CFO, SFO, I/Q Imbalance and their combinations at Tx or Rx end. See :ref:`channel-impairment-simulation`","","**✓**"
    "Interoperability with Old QCA9300 and IWL5300","Capability to trigger CSI measurement for QCA9300 by default; providing “—5300” option to trigger CSI measurement for IWL5300","**✓**","**✓**"
    "Batch-Tx Frames with Precise Timing","Pre-generate frame signals with precise inter-frame spacing","","**✓**"
    "Tx Signal Precoding for 11n/ac/ax/be","Tx signal precoding can be used to realize beamforming, phased array and arbitrary signal equalization","","**✓**"
    "Tx MIMO Beamforming","Specifying Tx steering matrix, used for beamforming and phased array","","**✓**"
    "Obtain the L-LTF based CSI (Legacy-CSI)","Return the L-LTF based CSI estimation (Legacy CSI). See :ref:`cell-structure-matlab`.","","**✓**"
    "Obtain complete Rx baseband signal","Return the complete multi-channel baseband signals. See :ref:`cell-structure-matlab`","**✓**","**✓**"

.. _license_ax200:
AX210/AX200
+++++++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "6 GHz Band Access (**AX210 Only**)","Accessing the 6 GHz band channels (5955 to 7115 MHz in range, 20 MHz each). See :ref:`ax200-measurements` and ::doc:`/channels`.","**✓** ([5955-6415] MHz)","**✓**"
    "CSI Measurement with Associated AP","See :ref:`ax200-wifi-ap`","**✓**","**✓**"
    "CSI Measurement in Monitor Mode (**Passive Sensing**)","See :ref:`ax200-monitor`","**✓**","**✓**"
    "CSI Measurement in Monitor Mode with Packet Injection","See :ref:`ax200-monitor-injection`","**✓**","**✓**"
    "Transmit 11a/g/n/ac/ax-Format Frames with 20/40 MHz CBW","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","**✓**","**✓**"
    "Packet Injection in 11ac/ax-Format Frames with 80/160 MHz CBW","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 80/160 MHz CBW, MCS, MIMO, 400/800/1600/3200 ns Guard Interval (GI), BCC/LDPC coding. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","**✓** (limited, packet injection rate <= 45pkts)","**✓**"
    "Interoperability: Transmit Frames trigger CSI measurement on IWL5300","Dedicated “—5300” option for AX200(Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**"
    "Change channel and bandwidth in real-time","Direct channel/CBW changing via API or command options","**✓**","**✓**"
    "CSI measurement for all source MAC address","CSI measurement for all the overheard frames which are with different source MAC address","**✓** (limited, just for the first 6 received MAC addresses)","**✓**"
    "Obtain Fine-Timing Measurement (FTM) clock count","The raw clock count from the 320 MHz baseband clock. About 4s a round. Useful for precise synchronization","","**✓**"
    "CSI measurement for the specified frame types","CSI measurement for the specified frame types, e.g., measuring CSI only for Beacon Frames","","**✓**"
    "Get more complete CSI information","Get reserved CSI header field","","**✓**"

.. _license_qca9300:
QCA9300
+++++++++++++++++++++++
.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "CSI measurement by “Monitor mode + Packet Injection”","QCA9300 NIC hardware reports CSI only for 11n frames with HT-rate flag not_sounding=of","**✓**","**✓**"
    "Packet Injection in 11a/g/n/ac/ax format with 20/40 MHz Channel bandwidth (CBW)","Packet injection can trigger CSI measurement in a constant rate. Capable of specifying 20/40 MHz CBW, MCS, MIMO, 400/800 ns Guard Interval (GI), BCC/LDPC coding and not_sounding flag. Packet content is with PicoScenesTxFrame format, can be further customized via PicoScenes-PDK plugins.","**✓**","**✓**"
    "Inject packets that can trigger CSI measurement on IWL5300","Dedicated “—5300” option for QCA9300(Injection) -> IWL5300 (Rx in monitor mode) CSI measurement","**✓**","**✓**"
    "Tx chain specification","Specify which Tx chains are used for Tx","**✓**","**✓**"
    "Rx chain specification","Specify which Rx chains are used for Rx","**✓**","**✓**"
    "CSI measurement for 11n frames with ESS feature on","Extra Spatial Sounding (ESS) is an 11n-introduced feature, which transmits extra HT-LTF segment, achieving 4-us spaced dual CSI measurement for 1-stream frame","**✓**","**✓**"
    "Access non-standard carrier frequency range","QCA9300 NIC hardware can operate in [2.2-2.9] and [4.4-6.1] GHz carrier frequency range with fine granularity","✓Limited, [2.3-2.6] GHz only","**✓**"
    "Access non-standard baseband sampling rate","QCA9300 NIC baseband can operate in [2.5-80] MHz baseband sampling rate with 2.5 MHz step","**✓** (Limited, 10/30 MHz only)","**✓**"
    "Manual Rx gain control","Turning off the hardware AGC and obtaining stable CSI measurement. Manual Rx control within [0, 66] dBm.","**✓** (Limited, [0-22] dBm only)","**✓**"
    "Inject ESS-enabled 11n frames","Achieving dual-CSI measurement from 1-stream packet on IWL5300/QCA9300/USRP receiver. AX200/AX210 doesn’t support ESS measurement","","**✓**"

.. _license_iwl5300:
IWL5300
+++++++++++++++++++++++
.. csv-table::
    :header: "Feature Name", "Description","Free","Pro"
    :widths: auto

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

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: 30, 60, 15,12

    "Debian apt-based installation, upgrade and uninstallation","Fresh new installation can be as short as 10 minutes.","**✓**","**✓**"
    "PicoScenes MATLAB Toolbox","Parsing the .csi file in MATLAB; auto-upgradable","**✓**","**✓**"
    "Using and Developing PicoScenes Plugins","PicoScenes Plugin Development Kit is open sourced","**✓**","**✓**"
    "Concurrent Multi-process of PicoScenes","Multi-Process may be easier for certain complex control","","**✓**"
    "Multiple COTS NICs or SDR Devices","Support Multi-NIC/USRP hybrid frontend array","**✓** (limited, 2 device max)","**✓**"

.. _pricing:

Pricing & Payment
-----------------


.. _payment:

Payment
-----------------

The license fee of PSLP v1.0 PRO is **8688 RMB or 1360 USD**.

**Bulk purchase discount:** purchasing N, N ≤ 7 subscriptions in one-time bulk will have a discount of  (N−1)*8% , e.g., 16% discount for 3 subscriptions in a one-time purchase. In addition, subscribing 2/3 years can have an extra 9%/18% discount. 

.. PicoScenes team will optimize the PSLP every two months and raise the subscription fee about 100 USD。

中国区用户点此淘宝链接 `PicoScenes软件订阅 <https://item.taobao.com/item.htm?id=660337543983>`_ 下单，可开具正规电子发票

The overseas payment channel is still under construction.