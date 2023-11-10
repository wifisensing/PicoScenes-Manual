====================================
PicoScenes Installation & Upgrade
====================================


Hardware Installation
=======================

PicoScenes currently supports 4 commercial Wi-Fi NIC models and SDR devices, including the AX200 (or AX201), AX210(or AX211), QCA9300 and IWL5300, all models of USRP devices, and the HackRF One.

The most welcomed feature of PicoScenes is the concurrent operation of multiple RF frontends, i.e., simultaneous CSI measurement or packet injection using a commercial Wi-Fi NIC/SDR array. To help you get the hardware ready, we share some hardware preparation experience, mainly focusing on the multi-devices setup.

Installation of (Multiple) Commercial Wi-Fi NICs
+++++++++++++++++++++++++++++++++++++++++++++++++++++

We recommend three methods for installing multiple NICs.

1. **PCI-E 1x Adapter-based Multi-NIC Installation**

With the help of the `Mini PCI-E to PCI-E 1x adapter` or `M.2 to PCI-E 1x adapter`, you can install multiple NICs directly on the motherboard of a desktop PC.

However, there are usually only 2 or 3 spare PCI-E slots left for the Wi-Fi NICs. To overcome this issue, you may choose **cryptocurrency mining motherboards**, such as the MSI B360-F Pro. These types of motherboards have dozens of PCI-E 1x slots, and you can use **PCI-E slot risers** to install *dozens* of Wi-Fi NICs on a single motherboard.

2. **Multi-Mini PCI-E/M.2 Slots-Based Multi-NIC Installation**

This is the most convenient approach for installing multiple NICs. The onboard Mini PCI-E or M.2 slots eliminate the need for PCI-E 1x adapters.
    
With some hardware and software tricks, we modified an old laptop model, the ThinkPad X201, and installed two Mini PCI-E/M.2-based Wi-Fi NICs. Moreover, **the X201 enables you to install three SMA-based external antennas!** The following photo shows our modified ThinkPad X201 equipped with both the QCA9300 and IWL5300 NICs and three external antennas. The laptop can also install an AX210/AX200 using an M.2-to-Mini PCI-E converter.

.. figure:: /images/X201-External-Antennas.jpg
    :figwidth: 750px
    :target: /images/X201-External-Antennas.jpg
    :align: center

    Modified ThinkPad X201 laptop equipped with two Wi-Fi NICs (QCA9300 and IWL5300) and three external SMA antennas

3. **PCI-E Bridge Adapter-Based Multi-NIC Installation**

The PCI-E bridge adapter can split one PCI-E connection into multiple connections, similar to a PCI-E hub. Therefore, you can connect multiple NICs to only one of the motherboard's PCI-E slots via the bridge adapter.

Moreover, you can build a multi-layer hierarchy of bridge adapters and install NICs to all the leaf nodes. In this way, you can theoretically install over 100 Wi-Fi NICs in your system. To validate the feasibility of this approach, we built a 27-NIC Wi-Fi sensing array using a 3-layer hierarchy of 1-to-3 PCI-E bridge adapters. The figure below shows the picture and layout of the 27-NIC array. The entire array is encapsulated in an IKEA box.    

.. figure:: /images/NICArrayLayout-horizontal.jpg
    :figwidth: 750px
    :target: /images/NICArrayLayout-horizontal.jpg
    :align: center

    27-NIC Wi-Fi sensing array built using 1-to-3 bridge adapters

.. hint::
    Do you want to access research-ready hardware out of the box? Do you want to skip the unfamiliar hardware selection, installation, and tricky setup? 
    
    Get them from our Taobao shop `PicoScenes软硬件与服务 <https://shop235693252.taobao.com/>`_! Our shop sells the modified ThinkPad X201 and all supported Wi-Fi NICs.

Installation of (Multiple) USRP Devices
++++++++++++++++++++++++++++++++++++++++++++++++

The installation, usage, and optimization of USRP are much more complex than that of a COTS NIC. Therefore, please follow the steps below to configure and verify the USRP hardware.

Installing PicoScenes Software 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before setting up the USRP hardware, you should install the PicoScenes software first. Please follow the instructions in the :ref:`install_software` section to install PicoScenes. Please note that PicoScenes depends on specific version of UHD. If you have previously installed your own compiled version of UHD, please uninstall it before proceeding.

.. hint::
    The driver installation or build process listed on the USRP Official site can be complicated and prone to errors. To simplify this process, we have built and packaged the PicoScenes software using the USRP driver shipped with the Ubuntu system. Therefore, by installing PicoScenes software, you will also be installing the USRP driver.

Configuring USRP Hardware
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You should set up your hardware according to the USRP official `Devices & Usage Manual <https://files.ettus.com/manual/page_devices.html>`_. Read and follow the Get Started sections according to your USRP models.

- `USRP Hardware Driver and USRP Manual: B200/B210/B200mini/B205mini <https://kb.ettus.com/B200/B210/B200mini/B205mini>`_
- `USRP Hardware Driver and USRP Manual: USRP2 and N2x0 Series <https://files.ettus.com/manual/page_usrp2.html>`_
- `USRP Hardware Driver and USRP Manual: USRP X3x0 Series <https://files.ettus.com/manual/page_usrp_x3x0.html>`_
- `USRP Hardware Driver and USRP Manual: USRP N3x0 Series <https://files.ettus.com/manual/page_usrp_n3xx.html>`_
- `USRP Hardware Driver and USRP Manual: USRP X4x0 Series <https://files.ettus.com/manual/page_usrp_x4xx.html>`_
- `Multiple USRP configuration <https://files.ettus.com/manual/page_multiple.html>`_

.. hint:: The PicoScenes software installer installs the UHD software. So, you skip the UHD installation or source code building steps.


Suggestions for USRP Hardware Setup
**************************************

Based on our experience, we have the following suggestions for setting up USRP hardware:

    - X3x0 Series: It is **not recommended to use a PCI-E cable-based connection** due to inefficiency in both hardware and cost. This method has two major drawbacks. Firstly, the PCI-E-based connection is hardware-inefficient as it requires one cable or extension card for each X3x0 device. This can be very expensive and may not be feasible for a desktop PC with limited spare PCI-E slots. Secondly, the UHD software does not support a hybrid combination of the PCI-E-based link and the GbE/10GbE-based link, further limiting its application.
    - N2x0 and X3x0 Series: We highly **recommend using the Intel X710 Quad Port 10 Gb Ethernet Adapter**. This is a reasonable and cost-effective solution for connecting multiple N2x0 and X3x0 devices. It occupies only one full-size PCI-E slot but provides four 10GbE ports, allowing you to connect up to four X3x0s or eight independent full-duplex channels.
    - N2x0 Series: Consider using MIMO cables to achieve MIMO and phased array capabilities. However, note that MIMO cables have a narrow bandwidth.
    - Multiple USRP Devices: As clearly stated in `Multiple USRP configuration <https://files.ettus.com/manual/page_multiple.html>`_, UHD only supports combining multiple USRP devices of the same model. Currently, the N2x0 and X3x0 series are the only combination-ready models.
    - Daughterboard Selection: For both the N2x0 and X3x0 series, it is advisable to consider using the UBX-40/UBX-160 daughterboard. Although these daughterboards are expensive, they are the only ones that support daughterboard-level phase synchronization, which is necessary for PicoScenes to achieve phased-array functionality.
    - IP Address Allocation: Pay special attention to the allocation of IP addresses. For network-based connections, the Ethernet NIC port and the connected USRP must be in the same subnet. If they are not in the same subnet, the UHD device discovery program 'uhd_find_devices' may still find the devices, but PicoScenes will not be able to initialize them correctly.
    - Clock Synchronization: For clock synchronization, the OctoClock-G from EttusResearch is a cost-effective choice. It can distribute GPS-disciplined clocks to up to eight USRP devices.

Verifying Hardware Installation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To ensure that your USRP is ready for PicoScenes, follow the four-stage verification process outlined below.

Verifying Hardware Connection
*********************************

Open a terminal and execute the following command:

.. code-block:: bash

        uhd_find_devices

The `uhd_find_devices` command is provided by UHD as a device discovery program. It will list all the connected USRP devices. If your device is not displayed, please refer to the USRP manual for troubleshooting steps to check the hardware connection.


Verifying Firmware Version
*********************************

Open a terminal and execute the following command:

.. code-block:: bash

        uhd_usrp_probe

The `uhd_usrp_probe` command prints the hardware details of all connected devices and checks whether the devices' firmware versions are consistent with the UHD software installed on the host computer. If any inconsistencies are detected, you can use the `uhd_image_loader` command to flash the latest firmware to the USRP.

To update the firmware for USRP N2x0 devices, run the following command:


.. code-block:: bash

    uhd_image_loader --args=type=usrp2

For USRP X3x0 devices, use the following command to update the firmware:

.. code-block:: bash

    uhd_image_loader --args=type=x300


Verifying Signal Reception (RX)
************************************

To check if your USRP can receive the signal, you can use UHD's `uhd_fft` command. Execute the following command:

.. code-block:: bash

    uhd_fft --args="ADDRESS_STRING" -f 2412e6 -s 20e6

Replace `ADDRESS_STRING` with the USRP identification string. For more details, refer to the `USPR Common Device Identifiers <https://files.ettus.com/manual/page_identification.html#id_identifying_common>`_.

Tx/Rx Self-Calibration (for USRP N2x0, X3x0, and N3x0 users)
**********************************************************************

Uncalibrated daughterboards can introduce `serious` signal distortion. It is recommended to perform calibrations for EACH daughterboard following the instructions in the `Device Calibration <https://files.ettus.com/manual/page_calibration.html>`_ section. Calibrating the frequency range that covers your intended measurements will help achieve the best signal quality.

Installation of (Multiple) HackRF One
++++++++++++++++++++++++++++++++++++++++++++++++

The installation and verification process for HackRF One is relatively simpler compared to USRP. Please follow the steps below to complete the installation and verification.

Installing The PicoScenes Software 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Before setting up the HackRF One hardware, you should install the PicoScenes software first. you should follow :ref:`install_software` section to install the PicoScenes software.

Verifying Hardware Connection
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The HackRF One is a USB 2.0 interfaced SDR device, so you can simply plug in the device. To check the connection, run the following command:

.. code-block:: bash

    SoapySDRUtil --find="driver=hackrf"

If the connection is successful, you will see the device information displayed.

.. _install_software:

PicoScenes Software Installation
==================================

Before installing the PicoScenes software, please make sure you meet the following prerequisites:

Prerequisites
++++++++++++++++++++

- You **agree to be bound by** :doc:`/eula`.
- Your CPU must support the SSE4.2 instruction set, and AVX2 is recommended.
- You should have at least 4 GB of memory to prevent out-of-memory crashes.
- Secure Boot must be disabled. You can find the switch in the BIOS settings.
- The operating system must be **Ubuntu 20.04 LTS or its variants** (Linux Mint, Kubuntu, Xubuntu, etc.).
- The operating system must be installed on real hardware. Virtualization is not supported.
- An internet connection is required during the installation process and for regular build expiration checking.
- You need permission to install the latest kernel version. PicoScenes depends on the latest kernel versions. During the installation and subsequent upgrades, your system will be forced to update to the latest kernel version.
- (Optional) The latest version of MATLAB on Linux/macOS/Windows: PicoScenes MATLAB Toolbox (PMT) supports the R2020b or above versions of MATLAB on Linux/macOS/Windows platforms.

Install PicoScenes via *apt* command 
+++++++++++++++++++++++++++++++++++++++++++++++++++

Please ensure that your system meets all the requirements mentioned earlier before proceeding with the installation.

#. Download and install the PicoScenes Source Updater:
    - Click :download:`PicoScenes Source Updater <https://zpj.io/PicoScenes/pool/main/picoscenes-source-updater.deb>` and choose *Open with "GDebi Package Installer"*
    
    - Click *Install Package*

    .. note:: The PicoScenes Source Updater registers the PicoScenes software repository to your system, enabling you to install and automatically upgrade PicoScenes using the apt command.

#. Update the cache of apt repositories:
    Run the following command:
    
    .. code-block:: bash

        sudo apt update

    After this command completes, you can verify the result by running ``apt list picoscenes-<Press TAB Key>`` in the terminal. You should see at least the following packages listed:

    .. code-block:: bash

        picoscenes-all   picoscenes-platform   picoscenes-source-updater  picoscenes-driver-modules-XXXX

    The presence of these `picoscenes-xxx` packages indicates that the PicoScenes repository has been successfully registered on your system.

#. Install the PicoScenes software
    Run the following command:
        
    .. code-block:: bash

        sudo apt install picoscenes-all

    After a few minutes of package downloading, the PicoScenes End User License Agreement (EULA) message will appear in the terminal. Read the EULA and decide if you agree to the listed terms. You can use the up/down arrow keys to view the full content and press TAB to move the cursor to the "<Ok>" option. Press "<Ok>" to confirm that you have read and agree to the EULA.

    .. figure:: /images/PicoScenes-platform-EULA.png
        :figwidth: 1000px
        :target: /images/PicoScenes-platform-EULA.png
        :align: center

        Screenshot: PicoScenes software EULA

        After confirming the EULA, you will be prompted with a Yes or No question regarding accepting the EULA terms. Choose "<No>" to terminate the installation immediately or "<Yes>" to continue with the installation.

    .. figure:: /images/Configuring-picoscenes-platform.png
        :figwidth: 1000px
        :target: /images/Configuring-picoscenes-platform.png
        :align: center

        Screenshot: Users decide whether to accept the EULA terms

    .. hint:: If you accidentally choose "<No>", the installer will provide instructions on how to restart the installation process.
        
- Reboot your system
    Reboot your system to validate the installation.

- The first run
    Run ``PicoScenes`` in a terminal (case sensitive!). Soon after the launch, PicoScenes will crash with an error message saying, "This is a scheduled exception ...".  Yes, **it IS a planned crash**. Run ``PicoScenes`` again, and the error should be gone.

    As PicoScenes is designed to be a `service` program, it will not quit automatically. You can press Ctrl+C to exit.

.. _install_matlab:

Install PicoScenes MATLAB Toolbox Core
==========================================

PicoScenes MATLAB Toolbox Core (PMT-Core) is used for parsing the .csi files generated by the PicoScenes main program.

Prerequisites
++++++++++++++++++++

Because the PicoScenes MATLAB Toolbox Core (PMT-Core) and the PicoScenes main program use the same `RxS Parsing Core library <https://gitlab.com/wifisensing/rxs_parsing_core>`_ to parse the CSI data, PMT-Core depends on the specific combinations of OS, MATLAB and C/C++ compiler. The following table shows the proved working environments.

.. csv-table:: Proved Working Environments for PicoScenes MATLAB Toolbox Core
    :header: , "Linux", "macOS", "Windows"
    :widths: 10, 30, 30 ,30
    :stub-columns: 1

    OS Version, "Ubuntu 20.04 or its variants", "macOS 15.0+", "Windows 10 or 11"
    MATLAB Version, "MATLAB 2020b or above", "MATLAB 2020b or above", "MATLAB 2020b or above"
    Compiler, GCC 9.3+, Apple Clang 12+ (Xcode 12.4+), TDM-GCC 64 (10.3+)

The following are the preparation steps for each supported OS.

Preparation steps on Ubuntu 20.04
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Install MATLAB (version R2020b or above);
- Run ``sudo apt install build-essential`` to install GCC
- (Optional but recommended) Run ``sudo apt install matlab-support`` to install matlab-support package. It provides a shortcut to MATLAB (run *matlab* directly in bash) and also a workaround for a library not found issue.

    The installation of matlab-support requires 3 or 4 steps of user interaction:

        1. In the first screen, read the examples carefully and fill your MATLAB directory;
        2. The MATLAB activation window *may* popup, activate your MATLAB;
        3. "Authorized user for MATLAB", leave the field blank;
        4. "Rename MATLAB's GCC libraries?" --> choose YES.

Preparation steps on macOS Big Sur 11.2
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- Install MATLAB (version R2020b or above);
- Install Xcode 12.4 (or above) from macOS App Store 

Preparation steps on Windows 10 or 11
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Obtain PicoScenes MATLAB Toolbox Core (PMT-Core)
++++++++++++++++++++++++++++++++++++++++++++++++++++

You can **ONLY** git clone the toolbox from its git repo `PicoScenes MATLAB Toolbox Core <https://gitlab.com/wifisensing/PicoScenes-MATLAB-Toolbox-Core>`_ with **--recursive** option. Never download directly.

.. hint::
    Q: Why cannot download directly? 

    A: PMT-Core embeds the `RXS-Parsing-Core <https://gitlab.com/wifisensing/rxs_parsing_core>`_ repo as a git submodule. The direct download excludes the submodule, so incomplete PMT-Core.

    Q: Why --recursive?

    A: git clone doesn't clone \& checkout its submodule by default.

Install PicoScenes MATLAB Toolbox Core in MATLAB
+++++++++++++++++++++++++++++++++++++++++++++++++++

Open MATLAB, change `Current Folder` to the ``PicoScenes-MATLAB-Toolbox-Core`` directory and run the following command in Command Window:

    .. code-block:: matlab

        install_PicoScenes_MATLAB_Toolbox
        compileRXSParser

In a few seconds, seeing similar messages shown in the picture below means that you have successfully installed the PicoScenes MATLAB Toolbox Core.

    .. figure:: /images/install-PicoScenes-MATLAB-Toolbox.png
        :figwidth: 800px
        :target: /images/install-PicoScenes-MATLAB-Toolbox.png
        :align: center

        Screenshot: Install PicoScenes MATLAB Toolbox in MATLAB


Verify the installation
++++++++++++++++++++++++++

In MATLAB `Current Folder` or Ubuntu file explorer, navigate to ``PicoScenes-MATLAB-Toolbox-Core/samples`` directory, *drag'n'drop* the sample .csi files (samples_9300.csi and samples_x310.csi) into Command Window one by one. Soon, they will be parsed into cell arrays named ``samples_9300`` and ``samples_x310``, respectively.


Install PicoScenes Python Toolbox
==========================================

PicoScenes Python Toolbox (PPT) is used for parsing the .csi files in Python. Its installation and usage is documented in the project `repo <https://gitlab.com/wifisensing/PicoScenes-Python-Toolbox>`_.


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

.. _upgrade_software:

Upgrade PicoScenes Software
=====================================

Since PicoScenes is *still* under *very active* development, adding new features, adding new hardware support and fixing bugs, we recommand you upgrade PicoScenes software regularly.

Check and Upgrade the PicoScenes Binaries
++++++++++++++++++++++++++++++++++++++++++++

Checking for upgrade
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Checking-for-upgrade is a built-in feature of PicoScenes, and it is trigger in every launch *if the internet connection is available*. To manually check for upgrade, just perform the following steps: 

    - Connect to internet, making sure that no special steps, such as the web-based logging, are required to open a website from browser. 
    - Simply Run PicoScenes in the CLI without any program options, and wait a while.
    - If there is a upgrade available, PicoScenes will show a upgrade-hint message like shown below. We suggest you to check the change log to what see which part of PicoScenes is affected.

        .. figure:: /images/PicoScenes_check_upgrade.png
            :figwidth: 800px
            :target: /images/PicoScenes_check_upgrade.jpg
            :align: center

            Screenshot: PicoScenes hints for the upgrade



Upgrade the PicoScenes binaries
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The upgrade of PicoScenes is via the Debian package system, and is simplified to just few clicks. 

    - For Ubuntu GUI users, open ``Software Updater`` or similar APP. After refreshing the package repository, you will see *picoscenes-xxx* packages. Select these packages and click *Install Now*.

        .. figure:: /images/Updater.png
            :figwidth: 500px
            :target: /images/Updater.png
            :align: center

            Screenshot: Upgrade PicoScenes software via Software Updater

    - For Ubuntu CLI users, just run the following command to update the package repository and upgrade *all* available packages.

        .. code-block:: bash

            sudo apt update && sudo apt upgrade


Check and Upgrade the PicoScenes MATLAB Toolbox (PMT)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++

PMT is released via git, therefore the upgrade of PMT is to run *git pull & git submodule update* within the PMT directory.


Uninstallation of The PicoScenes Ecosystem
============================================

Uninstalling the PicoScenes binaries
++++++++++++++++++++++++++++++++++++++

- Run ``sudo apt remove picoscenes-driver-modules-<PRESS TAB KEY>`` to remove the modified NIC drivers. Due to the package dependency hierarchy, the depending picoscenes-platform and picoscenes-plugins-xxx packages will also be removed.
- Run ``sudo apt remove picoscenes-<PRESS TAB KEY>`` to remove other PicoScenes related packages
- Reboot your computer

Uninstalling the PicoScenes MATLAB Toolbox
++++++++++++++++++++++++++++++++++++++++++++

- Run ``uninstall_PicoScenes_MATLAB_Toolbox`` in MATLAB
- Remove the PMT folder