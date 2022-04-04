Supported Hardware
==========================================

In this page, we briefly compare the capabilities of the PicoScenes-supported CSI hardware. 
The following Wi-Fi NIC models are available in our `PicoScenes Taobao Shop <https://item.taobao.com/item.htm?id=648560374131>`_ ^_^.

.. csv-table:: CSI-extractable hardware supported by PicoScenes
    :header: "Hardware Model", "AX210/AX200", "USRP-based SDR (X310 as example)", "HackRF One", "QCA9300", "IWL5300"
    :widths: 30, 60, 60, 60, 60, 60
    :stub-columns: 1

    "Type", "Wi-Fi NIC", "SDR via via USB3.0/10GbE Ethernet", "SDR via USB2.0", "Wi-Fi NIC", "Wi-Fi NIC"
    "Form Factor", "M.2 2230", "External USRP device", "External SDR device", "Mini PCI-E 1x ", "Mini PCI-E 1x"
    "Supported Protocols for CSI measurement", "802.11a/g/n/ac/**ax**", "802.11a/g/n/ac/**ax**", "802.11a/g/n/ac/**ax**", "802.11n", "802.11n"
    "Support Manual Rx Gain", "No", "**YES**", "**YES**", "**YES**", "No"
    "Available Carrier Frequency Range (MHz)", "AX200: 2.4/5 GHz Bands, 470 MHz in total; **AX210**: 2.4/5/**6** GHz bands, **[5955, 7115] MHz continuous spectrum**!", "**Arbitrary tunable in [10, 6000] MHz**", "**Arbitrary tunable in [10, 7250] MHz**", "**Arbitrary tunable in [2.2-2.9] and [4.4-6.1] GHz**", "2.4/5 GHz Bands, 470 MHz in total"
    "Available Bandwidths (MHz)", "20/40/80/**160**", "**Arbitrary tunable in [1, 200]**", "**Arbitrary tunable in [1, 20]**", "**Arbitrary tunable in [2.5, 80]**", "20/40"
    "Maximal MIMO Streams", "2", "4", "1", "3", "3"
    "Maximal CSI dimension", "**1992x2x2**", "**1992x4x4**", "242x1x1", "114x3x3", "30x3x3"
    "Number of CSI per packet", "1", "**Multiple: CSI from L-LTF and HT/VHT/HE-LTF, and the Pilot CSI per Data symbol**", "**Multiple: CSI from L-LTF and HT/VHT/HE-LTF, and the Pilot CSI per Data symbol**", "**2, by HT-rate Extra Spatial Sounding (ESS)**", "**2, by HT-rate Extra Spatial Sounding (ESS)**"
    "CSI Measurement for the Overheard Frames in Monitor Mode", "**YES**", "**YES**", "**YES**", "No, only for 11n sounding frames", "No, only for the special 12:34:56 address"
    "Arbitrary Packet Injection", "**Yes**, all-format (a/g/n/ac/**ax**), all-bandwidth (20/40/80/160 MHz), all-coding (LDPC/BCC) and all-band (2.4/5/**6** GHz)", "**Yes**, all-format (a/g/n/ac/**ax**), all-bandwidth (20/40/80/160 MHz), all-coding(LDPC/BCC), arbitrary frequency (10-6000 MHz)", "**Yes**, all-format (a/g/n/ac/**ax**), all-coding(LDPC/BCC), arbitrary frequency (10-7250 MHz), 20 MHz bandwidth", "Yes, a/g/n", "Yes, a/g/n"
    "CSI measurement miss rate", "Very low", "Low in slower clock/bandwidth, high with large bandwidth and MIMO", "Low", "Very low", "Very low"
