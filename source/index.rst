PicoScenes: Supercharging Your Next Wi-Fi Sensing Research!
=============================================================

PicoScenes is a versatile and powerful middleware for CSI-based Wi-Fi sensing research. It helps researchers **overcome two barriers** in the Wi-Fi sensing research: inadequate hardware features and insufficient measurement software functionality.

**In the hardware aspect**:

PicoScenes supports the *most* CSI-extractable hardware, namely the Intel Wi-Fi 6E AX210 (**AX210**), Intel Wi-Fi 6 AX200 (**AX200**), Qualcomm Atheros AR9300 (**QCA9300**), Intel Wireless Link 5300 (**IWL5300**) and all models of the **USRP**-based SDR devices.

- Based on the AX210 NIC, the next-gen of AX200 NIC, PicoScenes is the first and currently the only public-available platform that enables **packet injection and CSI measurement in the Wi-Fi 6 GHz band**. In this band, researchers can access the continuously available spectrum from 5955 MHz to 7115 MHz, **a total of 1.18 GHz spectrum**. Besides the 6-GHz band support, the AX210 inherits all the features of the AX200. **Wi-Fi sensing enters the 802.11ax + 6GHz era**!
  
- Based on the AX200 NIC, PicoScenes is the first and currently the only public-available platform that enables **CSI extraction for the 802.11ax-format frames** using the commodity Wi-Fi hardware. The platform supports CSI extraction for **all formats (802.11a/g/n/ac/ax)** and **all bandwidths (20/40/80/160 MHz)**. Besides that, PicoScenes also enables the **CSI measurement for the overheard frames in monitor mode**, which transforms all the surrounding Wi-Fi devices into the signal sources of your sensing application.

- For the QCA9300 NIC, PicoScenes unlocks the **arbitrary tuning for both the carrier frequency and baseband sampling rate** (a total of 2.4 GHz spectrum available and 2.5 to 80 MHz bandwidth), and the **manual Rx gain control** (0 to 66 dB). The platform also features the QCA9300->IWL5300 CSI measurement, the Tx/Rx radio-chain control and transmission of the extra spatial sounding LTFs (HT-ELTFs).

- For SDR, PicoScenes is currently the *only* platform that **can turn your SDR device into a SDR-based Wi-Fi NIC**, *i.e.*, transmitting/receiving Wi-Fi frames and measuring their CSI in real time just like a full-functional Wi-Fi NIC. It has four major highlights: full protocol compliance, rich PHY-layer control, complete and all-stage PHY-layer information, and high performance. 

  - PicoScenes Wi-Fi baseband is fully compliant with 802.11a/g/n/ac/ax Wi-Fi standards and **covers almost all the advanced technical features**, i.e., transmitting and receiving Wi-Fi frames in *all-format* (supporting 802.11a/g/n/ac/ax), *all-bandwidth* (20/40/80/160 MHz), *all-coding* (LDPC and BCC), *all-MCS* (MCS 0 to 11), and *up to 4x4 MIMO* supports.
  - PicoScenes **grants users rich controls over the Tx/Rx process**, such as operating in non-standard carrier frequency and bandwidth, manual specification for the Tx/Rx carrier frequency offset (CFO), Tx/Rx sampling frequency offset (SFO), Rx symbol timing offset (STO), Tx/Rx I/Q mismatching, Tx/Rx resampling, and many OFDM encoding/decoding settings.
  - PicoScenes **provides users the complete and all-stage PHY-layer information**. They cover not only the raw I/Q streams, but all the staged information produced by the OFDM demodulation process, such as the CSI computed by L-LTF (Legacy CSI), CFO estimation by L-LTF, CSI computed by HT/VHT/HE-LTF (HT/VHT/HE-CSI), CSI computed by OFDM pilot subcarriers (Pilot CSI), SFO estimation by Pilot CSI, pre-equalized data symbols, and the fundamental per-packet baseband signals.
  - PicoScenes is **fast enough to support your realtime Wi-Fi sensing research**. It has achieved up to 1 kHz CSI measurement at a 20 MHz bandwidth, up to 4 kHz and up to 40 kHz packet injection rates in real-time and signal-replay modes, respectively. For timing-tolerant research, PicoScenes **provides signal record and replay functionalities for both the Tx and Rx streams**, allowing users to fully capture the signals and decode the frames without packet loss. We even provide a handy *Virtual SDR* mode by which the users can generate, manipulate and test decoding the Wi-Fi baseband signals *without connecting to an actual SDR device*.

**In the software aspect**: 

PicoScenes is far beyond a simple CSI data logger but a versatile Wi-Fi sensing platform. As far as we know, It is the first and currently the only platform that supports **multi-NIC concurrent CSI measurement**, which significantly simplifies the array-based CSI measurement. Besides that, it also features the live CSI plot, various low-level controls, and **packet injection in all-format and all-bandwidth**, which promises a fixed-rate CSI measurement. 

As a Wi-Fi sensing middleware, PicoScenes encapsulates the per-NIC low-level hardware controls into a set of unified APIs and exposes them to the upper-level plugin layer. Through the PicoScenes plugin mechanism, **complex and interactive CSI measurement tasks can be easily prototyped in a mission-focus manner**. We demonstrate this advantage by *EchoProbe*, a PicoScenes plugin, which provides *ms*-grade round-trip CSI measurement, large spectrum scanning and the most basic CSI data logging capabilities. 

PicoScenes MATLAB Toolbox (PMT) is the MATLAB parsing routine for the *.csi* file generated by the PicoScenes. The parsing can be as easy as just **dragging the .csi files into MATLAB**. The fundamental data structure is in versioned-segment format, which guarantees forward compatibility across the future upgrade.

The PicoScenes software ecosystem (customized driver, platform, and plugins) is **built against the latest kernel, packaged in the Debian .deb format, and auto-updated via the easy** *apt upgrade* **command**. A fresh-new installation can be as short as 10 minutes. Setting up a CSI-measurement environment never can be such easy!

You may refer to :doc:`why` to learn more about PicoScenes. We hope you enjoy the next ride of Wi-Fi sensing research, supercharged by PicoScenes!

News!
======

- Feb. 19, 2022 PicoScenes License Plan (PSLP) upgraded to v0.2.1, see :doc:`License` for more details.
- Feb. 10, 2022 PicoScenes adds Tx Signal Precoding API.
- Dec. 12, 2021 PicoScenes MATLAB Toolbox is now open-sourced through its independent git repo `PicoScenes MATLAB Toolbox Core <https://gitlab.com/wifisensing/PicoScenes-MATLAB-Toolbox-Core>`_.
- Nov. 9, 2021 PicoScenes now supports the Packet injection and CSI measurement in the 6 GHz band. Wi-Fi sensing enters the 802.11ax + 6GHz era!
- Oct. 31, 2021 Add PicoScenes License Plan (PSLP) v0.1.10 in :doc:`License` page.
- Oct. 24, 2021 Add all-format/all-bandwidth packet injection for AX200.
- Oct. 16, 2021 Add AX200 usage in :doc:`scenarios` page.
- Oct. 10, 2021 Add :doc:`hardware` page.
- Oct. 4, 2021 Add versioning and auto-update for PicoScenes MATLAB Toolbox.
- Oct. 3, 2021 Announcing the AX200 support officially!


.. toctree::
   :maxdepth: 2
   :numbered:
   :caption: Table of Contents:
   
   why
   gallery
   users
   hardware
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
