PicoScenes Installation
========================


Hardware Installation
---------------------

PicoScenes currently supports two commercial Wi-Fi NIC models, the QCA9300 and IWL5300, and two USRP models, the N210 and X310 models. These devices have been extensively tested during the development. For other USRP models, such as B200/E300/N300 series, PicoScenes *should* be able to support them. However, the incompatibility caused by hardware differences is possible.

Installation for (multiple) QCA9300 or IWL5300 NICs
+++++++++++++++++++++++++++++++++++++++++++++++++++++

One of the most welcomed features of the PicoScenes is the multi-NIC concurrent operation, i.e., PicoScenes supports concurrent CSI measurement from multiple NICs, which are all connected to one single PC. Based on our practice, we recommend three multi-NIC installation methods.

Multi-Mini PCI-E slots based multi-NIC installation
    This is the most convenient approach for multi-NIC installation. Multiple onboard Mini PCI-E slots spares the need for Mini PCI-E to PCI-E 1x adaptors, and also present a highly compact factor. 
    There are many Intel NUC models equipped with two Mini PCI-E slots. However they are not laptops after all, it is troublesome to always connect a power cable.
    
    Pursuing a wire-free multi-NIC solution, we recommend ThinkPad X201. Despite a more than10 years old laptop model, its motherboard provided two full/half-height Mini PCI-E slots, and we can install the QCA9300 or IWL5300 NICs in both of them. Even better, you can install three SMA-based external antennas! The attached MODEM/audio daughter board can be safely removed leaving three size compatible holes for installing SMA external antennas. The three holes are *mic-in*, *speaker-out* and *MODEM*. The following photo shows our modified ThinkPad X201 equipped with both the QCA9300 and IWl5300 and three external antennas.

    .. tip::
        If you know some other newer laptops equipped with two Mini PCI-E laptops, please `Contact Us <mailto:zpj@xidian.edu.cn>`_ and I will update the above text.

On-board direct insert based multi-NIC installation


PCI-E bridge adapter based multi-NIC installation



Installation for USRP N210 and X310
+++++++++++++++++++++++++++++++++++++


.. PicoScenes Installation
.. --------------------------

.. Some Prerequisites
.. +++++++++++++++++++++++

.. Install PicoScenes
.. +++++++++++++++++++++++
/[.,p