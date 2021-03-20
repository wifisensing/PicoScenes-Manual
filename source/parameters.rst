PicoScenes Program Options Reference
========================================

Program Options Hierarchy
-----------------------------

Various PicoScenes options (program parameters) are organized in a hierarchical structure as listed below:
    - Per-Plugin level options (Top)
        Each PicoScenes plugin can have its own program options. For example, EchoProbe plugin has a large set of options controlling many aspects of packet injection and round-trip measurement

    - Frontend level options
        PicoScenes provides two independent sets of options for QCA9300/IWL5300 and SDR hardware frontend. User specify different options for different Wi-Fi NICs or USRPs.

    - Platform Options
        These are a few global options that are valid *after* the launch of the PicoScenes platform.

    - Platform Startup Options (Bottom)
        These are a few global options that are valid *before* the launch of the PicoScenes platform.

    In the following text, we present the detailed description for each PicoScenes (including EchoProbe plugin) options.

    .. tip:: You can also look up the **complete** program options by running the command ``PicoScenes --help``, if you have successfully installed the PicoScenes.


Platform Startup Options (Bottom)
-----------------------------------
- ``--plugin-dir <new_plugin_dir>``
    + Description: change the plugins search directory to your specified, e.g.  ``--plugin-dir /home/YOUR_NAME/PicoScenes-PDK``. If not specified,PicoScenes will search plugins in /usr/local/PicoScenes/plugins.
    + Default: /usr/local/PicoScenes/plugins
    + Value Range: N/A
    + Notes: No
    + Example: --plugin-dir /home/YOUR_NAME/PicoScenes-PDK
- ``-d [ --display-level ] <log_diplay_level>``
    + Description: specify the log message display level.
    + Default: ``info``
    + Value Range: "[``vv``, ``verbose``, ``debug``, ``detail``, ``trace``, ``info``, ``warning``, ``error``, ``mute``]"
    + Notes: ``vv`` is the most verbose mode and ``mute`` silence all display
    + Example:  -d trace
- ``--no-hp``
    + Description: Disable process priority escalation. ``PicoScenes`` will by default try to escalate its process priority to improve the performance. You may specify ``--no-hp`` to skip the priority escalation.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: N/A



.. - ``-d --display-level <log_diplay_level>``
..     + Description: 
..     + Default: 
..     + Value Range: 
..     + Notes: 
..     + Example: 


Platform Options
-----------------------------------
- ``-i [ --interface ] arg``
    + Description: The name or ID of the target device/interface. This value MUST be provided to validate various device-oriented options.
        + For QCA9300/IWL5300 NIC, phyId, devId, monId and PhyPath are all acceptable. (What are these IDs? Refer to ``array_status`` bash script.)
        + For a single network-connected N210/X310 USRP, thename should be ``usrp<ip address of the USRP>``, e.g., ``usrp192.168.10.2``.
        + For a single PCI-E cable-connected X310 USRP, the name should be ``usrp<Resource Id of the X310>``, e.g., ``usrpRIO0``. You can lookup this ID via the UHD facility ``uhd_find_devices``.
        + To combine multiple network-connected (or MIMO cable connected) N210s/X310s, the name should be ``usrp<ip address of the USRP1,ip address of the USRP2,ip address of the USRP3...>``, e.g., ``usrp192.168.40.2,192.168.41.2``.
    + Default: N/A
    + Value Range: N/A
    + Notes: 
        + Note 1: For USRP, You can lookup the IP address or Resource ID via the UHD facility ``uhd_find_devices``. 
        + Note 2: For network connected USRPs, you MUST pay attention to check theaddress space matching between USRP IP address and the static IP address of your NIC. ``uhd_find_devices`` may find USRP devices even under mismatched address spaces, however, PicoScenes cannot initialize the USRP device in the mismatched situation.
    + Example: ``-i usrp192.168.10.2``
- ``--plot``
    + Description: Plot real-time CSI figure.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--plot``

.. todo:: ``--plot-rate`` need to modify.

- ``--plot-rate arg``
    + Description: Adjust the refresh rate of CSI plotting.
    + Default: 0.1
    + Value Range: 0.01~0.1
    + Notes: N/A
    + Example: N/A
- ``-h [ --help ]``
    + Description: Show help information.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``-h``

Frontend level options
-----------------------------------
QCA9300/IWL5300 NIC options
+++++++++++++++++++++++++++++++++++
- ``--freq arg``
    + Description: Specify the carrier frequency for both the QCA9300 and IWL5300. This option supports the scientific notation like 2412e6 or 2.412e9.
    + Default: The default value is the the current working frequency.
    + Value Range: The frequency synthesizer of QCA9300 hardware supports [2.2-2.9] GHz and [4.4 - 6.1] GHz in the 2.4 and 5 GHz bands, respectively. You can specify any frequency within the ranges.
    + Notes: 
        + We have observe the decline of Tx/Rx performance regards to the cross-band carrier frequency tuning, e.g., 2412e6->5200e6.We recommend to use ``array_prepare_for_picoscenes`` to performance the cross-band tuning.
        + IWL5300 do NOT support the arbitrary tuning of carrier carrier frequency, therefore, for IWL5300, this option is essentially a wrapper for the underlying channel selection, i.e., you can only specify the carrier frequencies of the standard channels like 2412e6, 2432e6, 5200e6, etc.
        + When operating in ``HT40+/-`` channel modes, this option, which always refers to the real carrier frequency, is not equal to the center frequency of ``HT40+/-``'s primary channel, e.g., if you want to communicate with a ``5200 HT40-`` channel, you should tune your carrier frequency to 5190e6 or 5200e6 for 40 or 20 MHz bandwidth, respectively.
    + Example: ``--freq 5200e6``
- ``--rate arg``
    + Description: Specify the channel bandwidth for both the QCA9300 and IWL5300. This option supports the scientific notation like ``20e6`` or ``25e6``.
    + Default: The default value is the the current working bandwidth.
    + Value Range: 
        + For QCA9300, the available rates under ``HT20`` channel mode are [2.5, 5, 7.5, 10, 12.5, 15, 17.5, 20, 25, 30, 35, 40] MHz; for ``HT40+/-`` channel modes the supported rates are [5, 10, 15, 20, 25, 30, 35 40, 45, 50, 55, 60, 65, 70, 75, 80] MHz.
        + For IWL5300, the driver does NOT support bandwidth arbitrary tuning, so this option only supports 20 or 40 MHz.
    + Notes: When HT20 mode communicate with ``HT40+/-`` modes with a non-standard bandwidth, you should tune the carrier frequency of the ``HT20`` side to the correct value. For example, with 20 MHz real bandwidth, ``HT40-`` channel mode at the 5190 MHz can ONLY communicate with a ``HT20`` mode with 5195 MHz carrier frequency.
    + Example: ``--rate 20e6``
- ``--txcm arg``
    + Description: Specify the transmit chain(s) for the QCA9300 and IWL5300 NICs. The mask are in 3-bit format,i.e., 1/2/4 for the 1st/2nd/3rd chain, 3 for both the 1st and 2nd chains and 7 for all threechains. 
    + Default: This value is 7 by default and is persistent until the next NIC reset.
    + Value Range: 1, 2, 3, 4, 5, 6, 7
    + Notes: 
        + When the number of the transmit chains(s), N_{tx}, is smaller than the number of transmit spatial-time streams, N_{sts}, the transmission is invalid.
        + Value 5 and 6 are not valid for both QCA9300 and IWL5300.
    + Example: ``--txcm 1``
- ``--rxcm arg``
    + Description: Specify the receive chain(s) for the QCA9300 and IWL5300 NICs. This option has the identicalformat as --txcm option.
    + Default: This value is 7 by default and is persistent until the next NIC reset.
    + Value Range: 1, 2, 3, 4, 5, 6, 7
    + Notes: 
        + When the number of the receive chains(s), N_{rx}, is smaller than N_{sts} of the transmitted packets, the receiver cannot decode the frame.
        + Value 5 and 6 are not valid for both QCA9300 and IWL5300.
    + Example: ``--rxcm 1``
- ``--txpower arg``
    + Description: Specify the transmit power (Tx power) in dBm for both the QCA9300 and IWL5300.
    + Default: 20
    + Value Range: 0 dBm ~ 30 dBm
    + Notes: This value is 20 by default and is persistent until the next NIC reset.
    + Example: ``--txpower 15``
- ``--pll arg``
    + Description: Specifying the PLL parameters for QCA9300. In most cases, you should use ``--rate`` option to change bandwidth. 
    + Default: N/A
    + Value Range: N/A
    + Notes: IWL5300 does not support this option.
    + Example: ``--pll 20e6``
- ``-p [ --cf-tuning-policy ] arg``
    + Description: Specify the tuning policy for QCA9300's carrier frequency. You can specify one of the three policies: ``chansel``, ``fastcc`` and ``reset``.
    + Default: ``fastcc``
    + Value Range: ``chansel``, ``fastcc`` and ``reset``
    + Notes: 
        + ``chansel`` refers to the direct tuning of the RF frequency synthesizer via hardware registers. Since this policy tunes ONLY the synthesizer and bypasses many other settings, this is the fastest but also the least reliablepolicy.
        + ``fastcc`` refers to the FAST Channel Change protocol in ath9k driver. This is the default policy in both the ath9k driver and PicoScenes.In ath9k driver, ``fastcc`` handles all non-crossband channel change.
        + ``reset`` refers to the longer and more complete channel channel protocol in ath9k driver, which includes hardware reset. In ath9kdriver ``reset`` handels cross band channel change.
    + Example: ``-p chansel``

.. todo:: Un-finished ``--sf-tuning-policy arg``

- ``--sf-tuning-policy arg``
    + Description: Specifying the tuning policy for QCA9300's baseband PLL. You can specify 0 or 1 for this option. This is currently an un-finished option.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: N/A

USRP frontend options
+++++++++++++++++++++++++++++++++++
- ``--freq arg``
    + Description: Specify the carrier frequency for SDR frontend. This option supports the scientific notation like 2412e6 or 2.412e9.
    + Default: This option has NO default value and is not persistent. You should specify it every time.
    + Value Range: N/A
    + Notes: 
        + The value range is based on your hardware. For example, UBX-40/160 daughterboard supports a range of 10-6000MHz. 
        + This option sets the same carrier frequency for both the Tx and Rx chains, though the hardware supports setting different frequencies for them.
        + For multi-channel configurations (multiple USRPs synchronized by MIMO cable or external clock source, or both channels of X310), this option will set the same frequency for each channel.
    + Example: ``--freq 5200e6``
- ``--rate arg``
    + Description: Specify the baseband sampling rate (or bandwidth) for SDR frontend. This option supports the scientific notation like 25e6 or 40e6.
    + Default: This option has NO default value and is not persistent. You should specify it every time.
    + Value Range: N/A
    + Notes: 
        + The value range is based on your hardware. For example, X310 motherboard supports a maximum sampling rate of 200 MHz. 
        + This option sets the same sampling rate for both the Tx and Rx chains, though the hardware supports setting different sampling rates for them.
        + Different hardware has different tuning granularity. For example, you can only specify 200/INT_N MHz sampling rate where INT_N is a positive integer.
    + Example: ``--rate 20e6``
- ``--tx-resample-ratio arg``
    + Description: Specify the Tx resampling ratio. This is a software-based Tx resampling mechanism to enable arbitrary channel bandwidth. For example, X310 cannot tune the baseband sampling rate to 80 MHz. To overcome this issues, we can tune the hardware to 100 MHz (by ``--rate 100e6``) andthen resample the Tx signal by 0.8 (by ``--tx-resample-ratio 0.8``).
    + Default: 1.0
    + Value Range: 0 ~ 1.0
    + Notes: 
        + This option is implemented byzero-order interpolation in software side, i.e., generate the signal by 80 MHzthen interpolate the signal to 100 MHz.
        + This interpolation is implemented by software, therefore the performance decline should be expected.
    + Example: ``--tx-resample-ratio 0.8``
- ``--rx-resample-ratio arg``
    + Description: Specify the Rx resampling ratio. This is a software-based Rx resampling mechanism to enable arbitrary channel bandwidth.For example, X310 cannot tune the baseband sampling rate to 80 MHz. To overcome this issues, we can tune the hardware to 100 MHz (by ``--rate 100e6``) andthen resample the Rx signal by 0.8 (by ``--rx-resample-ratio 0.8``).
    + Default: 1.0
    + Value Range: 0 ~ 1.0
    + Notes: 
        + This option is implemented byuniform signal dropping in software side,i.e., receive the signal by 100 MHz rate then decimate the signal to 80 MHz.
        + This resample is implemented by software, therefore the performance decline should be expected.
    + Example: ``--rx-resample-ratio 1.0``
- ``--clock-source arg``
    + Description: Specify the clock and time source for SDRfrontend.
    + Default: ``internal``
    + Value Range: ``internal``, ``external``, ``mimo``.
    + Notes: You can specify ``external`` for G-Octoclock based clock source or ``mimo`` for N210 MIMO-cable based clock source sharing.
    + Example: ``--clock-source external``
- ``--cfo arg``
    + Description: Specify the carrier frequency offset for Tx baseband. This option supports the scientific notation like 1e3 (1000 Hz cfo). This option is implemented by Wi-Fi baseband software, therefore the performance decline should be expected.
    + Default: 0.0
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--cfo 1e3``
- ``--sfo arg``
    + Description: Specify the sampling rate offset for Tx baseband. This option supports the scientific notation like 1e3 (1000 Hz sfo). This option is implemented by Wi-Fi baseband software,  therefore the performance decline should be expected.
    + Default: 0.0
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--sfo 1e3``
- ``--master-clock-rate arg``
    + Description: Specify the master clock rate of USRP. For Wi-Fi communication
    + Default: For N210 and X310, the default value is 100e6 and 200e6 respectively.
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--master-clock-rate 100e6``
- ``--tx-channel arg``
    + Description: Specify the Tx channel(s) for SDR frontend. The default value is 0, which mean 0-th channel. Multiple channel numbers are separated by a comma `,`.In multi-channel configurations, taking two combined X310s for example, you can specify ``0,1,2,3`` to use all 4 channels for Tx. You can also skip some of them, such as ``0,2,3`` which specify the 0-th, 1st and 3rd antenna for Tx.
    + Value Range: N/A
    + Notes: 
        + the order does not matter. ``0,2,3`` is equal to ``3,2,0``.
        + The physical mapping between the channel number and antenna is ordered. For example, assuming that we combine two X310s together with ``-i usrp192.168.40.2,192.168.41.2``, 0-th and 1st antennas correspond to the left and right daughterboards of the X310 with IP address 192.168.40.2; and 2nd and 3rd antennas correspond to the left and rightdaughterboards of the X310 with IP address 192.168.41.2.
    + Example: ``--tx-channel 0,1``
- ``--rx-channel arg``
    + Description: Specify the Tx channel(s) for SDR frontend. The default value is 0, which mean 0-th channel. Multiple channel numbers are separated by a comma `,`.This option has the identical format as ``--tx-channel``.
    + Default: ``0``
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--rx-channel 0,1``
- ``--rx-cbw arg``
    + Description: Specify the Channel Bandwidth (CBW) for Rx baseband. You can specify ``20``, ``40``, ``80`` or ``160``, which corresponds to 20/40/80/160MHz CBW for Rx baseband.
    + Default: ``20``
    + Value Range: ``20``, ``40``, ``80``, ``160``
    + Notes: In order to receive and correctly decode the packet transmitted in HT20/HT40/VHT80/VHT160 formats, you must specify Rx CBW to 20/40/80/160, respectively.
    + Example: ``--rx-cbw 40``
- ``--rx-ant arg``
    + Description: Specify to use which RX antenna
    + Default: ``RX2``
    + Value Range: ``TX/RX``, ``RX2``
    + Notes: For USRP UBX/CBX/SBX daughterboard, TX/RX or RX2
    + Example: ``--rx-ant TX/RX``
- ``--txpower arg``
    + Description: Tx gain.
    + Default: N/A
    + Value Range: 0 ~ 38 dB
    + Notes: N/A
    + Example: ``--txpower 20``
- ``--rx-gain arg``
    + Description: Rx gain.
    + Default: N/A
    + Value Range: 0 ~ 38 dB
    + Notes: N/A
    + Example: ``--rx-gain 20``
- ``--filter-bw arg``
    + Description: Baseband filter bandwidth (unit in Hz, scientific notation supported)
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: N/A
- ``--tx-to-file arg``
    + Description: Supply a file name (without extension, just the name), ``PicoScenes`` will save all the Tx signals to file. The signals will be save to a ``.bbsignals`` file with the specified file name.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``tx-to-file demo``
- ``--tx-from-file arg``
    + Description: Supply a file name (without extension, just the name), PicoScenes will replay the signal save in the ``.bbsignals`` file as if the signal is generated from the baseband.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--tx-from-file demo``
- ``--tx-from-file-delay arg``
    + Description: The delay (in ms) before Tx signal replay.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--tx-from-file-delay 1000``
- ``--rx-to-file arg ``
    + Description: Dump baseband signals received from SDR device to a ``.bbsignals`` file with the specified file name. This is actually theRx signal recorder.
    + Default: N/A
    + Value Range: N/A
    + Notes: When rx-to-file is ON, the received signal will NOT be sent to baseband for decoding.
    + Example: ``--rx-to-file demo``
- ``--rx-from-file arg``
    + Description: Replay baseband signals saved in the ``.bbsignals`` file as if the signal is received from the RF frontend. This is actually the Rx signal replay.
    + Default: N/A
    + Value Range: N/A
    + Notes: The Rx signal replay keeps the same pace with the Rx baseband, thereforethere will be no signal dropping.
    + Example: ``--rx-from-file demo``
- ``--rx-sensitivity arg``
    + Description: Specify the lowest power level (specified in dB) above the rx noise floor to trigger packet detection.
    + Default: 5
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--rx-sensitivity 10``
- ``--rx-cp-offset arg``
    + Description: Specify at which position of Cyclic Prefix is regard as the start of OFDM signal (pre-advancement)
    + Default: 0.75
    + Value Range: 0 ~ 1
    + Notes: N/A
    + Example: ``--rx-cp-offset 0.5``
- ``--tx-iq-mismatch arg``
    + Description: Specify Tx I/Q mismatch, for example ``1.5 15`` means 1.5dB Tx I/Q ratio and 15 degree of Tx I/Q crosstalk
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``tx-iq-mismatch "1.5 15"``
- ``--rx-iq-mismatch arg``
    + Description: Specify Rx I/Q mismatch, for example ``1.5 15`` means 1.5dB Rx I/Q ratio and 15 degree of Rx I/Q crosstalk
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``rx-iq-mismatch "1.5 15"``
- ``--disable-1ant-tx-4-extra-sounding``
    + Description: Enable a special HT-LTF demodulation mode when signal is received from a transmitter with only 1 TX antenna.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--disable-1ant-tx-4-extra-sounding``
- ``--enable-loopback``
    + Description: Enable USRP Rx loopback signal from Tx.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--enable-loopback``
- ``--enable-hw-acc``
    + Description: enable/or disable hardware acceleration for Wi-Fi packet detection (enabling requires our special firmware, false as default).
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--enable-hw-acc``

Per-Plugin level options (Top)
-----------------------------------

Echo probe option
+++++++++++++++++++++++++++++++++++
- ``-mode arg``
    + Description: Working mode.
    + Default: N/A
    + Value Range: ``injector``, ``logger```, ``initiator``, ``responder``
    + Notes: N/A
    + Example: ``--mode injector``

EchoProbe initiator options
+++++++++++++++++++++++++++++++++++
- ``--target-mac-address``
    + Description: MAC address of the injection target [ magic Intel ``00:16:ea:12:34:56`` is default].
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: N/A
- ``--5300``
    + Description: Both Destination and Source MAC addresses are set to [ magic Intel ``00:16:ea:12:34:56`` ].
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: N/A
- ``--cf``
    + Description: MATLAB-style specification for carrier frequency scan range, format ``begin:step:end``.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--cf 5200e6:20e6:5800e6``
- ``--sf``
    + Description: MATLAB-style specification for baseband sampling frequency multipler scan range, format ``begin:step:end``.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--sf 10e6:5e6:20e6``
- ``--repeat``
    + Description: The injection number per cf/bw combination.
    + Default: 100
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--repeat 1e4``
- ``--delay``
    + Description: The delay between successive injections(unit in us).
    + Default: 5e5
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--delay 5e3``
- ``--delayed-start``
    + Description: A one-time delay before injection(unit in us)
    + Default: 0
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--delayed-start 5e5``
- ``--format``
    + Description: 802.11 frame format.
    + Default: HT
    + Value Range: ``nonHT``, ``HT``, ``VHT``, ``HESU``
    + Notes: N/A
    + Example: ``--format VHT``
- ``--cbw``
    + Description: Channel Bandwidth (CBW) for injection(unit in MHz).
    + Default: 20
    + Value Range: ``20``, ``40``, ``80``, ``160``
    + Notes: N/A
    + Example: ``--cbw 40``
- ``--mcs``
    + Description: The MCS index for one single spatial stream.
    + Default: 0
    + Value Range: 0 ~ 11
    + Notes: N/A
    + Example: ``--mcs 4``
- ``--sts``
    + Description: Number of spatial time stream (STS).
    + Default: 1
    + Value Range: 1 ~ 4
    + Notes: N/A
    + Example: ``--sts 2``
- ``--ess``
    + Description: Number of Extension Spatial Stream for TX.
    + Default: 0
    + Value Range: 0 ~ 3
    + Notes: N/A
    + Example: ``--ess 2``
- ``--gi``
    + Description: Guarding Interval.
    + Default: 800
    + Value Range: ``400``, ``800``, ``1600``, ``3200``
    + Notes: N/A
    + Example: ``--gi 1600``
- ``--coding``
    + Description: Code scheme.
    + Default: BCC
    + Value Range: ``LDPC``, ``BCC``
    + Notes: N/A
    + Example: ``--coding LDPC``
- ``--injector-content``
    + Description: Content type for injector mode.
    + Default: full
    + Value Range: ``full``, ``header``, ``ndp``
    + Notes: N/A
    + Example: ``--injector-content header``
- ``--ifs``
    + Description: Inter-Frame Spacing in seconds.
    + Default: 20e-6
    + Value Range: N/A
    + Notes: N/A
    + Example: ``--ifs 10e-6``

Echo responder options
+++++++++++++++++++++++++++++++++++
- ``--ack-type``
    + Description: EchoProbe reply strategy.
    + Default: full
    + Value Range: ``full``, ``csi``, ``extra``, ``header``
    + Notes: N/A
    + Example: ``--ack-type csi``
- ``--ack-mcs``
    + Description: MCS value (for one single spatial stream) for ack packets, unspecified as default.
    + Default: N/A
    + Value Range: 0 ~ 11
    + Notes: N/A
    + Example: ``--ack-mcs 4``
- ``--ack-sts``
    + Description: The number of spatial time stream (STS) for ack packets, unspecified as default.
    + Default: N/A
    + Value Range: 0 ~ 23
    + Notes: N/A
    + Example: ``--ack-sts 3``
- ``--ack-cbw``
    + Description: Bandwidth for ack packets (unit in MHz), unspecified as default.
    + Default: N/A
    + Value Range:  ``20``, ``40``, ``80``, ``160``
    + Notes: N/A
    + Example: ``--ack-cbw 40``
- ``--ack-gi``
    + Description: Guarding-interval for ack packets, unspecified as default.
    + Default: N/A
    + Value Range:  ``400``, ``800``, ``1600``, ``3200``
    + Notes: N/A
    + Example: ``--ack-gi 800``
