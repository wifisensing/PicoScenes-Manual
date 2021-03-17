CSI Measurement using PicoScenes: Get Started
=================================================

On this page, we list all the Wi-Fi sensing scenarios supported by PicoScenes and demonstrate the software's primary usage. In each scenario, we provide a takeaway bash script that users can exercise the experiment right away.


.. important:: Before getting started, make sure you have successfully install the related hardware and the PicoScenes software. See also :doc:`installation` ahead.

Preliminary: How to specify which device we'd like to use?
-----------------------------------------------------------------------------

This was not a problem for the previous CSI tools, because they only support one device. 
In order to support multi-NIC concurrent operation in PicoScenes, an reliable and easy-to-use device (Wi-Fi NIC and SDR) naming system is required. We propose easy and intuitive solutions for both the commercial Wi-Fi NICs and SDR.

For Commercial Wi-Fi NICs
~~~~~~~~~~~~~~~~~~~~~~~~~~

Open a terminal and run ``array_status``. After a second or two, a list of all the installed Wi-Fi NICs will be shown in the terminal. The following screenshot shows a sample list of devices.

Looking at the first four columns of the output, we see that for each NIC, ``array_status`` shows four IDs or names for it, namely, PhyPath, PhyId, DeviceId and MonId. We explain the latter three first and then PhyPath:

- **PhyId**: this is the system level *Physical ID* for a Wi-Fi NIC, which is assigned by Linux kernel. This ID is mainly used for low-level hardware control.  This ID is subjected to change on every reboot.
- **DevId**: this is the system level *Device ID* for a Wi-Fi NIC, which is assigned by Linux kernel. This ID is mainly used for normal Wi-Fi connection. This ID is subjected to change on every reboot.
- **MonId**: this is the *Monitor interface ID* for a Wi-Fi NIC. The monitor interface and its ID can be created and assigned by user. This ID is mainly used for traffic monitoring and packet injection. This ID can be changed by user at any time.

You may have noticed the problems that *the system-assigned NIC IDs are not consistent across reboots*, which brings inconvenience to the selection from multiple NICs. To overcome this problem, we devise a new ID, named PhyPath. The biggest advantage is that **PhyPath is bounded to the PCI-E connection hierarchy, which is consistent across reboots and even system reinstallations**. For example, a Wi-Fi NIC with PhyPath ``3`` indicates that it is the third device in the PCI-E hierarchy, and a Wi-Fi NIC with PhyPath ``53`` indicates that the position of this NIC in the PCI-E hierarchy is the 3rd leaf node of the 5th branch node.
PhyPath is supported throughout the PicoScenes system, including the PicoScenes program, plugins and bash scripts. We recommend users to use PhyPath in all scenarios.

We provide the ID conversion scripts among PhyPath, PhyId, DevId and MonId, namely *ANY2PATH*, *ANY2DEV*, *ANY2PHY* and *ANY2MON*.

For USRP devices
~~~~~~~~~~~~~~~~~~~~

We devise a simple and intuitive naming system for USRP: ``usrp<IPADDRESS_or_RESOURCEID>``. For example, for a X310 with IP address 192.168.40.2, it can be represented by ``usrp192.168.40.2``.
The combined form of multiple USRPs can also be easily represented. For example, the combined form of two X310s can be represented by ``usrp192.168.40.2,192.168.41.2``.

.. important:: The order of the IP address matters! For example, 0-th and 3rd channel of ``usrp192.168.40.2,192.168.41.2`` refers to the first channel of the X310 with IP address 192.168.40.2 and the second channel of X310 with IP address 192.168.41.2.


.. _iwl5300-wifi-ap:

IWL5300 + Wi-Fi AP (Difficulty Level: Beginner)
--------------------------------------------------------------

IWL5300 NIC can measure CSI for the 802.11n frames sent from the connected Wi-Fi AP. By creating enough Wi-Fi traffic (like ping the AP), we can obtain continuous and smooth CSI measurement. 

Assuming you have already connected the IWL5300 NIC to a 802.11n compatible Wi-Fi AP with no password protection and are *pinging* the AP to create some Wi-Fi traffic, then there is only three steps to CSI measurement:

#. Lookup the IWL5300 NIC's PhyPath ID by ``array_status``. 
#. Assume the PhyPath is ``3``, then run command ``PicoScenes -d debug -i 3 --mode logger``
#. Exit CSI logging by pressing Ctrl+C

The above PicoScenes command has three program options *"-d debug -i 3 --mode logger"*, they can be interpreted as *"PicoScenes change the display level log message to debug (-d debug); make device <AnyId=3> switch to CSI logger mode (-i 3 --mode logger)"*. See :doc:`parameters` for more detail explanations.

The logged CSI data is stored in a ``rx_<Id>_<Time>.csi`` file in *present working directory (pwd)*. Open MATLAB, drag the .csi file into Command Window, the file will be parsed and stored as a MATLAB variable named *rx_<Id>_<Time>*.

.. _dual_nic_separate_machine:

Two QCA9300/IWL5300 NICs installed on two PCs, in monitor + injection mode (Difficulty Level: Easy)
--------------------------------------------------------------------------------------------------------------------

Due to its Tx/Rx flexibility, monitor mode + packet injection is the mostly used CSI measurement setup. PicoScenes significantly improves the measurement experience in three aspects:

- enables QCA9300 (Tx) -> IWL5300 (Rx) CSI measurement [not possible with Atheros CSI Tool]
- enables monitor mode + packet injection style measurement for QCA9300 [not possible with Atheros CSI Tool]
- adds an intuitive bash script ``array_prepare_for_picoscenes`` to put Wi-Fi NICs into monitor mode

Based on the above improvements, CSI measurement in monitor + injection mode is simplified to only 5 steps:

#. On both side, Lookup the Wi-Fi NIC's PhyPath ID by ``array_status``;
#. On both side, run ``array_prepare_for_picoscenes <NIC_PHYPath> <freq> <mode>`` to put the Wi-Fi NICs into monitor mode with the given channel frequency and HT mode. You may specify the frequency and mode values to any supported Wi-Fi channels, such as "2412 HT20', "2432 HT40-",  "5815 HT40+", etc. You can even omit <freq> and <mode>, in this case, "5200 HT20" will be the default.
#. Assuming a QCA9300 NIC is the Rx side (CSI measurement side), run ``PicoScenes -d debug -i <NIC_PHYPath> --mode logger`` and wait for packet injection;
#. Assuming another  QCA9300 NIC is the Tx side (packet injector side), run ``PicoScenes -d debug -i <NIC_PHYPath> --mode injector --repeat 1000 --delay 5000 -q``
#. Rx end exists CSI logging by pressing Ctrl+C

The explanations to the commands are as follows.
    
- The Rx end has the identical program options as the last scenarios. See also :ref:`iwl5300-wifi-ap`.
- The Tx end options ``PicoScenes -d debug -i <NIC_PHYPath> --mode injector --repeat 1000 --delay 5000 -q`` can be interpreted as *"PicoScenes change the display level of log message to debug (-d debug); make device <AnyId=NIC_PHYPath> switch to CSI injector mode (-i <NIC_PHYPath> --mode injector); injector will inject 1000 packets (--repeat 1000) with 200 Hz injection rate or with 5000us interval (--delay 5000); when injector finishes the job, PicoScenes quit (-q)"*. See :doc:`parameters` for more detail explanations.

The above commands assume that both the Tx and Rx ends are QCA9300 NICs. If the Tx/Rx combination changes, users may need to change the command. The details are listed below.

.. csv-table:: Cross-Model CSI Measurement Details
    :header: "Tx End Model", "Rx End Model", "Note"
    :widths: 20, 20, 60

    "QCA9300", "QCA9300", use the Tx and Rx above commands
    "QCA9300", "IWL5300", append ``--5300`` to the Tx end command
    "IWL5300", "QCA9300", PicoScenes DO NOT SUPPORTED
    "IWL5300", "IWL5300", use the above Tx and Rx commands


Two QCA9300/IWL5300 NICs installed on one single PC, in monitor + injection mode (Difficulty Level: Easy)
-------------------------------------------------------------------------------------------------------------------

The measurement in this scenario leverages the multi-NIC concurrent operation functionality.
PicoScenes adopts an intuitive CLI interface, so that users can specify concurrent operation without changing the commands. Since the commands used in this scenario remains the same as last scenario, users should refer to ::ref:`dual_nic_separate_machine` to understand the meaning of commands first.

Let assume Wi-Fi NICs with PhyPath ``3`` and ``4`` are the *injector* and *logger*, respectively,  the following code performs the monitor + injection on one single PC:

.. code-block:: bash

    PicoScenes "-d debug;
                -i 4 --mode logger; // this command line format support comments. Comments start with //
                -i 3 --mode injector --repeat 1000 --delay 5000; // NIC <3> in injector mode, injects 1000 packets with 5000us interval
                -q // -q is a shortcut for --quit"

Compared to the commands shown in the last scenario, this enhanced version wraps the entire the Tx and Rx commands as one long string input. The commands for each NIC are separated by a semicolon ``;``. You can also add comments as exemplified in the command.

PicoScenes parses this long string by localizing the semicolons and then the splitting the long string into multiple per-NIC command strings. It then parses and executes the per-NIC command string in order. 






















