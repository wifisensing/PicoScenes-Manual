================
Installation
================


Hardware Installation
=======================

PicoScenes currently supports two commercial Wi-Fi NIC models, the QCA9300 and IWL5300, and two USRP models, the N210 and X310 models. These devices have been extensively tested during the development. For other USRP models, such as B200/E300/N300 series, PicoScenes *should* be able to support them. However, the incompatibility caused by hardware differences is possible.

One of the most welcomed features of the PicoScenes is the multi-NIC concurrent operation, i.e., simultaneous CSI measurement or packet injection by multiple NICs. To help you quickly setup your hardware, we share some experience on the hardware installation, especially focusing on the multi-devices setup.

Installation for (Multiple) QCA9300 or IWL5300 NICs
+++++++++++++++++++++++++++++++++++++++++++++++++++++

We recommend three multi-NIC installation methods. Which method to choose depends on your consideration.

Mini PCI-E to PCI-E 1x adapter-based multi-NIC installation
    This is the most convenient approach for multi-NIC installation. With the help of the Mini PCI-E to PCI-E 1x adapter, you can install the QCA9300 and IWL5300 directly on the motherboard. 

    The maximum number of available slots is usually less than 3, because the motherboard offers at most 5 slots and some of them are occupied by graphic card, 10GbE ethernet, etc.

    To overcome this issue, you may need to use some motherboards primarily designed for cryptocurrency mining, such as MSI B360-F Pro. These motherboards have dozens of PCI-E 1x slots, and you may use *PCI-E slot risers* to connect multiple NICs.

Multi-Mini PCI-E slots-based multi-NIC installation
    This is the most convenient approach for multi-NIC installation. Multiple onboard Mini PCI-E slots spares the need for Mini PCI-E to PCI-E 1x adaptors, and also present a highly compact factor. 
    There are many Intel NUC models equipped with two Mini PCI-E slots. However they are not laptops after all, it is troublesome to always connect a power cable.
    
    Pursuing a wire-free multi-NIC solution, we recommend ThinkPad X201. Despite a more than10 years old laptop model, its motherboard provided two full/half-height Mini PCI-E slots, and we can install the QCA9300 or IWL5300 NICs in both of them. 
    
    Even better, **X201 enables you to install three SMA-based external antennas!** The FPC-connected daughter board of X201, which accounts for Modem, audio In/Out and a USB port, can be safely removed, leaving three size compatible holes for installing SMA external antennas. The following photo shows our modified ThinkPad X201 equipped with both the QCA9300 and IWl5300 and three external antennas.

    .. figure:: /images/X201-External-Antennas.jpg
        :figwidth: 1000px
        :target: /images/X201-External-Antennas.jpg
        :align: center

        Modified ThinkPad X201 laptop equipped with 3 external SMA antennas

    .. warning::
        ThinkPad official BIOS doesn't support changing (or adding another) Wi-Fi NIC. You may have to flash the modified BIOS which removes the restriction before changing (or installing) the Wi-Fi NIC. You may visit https://zpj.io/replace-install-nics-for-thinkpad-x201/ for assistance (A Chinese document, machine translation may be required).

PCI-E bridge adapter-based multi-NIC installation
    The PCI-E bridge adapter can split one single PCI-E connection into multiple, just like a USB hub. Therefore, you may install connect multiple NICs to only one of the PCI-E slots of the motherboard via the bridge adapter.

    And even more so, you may build a multi-layer cascaded hierarchy of the bridge adapters and install the QCA9300 or IWL5300 to all its leaf nodes. In this way, you can theoretically install up to 100 Wi-Fi NICs to your system. To validate this approach's feasibility, we set up a 27-NIC Wi-Fi sensing array based on a 3-layer hierarchy of multiple 1 to 3 PCI-E bridge adapters. Its picture and layout are shown below. The entire 27-NIC array is encapsulated in an IKEA box.
    

    .. figure:: /images/NICArrayLayout-horizontal.jpg
        :figwidth: 1000px
        :target: /images/NICArrayLayout-horizontal.jpg
        :align: center

        27-NIC Wi-Fi sensing array built upon 1-to-3 bridge adapters


Installation for (Multiple) USRP N210 and X310
++++++++++++++++++++++++++++++++++++++++++++++++

Follow the official manual:
    Since PicoScenes's support for USRP devices are **completely** built upon UHD software (USRP hardware driver), you should first setup your hardware/software according to the official `USRP Hardware Driver and USRP Manual <https://files.ettus.com/manual/index.html>`_. For multi-N210 or X310 connection, you should read the following three documents carefully:

    - `Multiple USRP configuration <https://files.ettus.com/manual/page_multiple.html>`_
    - `USRP Hardware Driver and USRP Manual: USRP2 and N2x0 Series <https://files.ettus.com/manual/page_usrp2.html>`_
    - `USRP Hardware Driver and USRP Manual: USRP X3x0 Series <https://files.ettus.com/manual/page_usrp_x3x0.html>`_

Some advices base on our experience:
    - For X310, **don't use PCI-E cable based connection**. Besides the extremely extensive cable itself, it has two main drawbacks. First, the PCI-E based connection is extremely ineffective in both the cost and throughput. Each cable can connect *only one* X310, therefore to connect multiple X310s, you have to install multiple PCI-E 4x boards on the motherboard.  Second, the PCI-E based connection cannot be combined with network-based connection. This is a restriction of the UHD software, but it does forbid some multi-USRP application scenarios.
    - For both N210/X310, we **recommend Intel X710 Quad Port 10 Gb Ethernet Adapter**. This is a reasonable and cost-effective solution for multiple N210 and X310 connections. It only occupies one PCI-E slots with 8x speed and provides 4 10GbE connection which allows you to drive up to 4 X310s or 8 independent full-duplex channels.
    - For both N210/X310, consider UBX-40/UBX-160 over other daughterboards. UBX-40/UBX-160 , though expensive, are the only full-duplex daughterboards that support daughterboard-level phase synchronization. And only with this level of synchronization you can realize the phased-array functionality.
    - Pay attention to the IP address allocation. For the network-based connection, the NIC port and the connected USRP *must be in the same subnet*. However, if they are not in the same subnet, the UHD device discovery program *udh_find_devices* can still find the devices but PicoScenes cannot correctly initialize the devices.
    - For N210, MIMO cable is an easy way to achieve MIMO and phased array, except for its narrow bandwidth.
    - For Clock distribution, OctoClock-G is a cost-effective choice which distributes the GPS-disciplined clocks to up to 8 devices.

PicoScenes Installation
=========================

Prerequisites
++++++++++++++++++++

- Operating System: PicoScenes **only** supports Ubuntu 20.04 or its variants (Linux Mint, Kubuntu, Xubuntu, etc)
- Internet connection: internet connection is required throughout the installation process, and **is also required periodically for license checking** during the later use.
- Latest kernel version: PicoScenes depends on and is also built against the latest kernel version, your system have to be updated to the *latest* kernel version. Fortunately, *you don't have to update your system manually*, because PicoScenes installer will trigger the kernel update routine automatically.
- Latest MATLAB on Linux/macOS: PicoScenes MATLAB Toolbox, which decodes the CSI measurement data in MATLAB, **only** supports the latest MATLAB on Linux/macOS platforms (R2020b or R2021a).
    
    .. note::
        The porting of PicoScenes MATLAB Toolbox to Windows platform is on the way.

Install PicoScenes
++++++++++++++++++++

If your system satisfies the above requirements, you can now start the installation.

- Download and install PicoScenes Source Updater
    - Download PicoScenes Source Updater by clicking :download:`PicoScenes <https://zpj.io/PicoScenes/pool/main/picoscenes-source-updater.deb>`
    
    - Start the installer by double-clicking and then click `Install Package`

- Update your system apt repository cache and install PicoScenes
    Open a terminal and run the following command
    
    .. code-block:: bash

        sudo apt update

- Install PicoScenes packages
    In the same terminal (or open a new one) and run the following command
        
    .. code-block:: bash

        sudo apt install picoscenes-all

    After a minute of package downloading (the duration depends on your network), a EULA message, similar to the following screenshot, will appear in the terminal. You should read the EULA, and decide if you agree to the EULA terms. You can press up/down arrow keys to view the full content and press TAB to move the cursor to the <Ok>. You finish the reading by pressing Enter or Space on <Ok> button.

    .. figure:: /images/PicoScenes-platform-EULA.png
        :figwidth: 1000px
        :target: /images/PicoScenes-platform-EULA.png
        :align: center

        Screenshot: PicoScenes software EULA

    After your pressing <Ok>, a Yes or No prompt box appears, and you will choose whether to accept the EULA terms. Choosing <No> will terminate the installation immediately. Choosing <Yes> will continue the installation.

    .. figure:: /images/Configuring-picoscenes-platform.png
        :figwidth: 1000px
        :target: /images/Configuring-picoscenes-platform.png
        :align: center

        Screenshot: User decides whether to accept the EULA terms

    .. hint:: If you wrongfully press <No>, PicoScenes installer will show you the solution to reinitialize the installation.
        
- Reboot your system
    You will have to reboot your system to validate the installation, otherwise the modified drivers for QCA9300 and IWL5300 will not be activated.

- The first run
    The installation of PicoScenes is almost finished except one last step. 
    You should run ``PicoScenes`` in a terminal (case sensitive), which is your first time opening PicoScenes.
    During the first launch, PicoScenes will pop an error saying that "This is a scheduled exception ...". 
    Yes, it is indeed a scheduled exception.

    Run ``PicoScenes`` in the terminal again, and the error should be gone.
    Until now, PicoScenes is successfully installed on your system.


PicoScenes MATLAB Toolbox Installation
========================================

Download PicoScenes MATLAB Toolbox
+++++++++++++++++++++++++++++++++++

Once PicoScenes is successfully installed, a bash script is provided to download the latest PicoScenes MATLAB Toolbox. Open a terminal and run the following command:
        
    .. code-block:: bash

        download_matlab_toolbox

The script will download the PicoScenes MATLAB Toolbox archive file ``PicoScenes-MATLAB-Toolbox.tar.gz`` to your *present working directory (pwd)*. You may unzip it to you ``${HOME}`` by GUI file explorer or by command ``tar -zxf PicoScenes-MATLAB-Toolbox.tar.gz ~``.

Install PicoScenes MATLAB Toolbox (in MATLAB)
++++++++++++++++++++++++++++++++++++++++++++++

Open MATLAB, change `Current Folder` to the unzipped ``PicoScenes-MATLAB-Toolbox`` directory and run the following command in MATLAB Command Window:

    .. code-block:: matlab

        install_PicoScenes_MATLAB_Toolbox

In a few seconds, seeing similar messages shown in the picture below means that you have successfully installed the PicoScenes MATLAB Toolbox.

    .. figure:: /images/install-PicoScenes-MATLAB-Toolbox.png
        :figwidth: 1000px
        :target: /images/install-PicoScenes-MATLAB-Toolbox.png
        :align: center

        Screenshot: Install PicoScenes MATLAB Toolbox in MATLAB

Verifying the Installation
============================


Verify the hardware installation
+++++++++++++++++++++++++++++++++

- For QCA9300/IWL5300 NICs: use array_status
    Open a terminal and run the following command
    
    .. code-block:: bash

            array_status
    
    `array_status` is a bash script installed by PicoScenes. It lists all the installed Wi-Fi NICs (except Wi-Fi USB dongles). You should check whether all the installed Wi-Fi NICs are shown in the list. If a Wi-Fi NIC is not shown in the list, it will also not be discovered or controlled by PicoScenes.

- For USRP N210/X310 series:
    Open a terminal and run the following command
    
    .. code-block:: bash

            udh_find_devices
    
    `udh_find_devices` is the device discovery program provided by UHD. It will lists all the found devices. If a USRP is not shown in the list, it will also not be discovered or controlled by PicoScenes.

Verify the PicoScenes installation
++++++++++++++++++++++++++++++++++++

Open a terminal and run `PicoScenes` again. If everything goes fine, you will see some booting messages of PicoScenes, including how many COTS NICs are found, how many USRPs are found and how many plugin are found.

As PicoScenes is designed to be a `service` program, it will not quit automatically. You can press Ctrl+C to exit PicoScenes.


Verify the PicoScenes MATLAB Toolbox installation
++++++++++++++++++++++++++++++++++++++++++++++++++

In MATLAB `Current Folder` or system file explorer, navigate to ``PicoScenes-MATLAB-Toolbox/samples`` directory, **draw-n-drop** the two sample .csi files into Command Window.  If GCC is correctly installed, PicoScenes MATLAB Toolbox will compile the MATLAB MEX-based .csi file parser during the first time use. 
The compilation may take tens of seconds. If the compilation is successfully, two samples files samples_9300.csi and samples_x310.csi will be parsed into cell arrays named ``samples_9300`` and ``samples_x310``, respectively.


Performance Tuning (for Heavy SDR User)
=========================================

If your research depends heavily on SDR, the following two system-level performance tunings can yield substantial performance improvements.

- Disable Hyper-threading
    The PicoScenes's Wi-Fi baseband implementation is *currently* a single-threaded processing flow, thus its performance highly depends on the single-core CPU performance. Disabling hyper-threading can provide roughly 10% increase in total throughout. There is usually an option in BIOS to disable it.

- Disable Spectre/Meltdown vulnerability protection
    **If you are in absolute safe environment**, disabling this vulnerability protection can improve the performance of the speculative execution and the overall throughput.

    This can be done by replacing the default ``GRUB_CMDLINE_LINUX_DEFAULT='...'`` line with the following line in your ``/etc/default/grub`` file. Modifying this file requires root privilege.
    
    .. code-block:: bash

        GRUB_CMDLINE_LINUX_DEFAULT="pti=off spectre_v2=off l1tf=off nospec_store_bypass_disable no_stf_barrier"


.. Troubleshooting
.. =================

.. The following lists some commonly seen errors and solutions:

