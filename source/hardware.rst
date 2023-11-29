Supported Hardware
==========================================

**Revised on Nov. 29, 2023**

In this page, we briefly compare the capabilities of the PicoScenes-supported CSI hardware. 

[Exclusive for China mainland users]: PicoScenes团队很荣幸得到NI的认可与支持 :ref:`collaboration-with-ni`，获得NI USRP授权销售资格。您可以在这个上页面查看我们的NI USRP销售方案， :doc:`/ni`。

.. csv-table:: CSI-extractable hardware supported by PicoScenes
    :header: "Hardware Model", "AX210/AX200", "USRP-based SDR (X310 as example)", "HackRF One", "QCA9300", "IWL5300"
    :widths: 30, 60, 60, 60, 60, 60
    :stub-columns: 1

    "Type", "Wi-Fi NIC", "SDR via USB3.0 or 10/100GbE", "SDR via USB2.0", "Wi-Fi NIC", "Wi-Fi NIC"
    "Form Factor", "M.2 2230,  M.2 2230 w/ CNVi (AX211)", "External SDR device", "External SDR device", "Mini PCI-E 1x ", "Mini PCI-E 1x"
    "Supported Protocols for CSI measurement", "802.11a/g/n/ac/**ax**", "802.11a/g/n/ac/**ax/be**", "802.11a/g/n/ac/**ax/be**", "802.11n", "802.11n"
    "Rx AGC", "Yes, only automatic", "No, automatic by USRP B210", "No", "Yes, has manual mode", "Yes, only automatic"
    "Available Carrier Frequency Range (MHz)", "AX200: 2.4/5 GHz Bands, 470 MHz in total; **AX210**: 2.4/5/**6** GHz bands, **[5955, 7115] MHz**", "**Arbitrary tunable in [10, 6000] MHz**", "**Arbitrary tunable in [10, 7250] MHz**", "**Arbitrary tunable in [2.2-2.9] and [4.4-6.1] GHz**", "2.4/5 GHz Bands, 470 MHz in total"
    "Available Bandwidths (MHz)", "20/40/80/**160**", "**tunable in [1, 400], scalable to 1600** [#]_", "**Arbitrary tunable in [1, 20]**", "**Arbitrary tunable in [2.5, 80]**", "20/40"
    "Maximal MIMO Streams", "2", "4", "1", "3", "3"
    "Maximal CSI dimension", "**1992x2x2**", "**1992x1x1, Scalable to 1992x4x4 streams**", "242x1x1", "114x3x3", "30x3x3"
    "Number of CSI per packet", "1", "**Up to 39** [#]_", "**Up to 39** [2]_", "**2, by HT-rate Extra Spatial Sounding (ESS)**", "**2, by HT-rate Extra Spatial Sounding (ESS)**"
    "CSI Measurement for the Overheard Frames in Monitor Mode", "**YES**", "**YES**", "**YES**", "No, only for 11n sounding frames", "No, only for the special 12:34:56 address"
    "Arbitrary Packet Injection", "**Yes**, all-format (a/g/n/ac/**ax**), all-bandwidth (20/40/80/160 MHz), all-coding (LDPC/BCC) and all-band (2.4/5/**6** GHz)", "**Yes**, all-format (a/g/n/ac/**ax/be**), all-bandwidth (20/40/80/160/320 MHz), all-coding(LDPC/BCC), arbitrary frequency (10-6000 MHz)", "**Yes**, all-format (a/g/n/ac/**ax/be**), all-coding(LDPC/BCC), arbitrary frequency (10-7250 MHz), 20 MHz bandwidth", "Yes, a/g/n", "Yes, a/g/n"
        
.. [#] PicoScenes supports multi-channel split and concatenation. By combining four 400-MSPS channels of USRP X410, we achieve 1.6 GHz bandwidth.
.. [#] 39 CSI measurements with HE-SU mode/ midamble CSI/ midamble periodicity = 10
