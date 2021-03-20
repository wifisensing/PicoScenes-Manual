PicoScenes: Wi-Fi Sensing Research, Supercharged!
====================================================

PicoScenes is an advanced multi-purpose Wi-Fi sensing platform software. 
It supports the multi-NIC concurrent operation (including the packet injection, packet reception and CSI measurement) of the Qualcomm Atheros AR9300 (QCA9300), Intel Wireless Link 5300 (IWL5300) and software-defined radio (SDR) devices. 

For the QCA9300, PicoScenes unlocks the **arbitrary tuning** for both the carrier frequency (a total of 2.4 GHz wide spectrum in 2.4 and 5 GHz bands) and baseband sampling rate (from 2.5 to 80 MHz), enables QCA9300->IWL5300 CSI measurement and also supports the transmission of the extra spatial sounding LTF (HT-ELTF).

For SDR, PicoScenes embeds a high-performance software baseband implementation for 802.11a/g/n/ac/ax protocols. It **covers almost all the technical features**, including both the LDPC and BCC encoding/decoding, MCS 0~11 modulation, up to 160 MHz channel bandwidth (CBW), up to 4x4 MIMO, and even the 802.11ac/ax multi-user (MU) mode. In our benchmark, PicoScenes sets a record of >1 kHz real-time CSI measurement at a 20 MHz bandwidth, >4 kHz (real-time) and even >40 kHz (signal replay) insanely fast packet injection rates, and >100 Hz CSI measurement at a maximally 200 MHz bandwidth.

PicoScenes is architecturally versatile and flexible. It encapsulates all the low-level features into unified and hardware-independent APIs and exposes them to the upper-level plugin layer. Users can **quickly prototype their own measurement plugins**. We demonstrate this platform flexibility through EchoProbe, a PicoScenes plugin, which features ms-grade round-trip CSI measurement and the spectrum scanning CSI measurement capability. 

We hope you enjoy the next ride of Wi-Fi sensing research, supercharged by PicoScenes!

.. note::

   You can contribute the documentation! This documentation is open source. If you find any errors, want to help us improve this documentation, or share some more technical details about PicoScenes, you can folk this documentation at GitLab, make your modification in your local repo and issue a Merge Request to us.

News
------------------
- Mar. 20, 2021: Add ten typical CSI measurement scenarios
- Mar. 16, 2021: Add hardware installation
- Mar. 11, 2021: Start writing documents.

.. toctree::
   :maxdepth: 3
   :numbered:
   :caption: Table of Contents:
   
   installation
   scenarios
   parameters
   matlab
   resources
   credits
   License