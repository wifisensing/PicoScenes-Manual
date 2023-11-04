Supported Hardware
==========================================

In this page, we briefly compare the capabilities of the PicoScenes-supported CSI hardware. 
The following Wi-Fi NIC models are available in our `PicoScenes Taobao Shop <https://item.taobao.com/item.htm?id=648560374131>`_ ^_^.

.. csv-table:: CSI-extractable hardware supported by PicoScenes
    :header: "Hardware Model", "AX210/AX200/AX211", "USRP-based SDR (X310 as example)", "HackRF One", "QCA9300", "IWL5300"
    :widths: 30, 60, 60, 60, 60, 60
    :stub-columns: 1

    "Type", "Wi-Fi NIC", "SDR via USB3.0 or 10GbE", "SDR via USB2.0", "Wi-Fi NIC", "Wi-Fi NIC"
    "Form Factor", "M.2 2230,  M.2 2230 w/ CNVi (AX211)", "External USRP device", "External SDR device", "Mini PCI-E 1x ", "Mini PCI-E 1x"
    "Supported Protocols for CSI measurement", "802.11a/g/n/ac/**ax**", "802.11a/g/n/ac/**ax/be**", "802.11a/g/n/ac/**ax/be**", "802.11n", "802.11n"
    "Rx AGC", "Yes, only automatic", "No, automatic by USRP B210", "No", "Yes, has manual mode", "Yes, only automatic"
    "Available Carrier Frequency Range (MHz)", "AX200: 2.4/5 GHz Bands, 470 MHz in total; **AX210/AX211**: 2.4/5/**6** GHz bands, **[5955, 7115] MHz**", "**Arbitrary tunable in [10, 6000] MHz**", "**Arbitrary tunable in [10, 7250] MHz**", "**Arbitrary tunable in [2.2-2.9] and [4.4-6.1] GHz**", "2.4/5 GHz Bands, 470 MHz in total"
    "Available Bandwidths (MHz)", "20/40/80/**160**", "**tunable in [1, 400] (single channel), scalable up to 1600 by multiple channel**", "**Arbitrary tunable in [1, 20]**", "**Arbitrary tunable in [2.5, 80]**", "20/40"
    "Maximal MIMO Streams", "2", "4", "1", "3", "3"
    "Maximal CSI dimension", "**1992x2x2**", "**1992x4x4**", "242x1x1", "114x3x3", "30x3x3"
    "Number of CSI per packet", "1", "**Up to 39 CSI measurements per A-MPDU**", "**Up to 39 CSI measurements per A-MPDU**", "**2, by HT-rate Extra Spatial Sounding (ESS)**", "**2, by HT-rate Extra Spatial Sounding (ESS)**"
    "CSI Measurement for the Overheard Frames in Monitor Mode", "**YES**", "**YES**", "**YES**", "No, only for 11n sounding frames", "No, only for the special 12:34:56 address"
    "Arbitrary Packet Injection", "**Yes**, all-format (a/g/n/ac/**ax**), all-bandwidth (20/40/80/160 MHz), all-coding (LDPC/BCC) and all-band (2.4/5/**6** GHz)", "**Yes**, all-format (a/g/n/ac/**ax/be**), all-bandwidth (20/40/80/160/320 MHz), all-coding(LDPC/BCC), arbitrary frequency (10-6000 MHz)", "**Yes**, all-format (a/g/n/ac/**ax/be**), all-coding(LDPC/BCC), arbitrary frequency (10-7250 MHz), 20 MHz bandwidth", "Yes, a/g/n", "Yes, a/g/n"
