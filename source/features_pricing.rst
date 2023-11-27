Features & License
=======================================

PicoScenes is a feature-rich, powerful, and user-friendly middleware for Wi-Fi ISAC research. This page outlines the notable features of PicoScenes and provides links to their usage and explanations.

To ensure the sustainable development of the PicoScenes platform, we have implemented a licensing mechanism for these features. **The majority of features are available free of charge**, while a license fee is required for certain advanced features, primarily for SDR frontends.

In the sections below, we cover three main topics:

- :ref:`feature-list`
- :ref:`introducing_pslp`
- :ref:`pricing`

.. _feature-list:

Features of The PicoScenes Platform
--------------------------------------

We categorize the distinctive features of the PicoScenes platform into three tables: :ref:`license-platform-features`, :ref:`license-hardware-features`, and :ref:`license-data-access`. In these tables, we also list the availability of each feature for free users (in the *Free* columns) and Pro users (in the *Pro* columns). A detailed comparison between the Free and Pro licenses can be found in :ref:`introducing_pslp` and :ref:`pricing`.

.. _license-platform-features:

Platform Features
+++++++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: 30, 60, 15,12

    "Rich Hardware Support", "PicoScenes supports COTS NICs (AX210/AX200, QCA9300, and IWL5300) and SDR Devices (NI USRP Series and Hack RF One). See :doc:`/hardware`.","**✓**","**✓**"
    "Hardware Interoperability","Frame transmission and CSI measurement among heterogeneous hardware. See :ref:`interoperability`. ","**✓**","**✓**"
    "Easy Installation","Out-of-box experience. Easy installation on Ubuntu 20.04 (*22.04 soon*) in less than 10 mins. No kernel or driver compilations. Debian *apt* based upgrading. See :doc:`/installation`.","**✓**","**✓**"
    "PicoScenes MATLAB Toolbox","Parsing the .csi files in MATLAB via Drag'n'Drop. See :doc:`/matlab`.","**✓**","**✓**"
    "Plugins Development","Allowing users to implement their own ISAC measurement protocols, like round-trip CSI measurements or spectrum scanning. See :doc:`/plugin` ","**✓**","**✓**"
    "Best in class Documentation","https://ps.zpj.io","**✓**","**✓**"
    "Public Technical Support","Public and searchable assistance at https://gitlab.com/wifisensing/picoscenes-issue-tracker","**✓**","**✓**"
    "Very Timely and Personal Technical Support on IM","**Very timely assistance on WeChat or other IM Apps, only for Pro users**,","","**✓**"

.. _license-hardware-features:

Hardware Features
+++++++++++++++++++++++++++

We categorize the technical features based on the underlying hardware: :ref:`license_sdr`, :ref:`license_ax200`, :ref:`license_qca9300`.


.. _license_sdr:

Support for SDR: NI USRP Hardware and HackRF One
+++++++++++++++++++++++++++++++++++++++++++++++++

One of the major highlights of the PicoScenes platform is its built-in high-performance software baseband implementation of the 802.11 PHY, which *supports the 802.11a/g/n/ac/ax/be protocols, 4096-QAM, up to 320 MHz CBW, and LDPC codecs*. Developed in C++, it leverages the multi-threading, BLAS library, and AVX2 instruction set for accelerated processing.

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "SDR Hardware Support","Supporting *all models* of NI USRP SDR devices and the HackRF One. See :ref:`csi_by_sdr`","**✓**","**✓**"
    "Transmit 11a/g/n/ac/ax/be-Format Frames with 20 MHz CBW ","SDR-based *Packet Injection* with up to Wi-Fi 7 format support. See :ref:`sdr-tx-20-cbw`","**✓** (Up to 2x2 MIMO)","**✓**"
    "Transmit 11a/g/n/ac/ax/be-Format Frames with 40/80/160/320 MHz CBW","SDR-based *Packet Injection* supporting up to 320 MHz CBW and Wi-Fi 7 format. See :ref:`sdr-tx-40-or-higher-cbw`","","**✓**"
    "Receiving and Measuring CSI for 20 MHz CBW Frames","*Fully Passive Sensing* in 20 MHz channels. See :ref:`sdr-rx-20-cbw`","**✓** (Up to 2x2 MIMO)","**✓**"
    "Receiving and Measuring CSI for 40/80/160/320 MHz CBW Frames","*Fully Passive Sensing* with Wi-Fi 7 format and up to 320 MHz CBW. See :ref:`sdr-rx-40-or-higher-cbw`","","**✓**"
    "Rx Multi-Thread Decoding", "Scaling-up Rx decoding performance. See :ref:`parallel-decoding`", "**✓** (Up to 2)","**✓**"
    "Tx/Rx Gain Control","Manual Tx/Rx gain control, and Rx AGC. See :ref:`tx-gain-control` and :ref:`rx-gain-control`","**✓**","**✓**"
    "Tx Chain Specification","Multi-(RF) Channel and MIMO Transmission up to 4x4. See :ref:`multi-channel-tx`","**✓** (Up to 2 channels)","**✓**"
    "Rx Chain Specification","Multi-(RF) Channel Reception up to 4x4 MIMO. See :ref:`multi-channel-rx-single` and :ref:`multi-channel-rx-multi`","**✓** (Up to 2 channels)","**✓**"
    "Antenna Selection","Tx/Rx antenna specification. See :ref:`antenna_selection`","**✓**","**✓**"
    "Operating in Non-Standard Channel (Carrier Frequency)","Operating at any hardware-supported frequency range, *e.g.*, in [10 - 6000] MHz range. See :ref:`non-standard-tx-rx`.","**✓** ([2.3-2.6] GHz)","**✓**"
    "Operating with Non-Standard Bandwidth (Sampling Rate)","Operating with any hardware-supported sampling rate. *e.g.*. up to 400 MHz sampling with NI USRP X410. See :ref:`non-standard-tx-rx`.","**✓** (Only 10 and 30 MHz)","**✓**"
    "Record and Replay Tx/Rx Baseband Signals","Record Tx and Rx baseband signals, and replay them during offline analysis. See :ref:`signal-recording-replay`","**✓** (Only Rx Record and Replay)","**✓**"
    "Tx/Rx Resampling","Realizing arbitrary bandwidth Tx/Rx on USPRs with fixed master clock rate, *e.g.*, achieving 320 MHz CBW with 400 MHz fix-rate NI USRP X410. See :ref:`non-standard-tx-rx-fixed-master-clock`.","**✓** (Only 0.8, 1.0 and 1.25)","**✓**"
    "Support External Clock Source","Realizing Multi-USRP clock/phase synchronization. *e.g.*, MIMO Tx/Rx and phased array. See :ref:`phase_sync_multiple_device`","**✓**","**✓**"
    "Multi-USRP Combination","Combining multiple USRP devices into a virtual and larger USRP with more synchronized channels, *e.g.*, achieving up to 8x8 MIMO using four NI USRP X310. See :ref:`multi-channel-rx-single`, :ref:`multi-channel-rx-multi`, and :ref:`multi-channel-tx`","","**✓**"
    "Multi-Channel Splitting and Stitching", "Combining two half-rate sampling channels into a full-rate channel, *e.g.*, achieving up to 400 MHz bandwidth with a single NI USRP X310 (200 MHz rate max.). See :ref:`dual-split-merge`", "","**✓**"
    "Multiple CSI Measurement per Frame","Supporting up to 39 CSI measurements from a single frame. See :ref:`multi-csi-measurement`.","","**✓**"
    "Channel Impairment Simulation","Simulating CFO, SFO, I/Q Imbalance and their combinations at Tx or Rx end. See :ref:`channel-impairment-simulation`","","**✓**"
    "Interoperability","Interoperability with COTS NICs, AX210/AX200, QCA9300, IWL5300 and all other Wi-Fi NICs. See :ref:`interoperability`","**✓**","**✓**"


.. _license_ax200:

COTS NIC: AX210 and AX200
+++++++++++++++++++++++++++

PicoScenes is the exclusive platform that supports the packet injection (Tx), receiving, and CSI measurement on Intel AX210/AX200 NIC.

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "6 GHz Band Access (**AX210 Only**)","Accessing the full 6 GHz band channels (5955 to 7115 MHz) *around the globe*. See :ref:`ax200-measurements` and ::doc:`/channels`.","**✓** ([5955-6415] MHz)","**✓**"
    "CSI Measurement with Associated AP","Measuring CSI from the associated AP. See :ref:`ax200-wifi-ap`","**✓**","**✓**"
    "CSI Measurement in Monitor Mode (**Passive Sensing**)","Supporting measuring CSI for all overheard frames (11a/g/n/ac/ax format) in monitor mode with up to 160 MHz CBW. See :ref:`ax200-monitor`","**✓**","**✓**"
    "Transmit 11a/g/n/ac/ax-Format Frames with 20/40 MHz CBW","Supporting *Packet Injection* with 11a/g/n/ac/ax format and up to 160 MHz CBW. 
    See :ref:`ax200-monitor-injection` and :ref:`ax200-monitor-injection-mcs-antenna`","**✓**","**✓**"
    "Transmit 11a/g/n/ac/ax-Format Frames with 80/160 MHz CBW","Supporting *Packet Injection* with 11a/g/n/ac/ax format and up to 160 MHz CBW. See :ref:`ax200-monitor-injection` and :ref:`ax200-monitor-injection-mcs-antenna`","**✓** (Transmission rate :math:`\leq` 50pkts)","**✓**"
    "Runtime Specifying Channel and Bandwidth","Specifying channel, CBW, Tx/Rx chainmasks in runtime by commands or APIs. See :ref:`live-channel-bw-changing`.","**✓**","**✓**"

.. _license_qca9300:

COTS NIC: QCA9300 and IWL5300
+++++++++++++++++++++++++++++++

PicoScenes supports the legendary QCA9300 and IWL5300 NICs and exclusively unlocks several low-level controls for QCA9300. See :ref:`picoscenes_paper` for more details.

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "CSI Measurement by “Monitor mode + Packet Injection”","Packet Injection in 11a/g/n/ac/ax format with 20/40 MHz Channel bandwidth (CBW) with Extra Spatial Sounding (ESS). See :ref:`packet-injection-qcq9300-iwl5300`","**✓**","**✓**"
    "Accessing Non-Standard Channel and Bandwidth by QCA9300","QCA9300 supports operating in [2.2-2.9, 4.4-6.1] GHz spectrum and [2.5-80] MHz bandwidth. See :ref:`qca9300_non-standard`","✓Limited, [2.3-2.6] GHz only","**✓**"
    "Manual Rx Gain Control by QCA9300","Disabling AGC and specifying a fixed [0-66] dBm Rx Gain. See :ref:`qca9300_non-standard`","**✓** (Limited, [0-22] dBm only)","**✓**"
    "Tx/Rx chain specification","Specify Tx and Rx chainmasks in runtime, see :ref:`tx-rx-chainmask-qca9300-iwl5300`","**✓**","**✓**"
    "Runtime Specifying Channel and Bandwidth","Changing channel and CBW in runtime, see :ref:`live-channel-bw-changing-qca9300-iwl5300`.","**✓**","**✓**"

.. _license-data-access:

Data & API Access
++++++++++++++++++++++++++++++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "Complete baseband signal","**SDR Only**. Return the per-packet complete multi-channel baseband signals. See :ref:`cell-structure-matlab`","**✓**","**✓**"
    "Multi-CSI-per-Frame", "**SDR Only**. Return multiple CSI measurements (if available). See :ref:`multi-csi-measurement`.","**✓**","**✓**"
    "L-LTF based CSI (Legacy-CSI)","**SDR Only**. Return two individual L-LTF based CSI estimations (Legacy CSI). See :ref:`cell-structure-matlab`.","","**✓**"
    "Batch Tx mode","**SDR Only API**. Transmitting multiple frames with deterministic inter-frame spacing.","","**✓**"
    "Nanosecond level Tx ands Rx clock","**AX210/AX200 and SDR Only**. Nanosecond-level Tx and Rx timestamps.","","**✓**"

.. _introducing_pslp:

Introducing PicoScenes Licensing Plan
-----------------------------------------

PicoScenes Licensing Plan (PSLP) has two tiers: Free License and Pro License. Their differences are:

- **Free License (PSLP-FL)**: PSLP-FL is free of charge but comes with limited access to advanced features.
- **Pro License (PSLP-PRO)**: PSLP-PRO users pay a license fee and gain full access to all PicoScenes features along with timely technical support. It has two subtypes:
    - **Transferable License (PSLP-PRO-TL)**: It allows users to activate and use the license on a single computer. Users can conveniently transfer the license between computers as needed, providing flexibility for multi-device usage scenarios.
    - **Device-Bound License (PSLP-PRO-DBL)**: This option **ties a untransferable Pro license to a newly-bought NI USRP device.** Compared to PSLP-PRO-TL, PSLP-PRO-DBL users can enjoy immediate and full access to the licensed features without explicit activation and online validation. This model is suitable for researches on newly-bought NI USRP hardware, offering faster program start, and long-term offline operation. This option is exclusively available in mainland China, as discussed in :ref:`collaboration-with-ni`.

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
    - *All Pro features* in :ref:`feature-list`
    - *Timely technical support on IM*
    - Transferable to other computers", "
    - Online validation (less frequent)"
    "PSLP-PRO-DBL (Coming Soon)", "
    - *All Pro features* in :ref:`feature-list`
    - *Timely technical support on IM*
    - **Discounted bundle pricing**
    - Out-of-box experience
    - Faster program start
    - Long-term offline operating", "
    - Device bound, not transferable
    - *Available only in China mainland*"

.. note:: PSLP-PUL v0.8.1 is converted to PSLP-PRO-TL in v1.0 automatically.

.. _collaboration-with-ni:

与NI中国合作赠送 PSLP-PRO-DBL许可证 (Gifting PSLP-PRO-DBL Licenses in Collaboration with NI China)
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
PicoScenes平台非常荣幸地得到 `NI <https://www.ni.com>`_ (美国国家仪器)公司(中国)的认可与支持，NI公司认为“**PicoScenes平台填补了NI公司在Wi-Fi ISAC领域的不足**”。
    
为支持更多用户基于PicoScenes平台及NI USRP系列产品进行Wi-Fi/5G/6G ISAC领域的研究与应用，NI公司(中国)与PicoScenes平台达成合作：对每台从PicoScenes合作公司售出的USRP系列SDR设备(独立机器或“母板+子板”套件)，**免费赠送一份PSLP-PRO-DBL许可证**。作为回报，NI公司(中国)将资助PicoScenes平台、提供多型号USRP设备供PicoScenes平台研发及测试，并提供技术支持。感谢NI公司对PicoScenes平台的认可支持❤️❤️❤️！ 

The PicoScenes platform is honored to receive recognition and support from National Instruments (`NI <https://www.ni.com>`_). NI acknowledges that "**the PicoScenes platform has addressed the gaps in NI's offering in the Wi-Fi ISAC domain.**" 
    
To support more users in the Wi-Fi/5G/6G ISAC field for research and applications using the PicoScenes platform and NI USRP series products, NI (China) has entered into a collaboration with the PicoScenes team: **a PSLP-PRO-DBL license will be provided free of charge** for each USRP Series SDR device sold by PicoScenes' partner store (independent machine or "motherboard + daughterboard" kit). In return, NI (China) will fund the PicoScenes platform, provide USRP devices for PicoScenes platform development and testing, and offer technical support. We sincerely appreciate NI's recognition and support for the PicoScenes platform ❤️❤️❤️!

.. _pricing:

Pricing
---------------

.. todo:: stay tuned!

.. Pricing for Pro License
.. +++++++++++++++++++++++++++++++++

.. - **PSLP-PRO-TL**: 

..   - For Chinese users: **一次性付费8688元人民币得到2个PSLP-PRO-TL许可证**。我们捆绑2个licenses一起销售，是因为常用的"(Tx) Packet Injection + (Rx) CSI Measurement in Monitor Mode"模式需要两台机器配合使用。
..   - For English-speaking users outside mainland China: **One-time payment of 1500 USD for 2 PSLP-PRO-TL licenses**. We bundle 2 PSLP-PRO-TL licenses together for sale because the commonly used ISAC scenario '(Tx) Packet Injection + (Rx) CSI Measurement in Monitor Mode' requires two independent machines. Compared to 8688 RMB (roughly 1200 USD) for Chinese users, the additional $300 USD is for currency exchange processing fee and technical support in English.

.. - **PSLP-PRO-DBL**: 

..   .. todo:: stay tuned!
