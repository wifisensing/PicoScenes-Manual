PicoScenes: Wi-Fi Sensing Research, Supercharged!
====================================================

PicoScenes is an advanced multi-functional Wi-Fi sensing platform software. It helps researchers **surmount two key barriers of the current Wi-Fi sensing research**: the inadequate sensing hardware and incompetent measurement software.

**For hardware**: PicoScenes supports the **multi-NIC concurrent operation** (including the packet injection, packet reception and CSI measurement) of the Qualcomm Atheros AR9300 (QCA9300), Intel Wireless Link 5300 (IWL5300), USRP-based software-defined radio (SDR) and even the *Virtual SDR* devices. 

For QCA9300 NIC, PicoScenes unlocks the **arbitrary tuning** for both the carrier frequency (a total of 2.4 GHz wide spectrum in 2.4 and 5 GHz bands) and baseband sampling rate (from 2.5 to 80 MHz), enables **manual Rx gain control**, QCA9300->IWL5300 CSI measurement, supports the Tx/Rx antenna specification and transmission of the extra spatial sounding LTF (HT-ELTF).

For SDR, PicoScenes integrates a general-purpose high-performance software baseband implementation for 802.11a/g/n/ac/ax protocols. It **covers almost all the technical features**, including the LDPC and BCC codecs, MCS 0~11 modulation, 20 to 160 MHz channel bandwidth (CBW) formats, up to 4x4 MIMO and even the 802.11ac/ax multi-user (MU) mode. PicoScenes sets a series of performance records in our benchmark,  such as up to 1 kHz CSI measurement at a 20 MHz bandwidth, a up to 4 kHz and up to 40 kHz insanely fast packet injection rates in real-time and signal-replay modes, respectively, and up to 100 Hz CSI measurement at a maximally 200 MHz bandwidth.

The Virtual SDR interface provides users a convenient way to generate, manipulate and test decoding the Wi-Fi baseband signals **without the cumbersome of connecting to real SDR devices**. With the virtual SDR devices, users may assess the impact of various PHY-layer parameters, such as carrier frequency offset (CFO), sampling frequency offset (SFO), symbol timing offset (STO), I/Q mismatching , and many other OFDM decoding settings. 

**For software**: PicoScenes is far beyond a simple CSI data logger. It is architecturally versatile and flexible. The Platform, essentially a Wi-Fi sensing middleware, encapsulates all the low-level features into a set of unified and hardware-independent APIs and exposes them to the upper-level plugin layer. PicoScenes plugins realize various measurement-specific missions, and users can **quickly prototype their own measurement plugins**. We demonstrate this platform flexibility through EchoProbe, a PicoScenes plugin, which features ms-grade round-trip CSI measurement and the spectrum scanning CSI measurement capability. 

You may refer to :doc:`why` to learn more about PicoScenes. We hope you enjoy the next ride of Wi-Fi sensing research, supercharged by PicoScenes!

.. note::

   This document is continuously being updated and expanded. If you have any suggestions, or do not find what you are looking for, then please find :ref:`tech_support` via PicoScenes Issue Tracker.

.. toctree::
   :maxdepth: 2
   :numbered:
   :caption: Table of Contents:
   
   why
   gallery
   users
   installation
   scenarios
   parameters
   matlab
   utilities
   troubleshooting
   plugin
   status
   resources
   License
   credits
