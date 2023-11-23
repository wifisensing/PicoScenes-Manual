Features & Pricing 
=======================================

PicoScenes is a feature-rich, powerful, and user-friendly middleware for the Wi-Fi ISAC research. In this page, we list all the distinctive features of PicoScenes and provide links to their usage or explanations. 

To ensure the sustainable development of the PicoScenes platform, we setup a licensing mechanism for these features. **The majority of features are available for free**, while a license fee is charged for certain advanced features.

In the sections below, we cover three main topics:

- :ref:`feature-list`
- :ref:`introducing_pslp`
- :ref:`pricing`

.. _feature-list:

Features of The PicoScenes Platform
--------------------------------------

We categorize the distinctive features of the PicoScenes platform into four tables: :ref:`license_platform_features`, :ref:`license_hardware_features`, :ref:`license_api`, and :ref:`license_technical_support`. In these tables, we indicate the availability of each feature for free users (in the *Free* columns) and Pro users (in the *Pro* columns). A detailed comparison between the free and paid licenses can be found in :ref:introducing_pslp and :ref:pricing.

.. _license_platform_features:

Platform Features
+++++++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: 30, 60, 15,12

    "Rich Hardware Support", "COTS NICs (AX210/AX200, QCA9300, and IWL5300) and SDR Devices (NI USRP Series and Hack RF One). See :doc:`/hardware`.","**✓**","**✓**"
    "Hardware Interoperability","Frame transmission and CSI measurement among heterogeneous hardware. See :ref:`interoperability`. ","**✓**","**✓**"
    "Easy Installation","Out-of-box experience. Easy installation on Ubuntu 20.04 (*22.04 soon*) in less than 10 mins. No kernel or driver compilations. Debian *apt* based upgrading. See :doc:`/installation`.","**✓**","**✓**"
    "PicoScenes MATLAB Toolbox","Parsing the .csi files in MATLAB. See :ref:`matlab`.","**✓**","**✓**"
    "Plugins Development","Allowing users to develop complex and dedicated ISAC measurement protocols, like round-trip CSI measurements or spectrum scanning. See :ref:`plugin`.","**✓**","**✓**"
    "Best in class Documentation","https://ps.zpj.io","**✓**","**✓**"
    "Public Technical Support","Public and searchable assistance at https://gitlab.com/wifisensing/picoscenes-issue-tracker","**✓**","**✓**"
    "Very Timely and Personal Technical Support on IM","**Very timely assistance on WeChat or other IM Apps, only for Pro users**,","","**✓**"

.. _license_hardware_features:

Hardware Features
+++++++++++++++++++++++++++

We divide the hardware features by the underlying hardware: :ref:`license_sdr`, :ref:`license_ax200`, :ref:`license_qca9300` and :ref:`license_iwl5300`.

.. _license_sdr:

SDR: NI USRP Hardware and HackRF One
++++++++++++++++++++++++++++++++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "SDR Hardware Support","Supporting *all models* of NI USRP SDR devices and the HackRF One. See :ref:`csi_by_sdr`","**✓**","**✓**"
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
    "Interoperability with Old QCA9300 and IWL5300","See :ref:`interoperability`","**✓**","**✓**"


.. _license_ax200:

COTS NIC: AX210 and AX200
+++++++++++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "6 GHz Band Access (**AX210 Only**)","Accessing the 6 GHz band channels around the globe (5955 to 7115 MHz in range, 20 MHz each). See :ref:`ax200-measurements` and ::doc:`/channels`.","**✓** ([5955-6415] MHz)","**✓**"
    "CSI Measurement with Associated AP","See :ref:`ax200-wifi-ap`","**✓**","**✓**"
    "CSI Measurement in Monitor Mode (**Passive Sensing**)","See :ref:`ax200-monitor`","**✓**","**✓**"
    "CSI Measurement in Monitor Mode with Packet Injection","See :ref:`ax200-monitor-injection`","**✓**","**✓**"
    "Transmit 11a/g/n/ac/ax-Format Frames with 20/40 MHz CBW","See :ref:`ax200-monitor-injection` and :ref:`ax200-monitor-injection-mcs-antenna`","**✓**","**✓**"
    "Transmit 11a/g/n/ac/ax-Format Frames with 80/160 MHz CBW","See :ref:`ax200-monitor-injection` and :ref:`ax200-monitor-injection-mcs-antenna`","**✓** (Transmission rate :math:`\leq` 50pkts)","**✓**"
    "Change channel and bandwidth in real-time","Direct channel/CBW changing via API or command options. See :ref:`live-channel-bw-changing`.","**✓**","**✓**"

.. _license_qca9300:

COTS NIC: QCA9300 And IWL5300
+++++++++++++++++++++++++++++++
.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "CSI Measurement by “Monitor mode + Packet Injection”","Packet Injection in 11a/g/n/ac/ax format with 20/40 MHz Channel bandwidth (CBW) with Extra Spatial Sounding (ESS). See :ref:`packet-injection-qcq9300-iwl5300`","**✓**","**✓**"
    "Accessing Non-Standard Channel and Bandwidth by QCA9300","See :ref:`qca9300_non-standard`","✓Limited, [2.3-2.6] GHz only","**✓**"
    "Manual Rx Gain Control by QCA9300","See :ref:`qca9300_non-standard`","**✓** (Limited, [0-22] dBm only)","**✓**"
    "Tx/Rx chain specification","Specify Tx and Rx chainmasks in runtime, see :ref:`tx-rx-chainmask-qca9300-iwl5300`","**✓**","**✓**"
    "Change channel and bandwidth in real-time","Specifying channel/CBW changing in runtime, see :ref:`live-channel-bw-changing-qca9300-iwl5300`.","**✓**","**✓**"

.. _license_api:

API And Data Access (Mainly for SDR)
++++++++++++++++++++++++++++++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "L-LTF based CSI (Legacy-CSI)","**SDR Only**. Return the L-LTF based CSI estimation (Legacy CSI). See :ref:`cell-structure-matlab`.","","**✓**"
    "Complete baseband signal","**SDR Only**. Return the complete multi-channel baseband signals. See :ref:`cell-structure-matlab`","**✓**","**✓**"
    "Nanosecond level Tx and Rx clock","**AX210/AX200 and SDR Only**. The raw clock count from the 320 MHz baseband clock.","","**✓**"

.. _license_technical_support:

Technical Support
++++++++++++++++++

.. csv-table::
    :header: "Feature", "Description","Free","Pro"
    :widths: auto

    "Good documentation","https://ps.zpj.io","**✓**","**✓**"
    "Issue tracker-based technical support","https://gitlab.com/wifisensing/picoscenes-issue-tracker","**✓**","**✓**"
    "Very timely technical support via IM","Providing quick technical support on WeChat or other IM","","**✓**"


.. _introducing_pslp:

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
    - *All Pro features* in :ref:`feature-list`
    - *Timely technical support on IM*
    - Transferable to other computers", "
    - Online validation (less frequent)"
    "PSLP-PRO-DBL", "
    - *All Pro features* in :ref:`feature-list`
    - *Timely technical support on IM*
    - **Discounted bundle pricing**
    - Out-of-box experience
    - Faster program start
    - Long-term offline operating", "
    - Device bound, not transferable
    - Only for NI USRP SDR devices
    - *Available only in China mainland*"

.. note:: PSLP-PUL v0.8.1 is converted to PSLP-PRO-TL in v1.0 automatically.


.. _pricing:

Pricing & Payment
-----------------

.. todo:: Please stay tuned.

::doc:`/features_pricing` 