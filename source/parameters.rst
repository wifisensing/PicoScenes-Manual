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



Per-Plugin level options (Top)
-----------------------------------

