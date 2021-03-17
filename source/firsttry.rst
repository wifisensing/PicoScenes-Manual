CSI Measurement using PicoScenes: Get Started
=================================================

On this page, we list all the Wi-Fi sensing scenarios supported by PicoScenes and demonstrate the software's primary usage. In each scenario, we provide a takeaway bash script that users can exercise the experiment right away.


.. important:: Before getting started, make sure you have successfully install the related hardware and the PicoScenes software. See also :doc:`installation` ahead.

Preliminary: How to specify which device we'd like to use?
-----------------------------------------------------------------------------

This was not a problems for previous CSI tools, because they only support one device. 
In order to support multi-NIC concurrent operation in PicoScenes, an reliable and easy-to-use device (Wi-Fi NIC and SDR) naming system is required. For commercial Wi-Fi NICs and SDR, we bring different solutions.

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


Scenario 1: IWL5300 + Wi-Fi AP (Difficulty Level: Beginner)
--------------------------------------------------------------

IWL5300 NIC can measure CSI for the 802.11n frames sent from the connected Wi-Fi AP. By creating enough Wi-Fi traffic (like ping the AP), we can obtain continuous and smooth CSI measurement. 

Assuming you have already connected the IWL5300 NIC to a 802.11n compatible Wi-Fi AP with no password protection and are *pinging* the AP to create some Wi-Fi traffic, then there is only two steps to CSI measurement:

#. Lookup the IWL5300's device ID by ``array_status``


Scenario 2: IWL5300 or IWL5300 in injection mode (Difficulty Level: Easy)
--------------------------------------------------------------------------------------




Scenario 3: IWL5300 + QCA9300 / IWL5300 in injection mode (Difficulty Level: Easy)
--------------------------------------------------------------------------------------