PicoScenes: Supercharging Your Next Wi-Fi ISAC Research!
=============================================================

PicoScenes is a powerful middleware for CSI-based Wi-Fi integrated sensing and communication (Wi-Fi ISAC) research that addresses two key barriers in the field: hardware limitations and software functionality.

**Hardware Side**

PicoScenes is compatible with a wide range of CSI-extractable devices, including commercial off-the-shelf (COTS) Wi-Fi NICs and software-defined radio (SDR) devices. The supported COTS NIC models include Intel Wi-Fi 6E AX210 (**AX210**), Intel Wi-Fi 6 AX200 (**AX200**), Qualcomm Atheros AR9300 (**QCA9300**), and Intel Wireless Link 5300 (**IWL5300**). The supported SDR devices include the HackRF One and *all* models of **USRP** devices.

For COTS Wi-Fi NICs, PicoScenes provides many exclusive hardware features: 

- AX200/AX210 NIC: PicoScenes is the first and currently the only publicly available platform that enables **CSI extraction for 802.11ax-format** frames using commodity Wi-Fi hardware. It supports CSI extraction for **all Wi-Fi formats (802.11a/g/n/ac/ax)** and **up to 160 MHz bandwidth**. Additionally, PicoScenes enables **CSI measurement for all overheard frames in monitor mode**, utilizing the surrounding Wi-Fi devices as excitation signals for sensing applications.

- AX210 NIC: PicoScenes is the first and currently the only publicly available platform that enables packet injection and CSI measurement in the **Wi-Fi 6 GHz band** using the AX210 NIC. It unlocks **a total of 1.18 GHz** spectrum from 5945 MHz to 7125 MHz, providing researchers worldwide with continuous spectrum availability for Wi-Fi sensing. The AX210 NIC, as the next-generation of AX200, is the only Wi-Fi 6E NIC ready for Wi-Fi sensing, marking the entrance of Wi-Fi sensing into the Wi-Fi 6E era.

- QCA9300 NIC: PicoScenes offers **arbitrary tuning for both carrier frequency and baseband sampling rate**, providing a total of **2.4 GHz-wide spectrum** availability and **2.5 to 80 MHz bandwidth**. It also includes **manual Rx gain control** ranging from 0 to 66 dB. The platform supports QCA9300 to IWL5300 CSI measurement, as well as Tx/Rx radio-chain control and transmission of **extra spatial sounding** LTFs (HT-ELTFs).

For SDR, PicoScenes is currently the *only* platform that can transform a SDR device into a SDR-based Wi-Fi NIC, *i.e.*, **transmitting/receiving Wi-Fi frames and measuring their CSI in real time just like a full-functional Wi-Fi NIC**. It has four major highlights: full protocol compliance, rich PHY-layer control, complete and all-stage PHY-layer information, and high performance. 

- **Full Protocol Compliance up to Wi-Fi 7**: PicoScenes Wi-Fi baseband supports transmitting and receiving Wi-Fi frames in all formats, including 802.11a/g/n/ac/**ax/be**, and across all bandwidths (20/40/80/**160/320 MHz**). It also supports all coding schemes (LDPC and BCC), *all modulation and coding schemes (MCS 0 to 11)*, and *up to 4x4 MIMO*.
- **Rich PHY-Layer Control**: PicoScenes **grants users extensive control over the transmission and reception process**. Users can operate in non-standard carrier frequencies and bandwidths, manually specify carrier frequency offset (CFO), sampling frequency offset (SFO), symbol timing offset (STO), I/Q mismatching, resampling, and various OFDM encoding/decoding settings. PicoScenes is the first platform to provide *signal precoding/steering capabilities*, allowing users to implement beamforming, phased array, or arbitrary Tx equalization. For example, users can specify antenna positions and desired angles of departure (AoD) for phased array applications, and PicoScenes will calculate the steering matrix and apply it to the spatial mapping mechanism of 802.11n/ac/ax/be.
- **Complete and All-Stage PHY-Layer Information**: PicoScenes provides users with comprehensive information about the PHY layer. This includes not only the *raw I/Q streams* but also all the staged information produced during the OFDM demodulation process. This information includes CSI computed by L-LTF (*Legacy CSI*), CSI computed by HT/VHT/HE/EHT-LTF (*HT/VHT/HE/EHT-CSI*), *CFO/SFO estimation*, and low-level *per-packet baseband signals*.
- **High Performance**: PicoScenes is designed to support real-time Wi-Fi sensing research with high performance. It can achieve up to 1 kHz CSI measurement at a 20 MHz bandwidth (single thread), support *multi-thread RX decoding*, and achieve packet injection rates of up to 4 kHz in real-time mode and up to 40 kHz in *signal-replay mode*. For timing-tolerant research, PicoScenes offers signal record and replay functionalities for both Tx and Rx I/Q streams, enabling users to capture signals and decode frames without packet loss. PicoScenes also provides a *Virtual SDR mode*, allowing users to generate, manipulate, and test Wi-Fi baseband signals without connecting to an actual SDR device.

**Software Side**: 

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
