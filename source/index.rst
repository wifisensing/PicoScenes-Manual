PicoScenes: Wi-Fi Sensing, Supercharged!
============================================

PicoScenes is an advanced multi-purpose Wi-Fi sensing platform software. 
It supports the multi-NIC concurrent operation (including the packet injection, packet reception and CSI measurement) of the Qualcomm Atheros AR9300 (QCA930), Intel Wireless Link 5300 (IWL5300) and software-defined radio (SDR) devices. 

For the QCA9300, PicoScenes unlocks the **arbitrary tuning** for both the carrier frequency (a total of 2.4 GHz wide spectrum in 2.4 and 5 GHz bands) and baseband sampling rate (from 2.5 to 80 MHz), enables QCA9300->IWL5300 CSI measurement and also supports the transmission of the extra spatial sounding LTF (HT-ELTF) which provides 4us-level successive CSI measurement.

For SDR, PicoScenes embeds a high-performance software baseband implementation for 802.11a/g/n/ac/ax protocols. It **covers almost all the technical features**, including both the LDPC and BCC encoding/decoding, MCS 0~11 modulation, up to 160 MHz channel bandwidth (CBW), up to 4x4 MIMO, and even the 802.11ac/ax multi-user (MU) mode. In our benchmark, PicoScenes sets a record of >1 kHz real-time CSI measurement at a 20 MHz bandwidth, >4 kHz (realtime) and even >40 kHz (signal replay) insanely fast packet injection rates, and >100 Hz CSI measurement at a maximally 200 MHz bandwidth.

PicoScenes is architecturally versatile and flexible. It encapsulates all the low-level features into unified and hardware-independent APIs and exposes them to the upper-level plugin layer. Users may **quickly prototype their own measurement plugins**. We demonstrate this platform flexibility through EchoProbe, a PicoScenes plugin, which features ms-grade round-trip CSI measurement and also the spectrum scanning CSI measurement capability. 

We hope you enjoy the next ride of Wi-Fi sensing research, accompanied by PicoScenes!

.. tip::

   This documentation is continuously being updated and expanded. If you have any suggestions, or do not find what you are looking for, then please `Contact Us <mailto:zpj@xidian.edu.cn>`_.

News
------------------
- Mar. 15, 2021: Add two cheatsheet documents and refine the index page.
- Mar. 11, 2021: Start writing documents.

.. toctree::
   :maxdepth: 3
   :numbered:
   :caption: Table of Contents:
   
   howtoread
   quickstart/quickstart
   advanced_measurement/advanced
   interactive_measurement/interactive
   onSDR/useSDR
   plugin/plugin_index
   cheatsheet
   hardwareconnection
   performance
   License
   tcd
   credits