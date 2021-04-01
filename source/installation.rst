============================
PicoScenes Installation
============================


Hardware Installation
=======================

PicoScenes currently supports two commercial Wi-Fi NIC models, the QCA9300 and IWL5300, and literally all USRP models. Among them, B210, N210 and X310 models have been practically tested in our lab. For other high-end USRP models, such as the E300/N300 series, PicoScenes *should* be able to support them in out-of-box way.

One of the most welcomed features of the PicoScenes is the concurrent operation of multiple RF frontends, i.e., simultaneous CSI measurement or packet injection on a NIC or SDR array. To help you get the hardware ready quickly, we share our hardware preparation experience, mainly focusing on the multi-devices setup.

Installation of (Multiple) QCA9300 or IWL5300 NICs
+++++++++++++++++++++++++++++++++++++++++++++++++++++

We recommend three multi-NIC installation methods.

Mini PCI-E to PCI-E 1x adapter-based multi-NIC installation
    With the help of the Mini PCI-E to PCI-E 1x adapter, you can install the QCA9300 and IWL5300 directly on the motherboard. 

    However, although the motherboard typically offers 4-6 PCI-E slots, the number of PCI-E slots remaining is less than 3 because the graphic card, attached NVMe board, or 10GbE ethernet may occupy 2 or 3 slots.

    To overcome this issue, you may choose the motherboard primarily designed for cryptocurrency mining, such as MSI B360-F Pro. These motherboards have more than a dozen of PCI-E 1x slots, and you can use *PCI-E slot riser* to install a Wi-Fi NIC for each of them.

Multi-Mini PCI-E slots-based multi-NIC installation
    This is the most convenient multi-NIC installation approach. Multiple onboard Mini PCI-E slots spare the need for Mini PCI-E to PCI-E 1x adaptors and also present a highly compact factor. 
    There are many Intel NUC models equipped with two Mini PCI-E slots. However, it is troublesome always to connect a power cable; after all, they are not laptops
    
    Pursuing a wire-free multi-NIC solution, we recommend ThinkPad X201. Despite a ten-year-old laptop model, its motherboard provided two full/half-height Mini PCI-E slots, and we can install the QCA9300 or IWL5300 NICs in both of them.

    Even better, **X201 enables you to install three SMA-based external antennas!** The FPC-connected daughter board of X201, which accounts for Modem, audio In/Out and a USB port, can be safely removed, leaving three size compatible holes for installing SMA external antennas. The following photo shows our modified ThinkPad X201 equipped with both the QCA9300 and IWl5300 and three external antennas.

    .. figure:: /images/X201-External-Antennas.jpg
        :figwidth: 1000px
        :target: /images/X201-External-Antennas.jpg
        :align: center

        Modified ThinkPad X201 laptop equipped with 3 external SMA antennas

    .. warning::
        The official BIOS of ThinkPad X201 forbids changing Wi-Fi NIC. Before changing or adding another Wi-Fi NIC, you may have to flash the modified BIOS, which white-lists the 3rd-party and the second Wi-Fi NICs. You may visit https://zpj.io/replace-install-nics-for-thinkpad-x201/ for assistance (A Chinese document, machine translation may be required).

PCI-E bridge adapter-based multi-NIC installation
    The PCI-E bridge adapter can split one PCI-E connection into multiple, just like a PCI-E hub. Therefore, you may install connect multiple NICs to only one of the motherboard PCI-E slots via the bridge adapter.

    And even more so, you may build a multi-layer hierarchy of the bridge adapters and install QCA9300 or IWL5300 to all its leaf nodes. In this way, you may install over 100 Wi-Fi NICs to your system in theory. To validate the feasibility of this approach, we built a 27-NIC Wi-Fi sensing array using a 3-layer hierarchy of the 1 to 3 PCI-E bridge adapters. The figure below shows the picture and layout of the 27-NIC array. The entire array is encapsulated in an IKEA box.    

    .. figure:: /images/NICArrayLayout-horizontal.jpg
        :figwidth: 1000px
        :target: /images/NICArrayLayout-horizontal.jpg
        :align: center

        27-NIC Wi-Fi sensing array built upon 1-to-3 bridge adapters


Installation of (Multiple) USRP N210 and X310
++++++++++++++++++++++++++++++++++++++++++++++++

Follow the official USRP manual
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes’s support for USRP devices is established upon UHD software, the USRP hardware driver. Therefore, you should first set up your hardware/software according to the official   `USRP Hardware Driver and USRP Manual <https://files.ettus.com/manual/index.html>`_. For N210 and X310 models, you should read the following three documents carefully:

- `Multiple USRP configuration <https://files.ettus.com/manual/page_multiple.html>`_
- `USRP Hardware Driver and USRP Manual: USRP2 and N2x0 Series <https://files.ettus.com/manual/page_usrp2.html>`_
- `USRP Hardware Driver and USRP Manual: USRP X3x0 Series <https://files.ettus.com/manual/page_usrp_x3x0.html>`_

Some suggestions based on our previous experience:
    - For X310, **don't use the PCI-E cable-based connection**. Besides the notably expensive cables, it has two main drawbacks. First, the PCI-E-based connection is inefficient in that each link can only connect one X310; therefore multi-X310 connection requires you to install multiple PCI-E extension boards, which is very expensive and is even impossible for a regular desktop PC with few spare PCI-E slots. Second, the UHD software doesn't support the hybrid combination of the PCI-E-based link and the GbE/10GbE-based link. This restriction further devalues the PCI-E-based link.
    - For both N210/X310, **we recommend Intel X710 Quad Port 10 Gb Ethernet Adapter**, a reasonable and cost-effective solution for multiple N210 and X310 connections. It occupies only one full-size PCI-E slot but provides four 10GbE ports, allowing you to drive up to 4 X310s or eight independent full-duplex channels.
    - As clearly stated in `Multiple USRP configuration <https://files.ettus.com/manual/page_multiple.html>`_, UHD only supports combining multiple USRPs of the same model, and currently only N2x0 and X3x0 series are combination-ready.
    - For both the N210 and X310, please consider using the UBX-40/UBX-160 daughterboard first. UBX-40 and UBX-160, though expensive, are the only full-duplex daughterboards that support daughterboard-level phase synchronization. And only with this level of synchronization, can you realize the phased-array functionality.
    - Please pay special attention to the allocation of IP addresses. For network-based connections, the NIC port and the connected USRP must be in the same subnet. However, if they are not in the same subnet, the UHD device discovery program *udh_find_devices* can still find the devices, but PicoScenes cannot initialize the device correctly.
    - For N210, MIMO cable is an easy way to achieve MIMO and phased array, except for its narrow bandwidth.
    - For clock distribution, OctoClock-G is a cost-effective choice that distributes the GPS-disciplined clocks to up to eight USRPs.

Verify the installation of N210/X310
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is a four-stage verification process to ensure that your USRP is ready for PicoScenes.

Confirm the hardware connection
*********************************

Open a terminal and run the following command

.. code-block:: bash

        udh_find_devices

`udh_find_devices` is the device discovery program provided by UHD. It will list all the connected USRP devices. If a device is not shown in the list, you should refer to the USRP manual to check the hardware connection.


Confirm the firmware version
*********************************

.. code-block:: bash

        uhd_usrp_probe

`uhd_usrp_probe` prints the hardware details of all connected devices. It also checks whether the devices' firmwares are consistent with the UHD software installed on the host computer. If the inconsistency is detected, you may use ``uhd_image_loader`` command to flash the latest firmwares to the USRP:

For USRP N210 device, run:

.. code-block:: bash

    uhd_image_loader --args=type=usrp2

For USRP X310 device, run:

.. code-block:: bash

    uhd_image_loader --args=type=x300


Confirm the signal reception (Rx)
*********************************

Check whether your USRP can receive the signal:

.. code-block:: bash

    uhd_fft --args="addr=<YOUR_USRP_IP_ADDRESS>" -f 2200e6 -s 10e6

In `uhd_fft`,you should fill in the `addr` parameter according to your device address.

Perform Tx/Rx calibration
***********************************************************

Finally, execute the following three commands in sequence to calibrate the Tx/Rx signal.

.. code-block:: bash

    uhd_cal_rx_iq_balance
    uhd_cal_tx_dc_offset
    uhd_cal_tx_iq_balance

Install PicoScenes
=========================

Prerequisites
++++++++++++++++++++

- Operating System: PicoScenes **only** supports Ubuntu 20.04 and its variants (Linux Mint, Kubuntu, Xubuntu, etc.).
- Internet connection: the Internet connection is required during the installation process and is also required for regular license checking in future use.
- Permit to install the latest kernel version: PicoScenes depends on and is always built against the latest kernel version. During the first installation and subsequent upgrades, your system **may be forced to update to the latest kernel version**.
- The latest MATLAB version on Linux/macOS: PicoScenes MATLAB Toolbox, the CSI measurement data decoding routine in MATLAB, **only** supports the R2020b or R2021a version of MATLAB on Linux/macOS platforms.
    
    .. note::
        PicoScenes MATLAB Toolbox is being ported the Windows platform.

Install PicoScenes via apt
++++++++++++++++++++++++++++

If your system meets the above requirements, you can start the installation now.

#. Download and install PicoScenes Source Updater
    - Click :download:`PicoScenes Source Updater <https://zpj.io/PicoScenes/pool/main/picoscenes-source-updater.deb>` and choose 'Open with ``GDebi Package Installer``'
    
    - Click `Install Package`.

    .. note:: PicoScenes Source Updater doesn't install PicoScenes software but registers the PicoScenes software repository to your system so that PicoScenes can be installed and auto-upgraded via the Debian apt facilities.

#. Update the cache of apt repositories
    Open a terminal and run the following command:
    
    .. code-block:: bash

        sudo apt update

    When this command finishes, you can verify the result. Run ``apt list picoscenes-*`` in the terminal. You should see at least the following packages:

    .. code-block:: bash

        picoscenes-all   picoscenes-platform   picoscenes-source-updater  picoscenes-driver-modules-XXXX

    Seeing these available `picoscenes-*` packages means PicoScenes repository is successfully added to your system.

#. Install PicoScenes software
    Run the following command:
        
    .. code-block:: bash

        sudo apt install picoscenes-all

    After a few minutes of package downloading (the duration depends on your network), a EULA message, similar to the following screenshot, will appear in the terminal. You will read the EULA and decide if you agree to the listed terms. You can press up/down arrow keys to view the full content and press TAB to move the cursor to the <Ok>. You finish the reading of EULA by pressing the <Ok>.

    .. figure:: /images/PicoScenes-platform-EULA.png
        :figwidth: 1000px
        :target: /images/PicoScenes-platform-EULA.png
        :align: center

        Screenshot: PicoScenes software EULA

        After your pressing the <Ok>, a Yes or No prompt box appears as shown below, and you will choose whether to accept the EULA terms. Choosing <No> will terminate the installation immediately. Choosing <Yes> will continue the installation.

    .. figure:: /images/Configuring-picoscenes-platform.png
        :figwidth: 1000px
        :target: /images/Configuring-picoscenes-platform.png
        :align: center

        Screenshot: Users decide whether to accept the EULA terms

    .. hint:: If you wrongfully press the <No>, the PicoScenes installer will show you the solution to reinitialize the installation.
        
- Reboot your system
    You may have to reboot your system to validate the installation; otherwise, the modified drivers for QCA9300 and IWL5300 will not be activated.

- The first run
    You run ``PicoScenes`` in a terminal (case sensitive), which is your first time opening PicoScenes. Soon after the first launch, PicoScenes will crash with an error message saying, "This is a scheduled exception ...".  Yes, **it is indeed a planned crash**. Run ``PicoScenes`` in the terminal again, and the error should be gone.

    As PicoScenes is designed to be a `service` program, it will not quit automatically. You can press Ctrl+C to exit.

.. _install_matlab:


Install PicoScenes MATLAB Toolbox
==========================================

PicoScenes MATLAB Toolbox (PMT) are used for parsing the .csi files generated by the PicoScenes main program.

Prerequisites
++++++++++++++++++++

Because the PicoScenes MATLAB Toolbox (PMT) and the PicoScenes main program use the same `RxS Parsing Core library <https://gitlab.com/wifisensing/rxs_parsing_core>`_ to parse the CSI data, PMT depends on the specific Operating System, MATLAB and C/C++ compiler. The following table shows the recommended (and also tested) working environments.

.. csv-table:: Recommended Working Environments for PicoScenes MATLAB Toolbox 
    :header: , "Linux", "macOS", "Windows"
    :widths: 10, 30, 30 ,30
    :stub-columns: 1

    OS Version, "Ubuntu 20.04 or its variants", "macOS Big Sur 11.2", "Windows 10"
    MATLAB Version, "MATLAB 2020b or above", "MATLAB 2020b or above", "MATLAB 2020b or above"
    Compiler, GCC 9.3+, Apple Clang 12+ (Xcode 12.4+), MinGW64


PicoScenes MATLAB Toolbox supports MATLAB
Windows 10, Ubuntu 20.04 and its variants (Linux Mint, Kubuntu, Xubuntu, etc.). So you can install PicoScenes MATLAB Toolbox on Windows 10 or Ubuntu 20.04. You must do some preparatory work before you install PicoScenes MATLAB Toolbox.

Preparation steps on Windows 10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Install MATLAB (version R2020b or above);
- Install Mingw-w64 (version 8.0 or above);
- Assuming the installation path of Mingw-w64 is ``D:\Develop\mingw``, `append` ``D:\Develop\mingw\bin`` to your OS Environment Variables ``Path``;
- Open MATLAB, run ``setenv('MW_MINGW64_LOC', 'D:\Develop\mingw')`` and ``mex -setup C++`` in MATLAB Command Window.

Preparation steps on Ubuntu 20.04
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Install MATLAB (version R2020b or above);
- Run ``sudo apt install build-essential`` to install GCC

Preparation steps on macOS Big Sur 11.2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Install MATLAB (version R2020b or above);
- Install Xcode 12.4 (or above) from macOS App Store 

Obtain PicoScenes MATLAB Toolbox
+++++++++++++++++++++++++++++++++++

- Click the :download:`PicoScenes MATLAB Toolbox <https://zpj.io/PicoScenes/matlab-toolbox/PicoScenes-MATLAB-Toolbox.tar.gz>` link to download the zipped PicoScenes MATLAB Toolbox.

Install PicoScenes MATLAB Toolbox, in MATLAB
++++++++++++++++++++++++++++++++++++++++++++++

Open MATLAB, change `Current Folder` to the unzipped ``PicoScenes-MATLAB-Toolbox`` directory and run the following command in Command Window:

    .. code-block:: matlab

        install_PicoScenes_MATLAB_Toolbox
        compileRXSParser

In a few seconds, seeing similar messages shown in the picture below means that you have successfully installed the PicoScenes MATLAB Toolbox.

    .. figure:: /images/install-PicoScenes-MATLAB-Toolbox.png
        :figwidth: 1000px
        :target: /images/install-PicoScenes-MATLAB-Toolbox.png
        :align: center

        Screenshot: Install PicoScenes MATLAB Toolbox in MATLAB


Verify the installation
++++++++++++++++++++++++++

In MATLAB `Current Folder` or Ubuntu file explorer, navigate to ``PicoScenes-MATLAB-Toolbox/samples`` directory, *drag'n'drop* the two sample .csi files into Command Window.  On requesting to parse .csi files for the first time, PicoScenes MATLAB Toolbox will compile the MATLAB MEX-based .csi file parser. If the compilation is successfully, two samples files samples_9300.csi and samples_x310.csi will be parsed into cell arrays named ``samples_9300`` and ``samples_x310``, respectively.

Performance Tuning (for Heavy SDR User)
=========================================

If your research depends heavily on SDR, the following performance tuning tricks can yield substantial performance improvements.

- Disable Hyper-threading
    The PicoScenes's Wi-Fi baseband implementation is *currently* a single-threaded processing flow; therefore, its performance highly depends on the single-core CPU performance. Disabling hyper-threading can provide a roughly 10% increase in total throughout. There is usually an option in BIOS to disable it.

- Disable Spectre/Meltdown vulnerability protection
    **If you are in an absolutely safe environment**, disabling this vulnerability protection can improve the performance of the speculative execution and the overall throughput.

    To disable the protection, you open /etc/default/grub file with root privilege and replace the default GRUB_CMDLINE_LINUX_DEFAULT='...' line with the following line.
    
    .. code-block:: bash

        GRUB_CMDLINE_LINUX_DEFAULT="pti=off spectre_v2=off l1tf=off nospec_store_bypass_disable no_stf_barrier"


Troubleshooting
=================

The following shows some of the most frequent errors and their solutions for quick reference. For other issues that happened during the installation, upgrade or later use, you may seek :ref:`tech_support` by submitting a bug report to PicoScenes Issues Tracker.


**Q1**: I encounter an error during apt installation saying, "E: fail to fetch XXX, File has unexpected size (xxx != xxx). ..."

A: The possible reason is that the PicoScenes repository is updated, but your local apt cache is not synced. To fix this error, you should run ``sudo apt update`` again to sync your local apt cache. If you still encounter this problem, you may seek :ref:`tech_support`.


**Q2**: I encounter an error during USRP B200 series installation, "Could not find the image 'usrp_b200_fw.hex' in the image directory /usr/share/uhd/images ...."

A: run ``sudo /usr/lib/uhd/utils/uhd_images_downloader.py`` to download **all** USRP images.