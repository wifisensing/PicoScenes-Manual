PicoScenes: Supercharging Your Next Wi-Fi Sensing Research!
=============================================================

What is PicoScenes?
=====================

PicoScenes is a versatile and powerful middleware for CSI-based Wi-Fi sensing research. It helps researchers **overcome two barriers** in the reseach of Wi-Fi sensing: inadequate **hardware** features and insufficient measurement **software** functionality.

**In the hardware aspect**:

PicoScenes supports a wide range of CSI-extractable hardware, including both commercial off-the-shelf (COTS) Wi-Fi NICs and software-defined radio (SDR) devices. The supported COTS NIC models include Intel Wi-Fi 6E AX210 (**AX210**), Intel Wi-Fi 6 AX200 (**AX200**), Qualcomm Atheros AR9300 (**QCA9300**) and Intel Wireless Link 5300 (**IWL5300**). The supported SDR devices include the **HackRF One**, and *all* models of the **USRP** devices.

For COTS Wi-Fi NICs, PicoScenes provides many exclusive hardware features: 

  - Based on the AX200/AX210 NIC, PicoScenes is the first and currently the *only* public-available platform that enables **CSI extraction for the 802.11ax-format frames** using the commodity Wi-Fi hardware. The platform supports CSI extraction for **all formats (802.11a/g/n/ac/ax)** and **all bandwidths (20/40/80/160 MHz)**. Besides that, PicoScenes also enables the **CSI measurement for all overheard frames in monitor mode**, which transforms all the surrounding Wi-Fi devices into the excitation signals for your sensing application.

  - Based on the AX210 NIC, the next-gen of AX200 NIC, PicoScenes is the first and currently the *only* public-available platform that enables **packet injection and CSI measurement in the Wi-Fi 6 GHz band**. We unlock the continuously available spectrum from 5945 MHz to 7125 MHz, **a total of 1.18 GHz spectrum**, for the researchers around the globe. Inheriting all the good features of AX200, AX210 is currently the only Wi-Fi 6E NIC ready for Wi-Fi sensing. **Wi-Fi sensing enters the Wi-Fi 6E era**!
  
  - For the QCA9300 NIC, PicoScenes unlocks the **arbitrary tuning for both the carrier frequency and baseband sampling rate** (a total of 2.4 GHz spectrum available and 2.5 to 80 MHz bandwidth), and the **manual Rx gain control** (0 to 66 dB). The platform also features the QCA9300->IWL5300 CSI measurement, the Tx/Rx radio-chain control and transmission of the extra spatial sounding LTFs (HT-ELTFs).

For SDR, PicoScenes is currently the *only* platform that **can transform a SDR device into a SDR-based Wi-Fi NIC**, *i.e.*, transmitting/receiving Wi-Fi frames and measuring their CSI in real time just like a full-functional Wi-Fi NIC. It has four major highlights: full protocol compliance, rich PHY-layer control, complete and all-stage PHY-layer information, and high performance. 

  - PicoScenes Wi-Fi baseband is fully compliant with 802.11a/g/n/ac/ax/be Wi-Fi standards. It **covers almost all the advanced technical features**, i.e., transmitting and receiving Wi-Fi frames in *all-format* (supporting 802.11a/g/n/ac/ax), *all-bandwidth* (20/40/80/160/320 MHz), *all-coding* (LDPC and BCC), *all-MCS* (MCS 0 to 11), and *up to 4x4 MIMO* supports.
  - PicoScenes **grants users rich controls over the Tx/Rx process**, such as operating in non-standard carrier frequency and bandwidth, manual specification for the Tx/Rx carrier frequency offset (CFO), Tx/Rx sampling frequency offset (SFO), Rx symbol timing offset (STO), Tx/Rx I/Q mismatching, Tx/Rx resampling, and many OFDM encoding/decoding settings. PicoScenes is also the first platform that **provides signal precoding/steering capabilities**. With this feature, users can implement beamforming, phased array or arbitrary Tx equalization. Taking the phased array as an example, user only need to specify the antenna position and desired angle of departure (AoD), PicoScenes will calculate the steering matrix and apply it into the 802.11n/ac/ax spatial mapping mechanism.
  - PicoScenes **provides users the complete and all-stage PHY-layer information**. They cover not only the raw I/Q streams, but all the staged information produced by the OFDM demodulation process, such as the CSI computed by L-LTF (Legacy CSI), CFO estimation by L-LTF, CSI computed by HT/VHT/HE-LTF (HT/VHT/HE-CSI), CSI computed by OFDM pilot subcarriers (Pilot CSI), SFO estimation by Pilot CSI, pre-equalized data symbols, and the fundamental per-packet baseband signals.
  - PicoScenes is of **high-performance to support your realtime Wi-Fi sensing research**. It has achieved up to 1 kHz CSI measurement at a 20 MHz bandwidth, up to 4 kHz and up to 40 kHz packet injection rates in real-time and signal-replay modes, respectively. For timing-tolerant research, PicoScenes **provides signal record and replay functionalities for both the Tx and Rx streams**, allowing users to fully capture the signals and decode the frames without packet loss. We even provide a handy *Virtual SDR* mode by which the users can generate, manipulate and test decoding the Wi-Fi baseband signals *without connecting to an actual SDR device*.

**In the software aspect**: 

PicoScenes is far beyond a simple CSI data logger but a versatile Wi-Fi sensing platform. As far as we know, It is the first and currently the only platform that supports **multi-NIC concurrent CSI measurement**, which significantly simplifies the array-based CSI measurement. Besides that, it also features the live CSI plot, various low-level controls, and **packet injection in all-format and all-bandwidth**, which promises a fixed-rate CSI measurement. 

As a Wi-Fi sensing middleware, PicoScenes encapsulates the per-NIC low-level hardware controls into a set of unified APIs and exposes them to the upper-level plugin layer. Through the PicoScenes plugin mechanism, **complex and interactive CSI measurement tasks can be easily prototyped in a mission-focus manner**. We demonstrate this advantage by *EchoProbe*, a PicoScenes plugin, which provides *ms*-grade round-trip CSI measurement, large spectrum scanning and the most basic CSI data logging capabilities. 

PicoScenes MATLAB Toolbox (PMT) is the MATLAB parsing routine for the *.csi* file generated by the PicoScenes. The parsing can be as easy as just **dragging the .csi files into MATLAB**. The fundamental data structure is in versioned-segment format, which guarantees forward compatibility across the future upgrade.

The PicoScenes software ecosystem (customized driver, platform, and plugins) is **built against the latest kernel, packaged in the Debian .deb format, and auto-updated via the easy** *apt upgrade* **command**. A fresh-new installation can be as short as 10 minutes. Setting up a CSI-measurement environment can never be such easy!

You may refer to :doc:`why` to learn more about PicoScenes. We hope you enjoy the next ride of Wi-Fi sensing research, supercharged by PicoScenes!

.. toctree::
   :maxdepth: 2
   :numbered:
   :caption: Table of Contents:
   
   gallery
   users
   hardware
   installation
   scenarios
   parameters
   matlab
   utilities
   plugin
   status
   resources
   License
   troubleshooting
   eula
   credits
