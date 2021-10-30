============================
PicoScenes Installation
============================


Hardware Installation
=======================

PicoScenes currently supports three commercial Wi-Fi NIC models and USRP-based SDR devices, namely the AX200, QCA9300 and IWL5300, and all USRP models.

The most welcomed feature of PicoScenes is the concurrent operation of multiple RF frontends, i.e., simultaneous CSI measurement or packet injection using a commercial Wi-Fi NIC/SDR array. To help you get the hardware ready, we share some hardware preparation experience, mainly focusing on the multi-devices setup.

Installation of (Multiple) Commercial Wi-Fi NICs
+++++++++++++++++++++++++++++++++++++++++++++++++++++

We recommend four multi-NIC installation methods.

1. **PCI-E 1x adapter based multi-NIC installation**

With the help of the `Mini PCI-E to PCI-E 1x adapter` or `M.2 to PCI-E 1x adapter`, you can install multiple AX200, QCA9300 or IWL5300 NICs directly on the motherboard of a desktop PC. 

However, there are usually only 2 or 3 PCI-E slots left for the Wi-Fi NICs. To overcome this issue, you may choose the *cryptocurrency mining motherboards*, such as MSI B360-F Pro. This type of motherboard have dozens of PCI-E 1x slots, and you can use *PCI-E slot riser* to install *dozens* of Wi-Fi NICs on one single motherboard.

2. **Multi-Mini PCI-E/M.2 slots based multi-NIC installation**
    
This is the most convenient approach for installing multiple NICs. The onboard Mini PCI-E or M.2 slots spare the need for PCI-E 1x adaptors.
    
With some hardware and software tricks, we modify a old laptop model ThinkPad X201, and install two Mini PCI-E/M.2 based Wi-Fi NICs. Even more, **X201 enables you to install three SMA-based external antennas!** The following photo shows our modified ThinkPad X201 equipped with both the QCA9300 and IWl5300 and three external antennas. The laptop can also install AX200 using a M.2-to-Mini PCI-E converter.

.. figure:: /images/X201-External-Antennas.jpg
    :figwidth: 750px
    :target: /images/X201-External-Antennas.jpg
    :align: center

    Modified ThinkPad X201 laptop equipped with two Wi-Fi NICs (QCA9300 and IWL5300) and three external SMA antennas

3. **PCI-E bridge adapter-based multi-NIC installation**

The PCI-E bridge adapter can split one PCI-E connection into multiple, just like a PCI-E hub. Therefore, you may install connect multiple NICs to only one of the motherboard PCI-E slots via the bridge adapter.

And even more so, you may build a multi-layer hierarchy of the bridge adapters and install AX200, QCA9300 or IWL5300 to all its leaf nodes. In this way, you may install over 100 Wi-Fi NICs to your system in theory. To validate the feasibility of this approach, we built a 27-NIC Wi-Fi sensing array using a 3-layer hierarchy of the 1 to 3 PCI-E bridge adapters. The figure below shows the picture and layout of the 27-NIC array. The entire array is encapsulated in an IKEA box.    

.. figure:: /images/NICArrayLayout-horizontal.jpg
    :figwidth: 750px
    :target: /images/NICArrayLayout-horizontal.jpg
    :align: center

    27-NIC Wi-Fi sensing array built upon 1-to-3 bridge adapters

.. hint::
    Do you want to access the research-ready hardware out of the box? 
    
    Do you want to skip the unfamiliar hardware selection, installation and tricky setup? 
    
    Go get it from our Taobao shop `PicoScenes软硬件与服务 <https://shop235693252.taobao.com/>`_! Our shop sells the modified ThinkPad X201.


Installation of (Multiple) USRP Devices
++++++++++++++++++++++++++++++++++++++++++++++++

Follow the official USRP manual
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PicoScenes’s support for USRP devices is established upon UHD software, the USRP hardware driver. Therefore, you should first set up your hardware/software according to the official   `USRP Hardware Driver and USRP Manual <https://files.ettus.com/manual/index.html>`_. For B2x0, N2x0 and X3x0 models, you should read the following three documents carefully:

- `USRP Hardware Driver and USRP Manual: B200/B210/B200mini/B205mini <https://kb.ettus.com/B200/B210/B200mini/B205mini>`_
- `USRP Hardware Driver and USRP Manual: USRP2 and N2x0 Series <https://files.ettus.com/manual/page_usrp2.html>`_
- `USRP Hardware Driver and USRP Manual: USRP X3x0 Series <https://files.ettus.com/manual/page_usrp_x3x0.html>`_
- `Multiple USRP configuration <https://files.ettus.com/manual/page_multiple.html>`_


Our Suggestions on USRP Hardware Setup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Suggestions based on our previous experience:
    - For X3x0 series, PicoScenes supports the PCI-E cable-based connection, **but we don't recommend that**. Besides the notably expensive cables, it has two main drawbacks. First, the PCI-E-based connection is inefficient in that each link can only connect one X3x0 device; therefore multi-X3x0 connection requires you to install multiple PCI-E extension boards, which is very expensive and is even impossible for a regular desktop PC with few spare PCI-E slots. Second, the UHD software doesn't support the hybrid combination of the PCI-E-based link and the GbE/10GbE-based link. This restriction further devalues the PCI-E-based link.
    - For both the N2x0 and X3x0 series, **we recommend Intel X710 Quad Port 10 Gb Ethernet Adapter**, a reasonable and cost-effective solution for multiple N2x0 and X3x0 connections. It occupies only one full-size PCI-E slot but provides four 10GbE ports, allowing you to drive up to 4 X3x0s or eight independent full-duplex channels.
    - As clearly stated in `Multiple USRP configuration <https://files.ettus.com/manual/page_multiple.html>`_, **UHD only supports combining multiple USRP devices of the same model, and currently only N2x0 and X3x0 series are combination-ready**.
    - For both the N2x0 and X3x0 series, please consider using the UBX-40/UBX-160 daughterboard in priority. UBX-40 and UBX-160, though expensive, are the only full-duplex daughterboards that support daughterboard-level phase synchronization. And only with this level of synchronization, can you realize the phased-array functionality.
    - Please pay special attention to the allocation of IP addresses. For network-based connections, the NIC port and the connected USRP must be in the same subnet. However, if they are not in the same subnet, the UHD device discovery program *udh_find_devices* can still find the devices, but PicoScenes cannot initialize the device correctly.
    - For the N2x0 series, MIMO cable is an easy way to achieve MIMO and phased array, except for its narrow bandwidth.
    - For clock distribution, OctoClock-G is a cost-effective choice that distributes the GPS-disciplined clocks to up to eight USRP devices.

Verify the installation of the USRP N2x0/X3x0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There is a four-stage verification process to ensure that your USRP is ready for PicoScenes.

Confirm the hardware connection
*********************************

Open a terminal and run the following command

.. code-block:: bash

        uhd_find_devices

`uhd_find_devices` is the device discovery program provided by UHD. It will list all the connected USRP devices. If a device is not shown in the list, you should refer to the USRP manual to check the hardware connection.


Confirm the firmware version
*********************************

.. code-block:: bash

        uhd_usrp_probe

`uhd_usrp_probe` prints the hardware details of all connected devices. It also checks whether the devices' firmwares are consistent with the UHD software installed on the host computer. If the inconsistency is detected, you may use `uhd_image_loader` command to flash the latest firmwares to the USRP:

For the USRP N2x0 device, run:

.. code-block:: bash

    uhd_image_loader --args=type=usrp2

For the USRP X3x0 device, run:

.. code-block:: bash

    uhd_image_loader --args=type=x300


Confirm the signal reception (Rx)
*********************************

Use UHD's `uhd_fft` command to check whether your USRP can receive the signal:

.. code-block:: bash

    uhd_fft --args="ADDRESS_STRING" -f 2200e6 -s 10e6

where `ADDRESS_STRING` is the USRP identification string. You may refer `USPR Common Device Identifiers <https://files.ettus.com/manual/page_identification.html#id_identifying_common>`_ for more details.

Perform Tx/Rx calibration (Optional)
***********************************************************

Finally, execute the following three commands in sequence to calibrate the Tx/Rx signal. This step is optional.

.. code-block:: bash

    uhd_cal_rx_iq_balance
    uhd_cal_tx_dc_offset
    uhd_cal_tx_iq_balance

PicoScenes Software Installation
==================================

Prerequisites
++++++++++++++++++++

- CPU should at least support the SSE4.2 instruction set, and AVX2 is recommended.
- Your computer has at least 4 GB memory. Less than 4 GB memory may cause out-of-memory crash.
- Operating System: PicoScenes **only** supports Ubuntu 20.04LTS and its variants (Linux Mint, Kubuntu, Xubuntu, etc.). Personally, I strongly recommend the Linux Mint distribution.
- OS must be **installed atop real hardware**. No virtualization is supported.
- Internet connection: internet connection is required during the installation process and is also required for regular build expiration checking in daily use.
- Permission for installing the latest kernel version: PicoScenes depends on and is always built against the latest kernel versions. During the first-time installation and subsequent upgrades, your system **will be forced to update to the latest kernel version**.
- The latest version of MATLAB on Linux/macOS/Windows: PicoScenes MATLAB Toolbox, the CSI measurement data decoding routine in MATLAB, **only** supports the R2020b or above versions of MATLAB on Linux/macOS/Windows platforms.

Install PicoScenes via *apt* command 
+++++++++++++++++++++++++++++++++++++++++++++++++++

Only if your system meets *all* above requirements, can you start the installation now.

#. Download and install PicoScenes Source Updater
    - Click :download:`PicoScenes Source Updater <https://zpj.io/PicoScenes/pool/main/picoscenes-source-updater.deb>` and choose *Open with "GDebi Package Installer"*
    
    - Click *Install Package*

    .. note:: PicoScenes Source Updater doesn't install the PicoScenes software but registers the PicoScenes software repository to your system, so that PicoScenes can be installed and auto-upgraded via the *apt* command.

#. Update the cache of apt repositories
    Open a terminal and run the following command:
    
    .. code-block:: bash

        sudo apt update

    When this command finishes, you can verify the result. Run ``apt list picoscenes-<Press TAB Key>`` in the terminal. You shall see at least the following packages:

    .. code-block:: bash

        picoscenes-all   picoscenes-platform   picoscenes-source-updater  picoscenes-driver-modules-XXXX

    Seeing these `picoscenes-xxx` packages means PicoScenes repository is successfully registered to your system.

#. Install PicoScenes software
    Run the following command:
        
    .. code-block:: bash

        sudo apt install picoscenes-all

    After a few minutes of package downloading (the duration depends on your network), the PicoScenes EULA message, similar to the following screenshot, will appear in the terminal. You should read the EULA and decide if you agree to the listed terms. You can press up/down arrow keys to view the full content and press TAB to move the cursor to the <Ok>. You finish the reading of EULA by pressing the <Ok>.

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

    .. hint:: If you wrongfully press the <No>, the installer will show you the solution to reinitialize the installation.
        
- Reboot your system
    You may have to reboot your system to validate the installation; otherwise, the modified drivers for AX200, QCA9300 and IWL5300 will not be activated.

- The first run
    Run ``PicoScenes`` in a terminal (case sensitive). Soon after the launch, PicoScenes will crash with an error message saying, "This is a scheduled exception ...".  Yes, **it IS a planned crash**. Run ``PicoScenes`` again, and the error should be gone.

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
    Compiler, GCC 9.3+, Apple Clang 12+ (Xcode 12.4+), TDM-GCC 64 (10.3+)

The following are the preparation steps for each supported OS.

Preparation steps on Ubuntu 20.04
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Install MATLAB (version R2020b or above);
- Run ``sudo apt install build-essential`` to install GCC

Preparation steps on macOS Big Sur 11.2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Install MATLAB (version R2020b or above);
- Install Xcode 12.4 (or above) from macOS App Store 

Preparation steps on Windows 10
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Install MATLAB (version R2020b or above);
- Install `TDM-GCC-64 <https://jmeubank.github.io/tdm-gcc/>`_ (choose MinGW-w64 based version, version 10.3+);
- By default, the installer will add <TDM-GCC-64 PATH> your system Environment Variables. Here we assume the installation path is ``C:\TDM-GCC-64``.
- Open MATLAB, run ``setenv('MW_MINGW64_LOC', 'C:\TDM-GCC-64')`` and then ``mex -setup C++`` in MATLAB Command Window.
- Click the option ``MinGW64 Compiler (C++)``

The following is a screenshot of setting up TDM-GCC-64 v10.3 in MATLAB R2020b.

    .. figure:: /images/tdm-gcc-matlab.jpg
        :figwidth: 800px
        :target: /images/tdm-gcc-matlab.jpg
        :align: center

        Screenshot: Setup TDM-GCC in MATLAB

Obtain PicoScenes MATLAB Toolbox
+++++++++++++++++++++++++++++++++++

- Click the :download:`PicoScenes MATLAB Toolbox <https://zpj.io/PicoScenes/matlab-toolbox/PicoScenes-MATLAB-Toolbox.tar.gz>` link to download the zipped PicoScenes MATLAB Toolbox.

Install PicoScenes MATLAB Toolbox in MATLAB
++++++++++++++++++++++++++++++++++++++++++++++

Open MATLAB, change `Current Folder` to the unzipped ``PicoScenes-MATLAB-Toolbox`` directory and run the following command in Command Window:

    .. code-block:: matlab

        install_PicoScenes_MATLAB_Toolbox
        compileRXSParser

In a few seconds, seeing similar messages shown in the picture below means that you have successfully installed the PicoScenes MATLAB Toolbox.

    .. figure:: /images/install-PicoScenes-MATLAB-Toolbox.png
        :figwidth: 800px
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

Uninstallation of The PicoScenes Ecosystem
============================================

Uninstalling the PicoScenes binaries
++++++++++++++++++++++++++++++++++++++

- Run ``sudo apt remove picoscenes-driver-modules-<PRESS TAB KEY>`` to remove the modified NIC drivers. Due to the package dependency hierarchy, the depending picoscenes-platform and picoscenes-plugins-xxx packages will also be removed.
- Run ``sudo apt remove picoscenes-<PRESS TAB KEY>`` to remove other PicoScenes related packages
- Reboot your computer

Uninstalling the PicoScenes MATLAB Toolbox
++++++++++++++++++++++++++++++++++++++++++++

- Run ``install_PicoScenes_MATLAB_Toolbox('uninstall')`` in MATLAB
- Manually remove the PMT folder