PicoScenes Program Options
==============================

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
        * For QCA9300/IWL5300 NIC, phyId, devId, monId and PhyPath are all acceptable. (What are these IDs? Refer to ``array_status`` bash script.)
        * For a single network-connected N210/X310 USRP, thename should be ``usrp<ip address of the USRP>``, e.g., ``usrp192.168.10.2``.
        * For a single PCI-E cable-connected X310 USRP, the name should be ``usrp<Resource Id of the X310>``, e.g., ``usrpRIO0``. You can lookup this ID via the UHD facility ``uhd_find_devices``.
        * To combine multiple network-connected (or MIMO cable connected) N210s/X310s, the name should be ``usrp<ip address of the USRP1,ip address of the USRP2,ip address of the USRP3...>``, e.g., ``usrp192.168.40.2,192.168.41.2``.
    + Default: N/A
    + Value Range: N/A
    + Notes: 
        * Note 1: For USRP, You can lookup the IP address or Resource ID via the UHD facility ``uhd_find_devices``. 
        * Note 2: For network connected USRPs, you MUST pay attention to check theaddress space matching between USRP IP address and the static IP address of your NIC. ``uhd_find_devices`` may find USRP devices even under mismatched address spaces, however, PicoScenes cannot initialize the USRP device in the mismatched situation.
    + Example: -i usrp192.168.10.2
- ``--plot``
    + Description: Plot real-time CSI figure.
    + Default: N/A
    + Value Range: N/A
    + Notes: N/A
    + Example: N/A

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
    + Example: -h

Frontend level options
-----------------------------------
QCA9300/IWL5300 NIC options
+++++++++++++++++++++++++++++++++++
- ``--freq arg``
    + Description: Specify the carrier frequency for both the QCA9300 and IWL5300. This option supports the scientific notation like 2412e6 or 2.412e9.
    + Default: The default value is the the current working frequency.
    + Value Range: The frequency synthesizer of QCA9300 hardware supports [2.2-2.9] GHz and [4.4 - 6.1] GHz in the 2.4 and 5 GHz bands, respectively. You can specify any frequency within the ranges.
    + Notes: 
        * We have observe the decline of Tx/Rx performance regards to the cross-band carrier frequency tuning, e.g., 2412e6->5200e6.We recommend to use ``array_prepare_for_picoscenes`` to performance the cross-band tuning.
        * IWL5300 do NOT support the arbitrary tuning of carrier carrier frequency, therefore, for IWL5300, this option is essentially a wrapper for the underlying channel selection, i.e., you can only specify the carrier frequencies of the standard channels like 2412e6, 2432e6, 5200e6, etc.
        * When operating in ``HT40+/-`` channel modes, this option, which always refers to the real carrier frequency, is not equal to the center frequency of ``HT40+/-``'s primary channel, e.g., if you want to communicate with a ``5200 HT40-`` channel, you should tune your carrier frequency to 5190e6 or 5200e6 for 40 or 20 MHz bandwidth, respectively.
    + Example: --freq 5200e6
- ``--rate arg``
    + Description: Specify the channel bandwidth for both the QCA9300 and IWL5300. This option supports the scientific notation like ``20e6`` or ``25e6``.
    + Default: The default value is the the current working bandwidth.
    + Value Range: 
        * For QCA9300, the available rates under ``HT20`` channel mode are [2.5, 5, 7.5, 10, 12.5, 15, 17.5, 20, 25, 30, 35, 40] MHz; for ``HT40+/-`` channel modes the supported rates are [5, 10, 15, 20, 25, 30, 35 40, 45, 50, 55, 60, 65, 70, 75, 80] MHz.
        * For IWL5300, the driver does NOT support bandwidth arbitrary tuning, so this option only supports 20 or 40 MHz.
    + Notes: When HT20 mode communicate with ``HT40+/-`` modes with a non-standard bandwidth, you should tune the carrier frequency of the ``HT20`` side to the correct value. For example, with 20 MHz real bandwidth, ``HT40-`` channel mode at the 5190 MHz can ONLY communicate with a ``HT20`` mode with 5195 MHz carrier frequency.
    + Example: --rate 20e6
- ``--txcm arg``
    + Description: Specify the transmit chain(s) for the QCA9300 and IWL5300 NICs. The mask are in 3-bit format,i.e., 1/2/4 for the 1st/2nd/3rd chain, 3 for both the 1st and 2nd chains and 7 for all threechains. 
    + Default: This value is 7 by default and is persistent until the next NIC reset.
    + Value Range: 1, 2, 3, 4, 5, 6, 7
    + Notes: 
        * When the number of the transmit chains(s), N_{tx}, is smaller than the number of transmit spatial-time streams, N_{sts}, the transmission is invalid.
        * Value 5 and 6 are not valid for both QCA9300 and IWL5300.
    + Example: --txcm 1
- ``--rxcm arg``
    + Description: Specify the receive chain(s) for the QCA9300 and IWL5300 NICs. This option has the identicalformat as --txcm option.
    + Default: This value is 7 by default and is persistent until the next NIC reset.
    + Value Range: 1, 2, 3, 4, 5, 6, 7
    + Notes: 
        * When the number of the receive chains(s), N_{rx}, is smaller than N_{sts} of the transmitted packets, the receiver cannot decode the frame.
        * Value 5 and 6 are not valid for both QCA9300 and IWL5300.
    + Example: --rxcm 1
- ``--txpower arg``
    + Description: Specify the transmit power (Tx power) in dBm for both the QCA9300 and IWL5300.
    + Default: 20
    + Value Range: 0 dBm ~ 30 dBm
    + Notes: This value is 20 by default and is persistent until the next NIC reset.
    + Example: --txpower 15
- ``--pll arg``
    + Description: Specifying the PLL parameters for QCA9300. In most cases, you should use ``--rate`` option to change bandwidth. 
    + Default: N/A
    + Value Range: N/A
    + Notes: IWL5300 does not support this option.
    + Example: --pll 20e6
- ``-p [ --cf-tuning-policy ] arg``
    + Description: Specify the tuning policy for QCA9300's carrier frequency. You can specify one of the three policies: ``chansel``, ``fastcc`` and ``reset``.
    + Default: ``fastcc``
    + Value Range: ``chansel``, ``fastcc`` and ``reset``
    + Notes: 
        * ``chansel`` refers to the direct tuning of the RF frequency synthesizer via hardware registers. Since this policy tunes ONLY the synthesizer and bypasses many other settings, this is the fastest but also the least reliablepolicy.
        * ``fastcc`` refers to the FAST Channel Change protocol in ath9k driver. This is the default policy in both the ath9k driver and PicoScenes.In ath9k driver, ``fastcc`` handles all non-crossband channel change.
        * ``reset`` refers to the longer and more complete channel channel protocol in ath9k driver, which includes hardware reset. In ath9kdriver ``reset`` handels cross band channel change.
    + Example: -p chansel

.. todo:: Un-finished ``--sf-tuning-policy arg``

- ``--sf-tuning-policy arg``
    + Description: Specifying the tuning policy for QCA9300's baseband PLL. You can specify 0 or 1 for this option. This is currently an un-finished option.
    + Default: N/A
    + Value Range: 0, 1
    + Notes: N/A
    + Example: -h
USRP frontend options
+++++++++++++++++++++++++++++++++++


Per-Plugin level options (Top)
-----------------------------------

