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
        ThinkPad official BIOS doesn't support changing (or adding another) Wi-Fi NIC. You may have to flash the modified BIOS which removes the restriction before changing (or installing) the Wi-Fi NIC.

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


Software Installation
=========================

Some Prerequisites
++++++++++++++++++++

Install PicoScenes
++++++++++++++++++++