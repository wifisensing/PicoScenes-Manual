Hardware Installation
=======================

PicoScenes currently supports two commercial Wi-Fi NIC models, the QCA9300 and IWL5300, and two USRP models, the N210 and X310 models. These devices have been extensively tested during the development. For other USRP models, such as B200/E300/N300 series, PicoScenes *should* be able to support them. However, the incompatibility caused by hardware differences is possible.

Installation for (Multiple) QCA9300 or IWL5300 NICs
+++++++++++++++++++++++++++++++++++++++++++++++++++++

One of the most welcomed features of the PicoScenes is the multi-NIC concurrent operation, i.e., PicoScenes supports concurrent CSI measurement from multiple NICs, which are all connected to one single PC. Based on our practice, we recommend three multi-NIC installation methods.

Mini PCI-E to PCI-E 1x adapter-based multi-NIC installation
    This is the most convenient approach for multi-NIC installation. With the help of the Mini PCI-E to PCI-E 1x adapter, you can install the QCA9300 and IWL5300 directly on the motherboard. 

    The maximum number of available slots is usually less than 3, because the motherboard offers at most 5 slots and some of them are occupied by graphic card, 10GbE ethernet, etc.

    To overcome this issue, you may need to use some motherboards primarily designed for cryptocurrency mining, such as ASUS B250 Mining Expert. These motherboards have dozens of PCI-E 1x slots, and you may use *PCI-E slot risers* to connect multiple NICs.

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
        ThinkPad official BIOS doesn't support changing (or adding another) Wi-Fi NIC. You may have to flash the modified BIOS which removes the restriction before changing (or installing) the Wi-Fi NIC. You may visit https://zpj.io/replace-install-nics-for-thinkpad-x201/ for assistance.

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
    Since PicoScenes's support for USRP devices are **completely** built upon UHD software (USRP hardware driver), you should first setup your hardware/software according to the official `USRP Hardware Driver and USRP Manual <https://files.ettus.com/manual/index.html>`_. For multi-N210 or X310 connection, you should read these three documents carefully:

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

Software Installation
=========================

Some Prerequisites
++++++++++++++++++++

Install PicoScenes
++++++++++++++++++++