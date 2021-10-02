PicoScenes: Wi-Fi Sensing Research, Supercharged!
====================================================

PicoScenes is a versatile and powerful Wi-Fi sensing platform middleware. It helps researchers **overcome two key barriers of modern Wi-Fi sensing research: inadequate sensing hardware and measurement software**.

**Hardware aspect**:

PicoScenes supports **multi-NIC concurrent operation** (including the packet injection, packet reception, CSI measurement, *etc*.) of the Intel Wireless-AC9260/AX200 (AC9260/AX200), Qualcomm Atheros AR9300 (QCA9300), Intel Wireless Link 5300 (IWL5300), USRP-based software-defined radio (SDR) devices and even the virtual SDR devices.

Based on the AX200 NIC, PicoScenes is the first (and currently the only) public-available platform that enables **CSI extraction for the 802.11ax-format frames using the commodity Wi-Fi hardware**. More specifically, the platform supports **CSI extraction for all formats (802.11/a/g/n/ac/ax) and all bandwidths (20/40/80/160 MHz)**. Besides that, PicoScenes also enables the **CSI measurement for all overheard frames** in monitor mode, which *unprecedentedly transforms all the surrounding Wi-Fi devices into the signal sources of your sensing application*.

For the QCA9300 NIC, PicoScenes unlocks the **arbitrary tuning** for both the carrier frequency (a total of 2.4 GHz spectrum available) and baseband sampling rate (from 2.5 to 80 MHz), enables the **manual Rx gain control** (0 to 66 dB), QCA9300->IWL5300 CSI measurement, supports the Tx/Rx antenna specification and transmission of the extra spatial sounding LTF (HT-ELTF).

For SDR, PicoScenes integrates a high-performance software baseband implementation for 802.11a/g/n/ac/ax protocols. It **covers almost all the advanced technical features**, including the LDPC and BCC codecs, MCS 0~11 modulation, 20 to 160 MHz channel bandwidth (CBW) formats, up to 4x4 MIMO and even the 802.11ac/ax multi-user (MU) mode. PicoScenes sets a series of performance records in our benchmark,  such as up to 1 kHz CSI measurement at a 20 MHz bandwidth, a up to 4 kHz and up to 40 kHz insanely fast packet injection rates in real-time and signal-replay modes, respectively.

The Virtual SDR interface provides users a convenient way to generate, manipulate and test decoding the Wi-Fi baseband signals **without connecting to real SDR device**. With the Virtual SDR, users may assess the impact of various PHY-layer parameters, such as carrier frequency offset (CFO), sampling frequency offset (SFO), symbol timing offset (STO), I/Q mismatching and many other OFDM decoding settings. 

**Software aspect**: 

PicoScenes is far beyond a simple CSI data logger. It is essentially a Wi-Fi sensing middleware, encapsulating all the low-level hardware controls into a set of unified APIs and exposing them to the upper-level plugin layer. PicoScenes plugins realize various measurement-specific missions, and users can **quickly prototype their own measurement plugins**. We demonstrate the platform flexibility through EchoProbe, a PicoScenes plugin, which features *ms*-grade round-trip CSI measurement, spectrum scanning CSI measurement and the basic CSI data logging capabilities. 

You may refer to :doc:`why` to learn more about PicoScenes. We hope you enjoy the next ride of Wi-Fi sensing research, supercharged by PicoScenes!

.. note::

   The whole documentation is being updated for the latest AC9260/AX200 support. Inconsistent context and some key information missing is expected.

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
