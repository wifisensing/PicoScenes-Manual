Why Use PicoScenes
===================================

.. hint:: This paper is under active editing.


The first public-available 802.11ax-format CSI measurement platform 
---------------------------------------------------------------------

To the best of our knowledge, 
PicoScenes is currently (Sep. 2021) the **only** Wi-Fi sensing platform software that supports the 802.11ax-format CSI measurement. 
Based on the Intel Wireless-AX200 Wi-Fi NIC, PicoScenes can measurement CSI for all Wi-Fi traffics with any formats (802.11a/g/n/ac/ax), any bandwidths (20/40/80/160 MHz) and even any target destinations (all overheard frames in monitor mode).


Concurrent CSI measurement from multiple Wi-Fi NICs or SDR devices
--------------------------------------------------------------------

To the best of our knowledge, 
PicoScenes is currently (Sep. 2021) the **only** Wi-Fi sensing platform software that supports concurrent CSI measurement from multiple Wi-Fi NICs by one single computer.

This feature significantly reduces the complexity of setting up and managing a multi-NIC CSI measurement.
Taking our dual-NIC ThinkPad X201 as an example, researchers can perform the round-trip or concurrent CSI measurement by just one laptop. 
We have even set up a 27-NIC array which is just impossible with the previous one-PC per NIC architecture.

To achieve this goal, we rewrote the CSI extraction logic of the AX200, QCA9300 and IWL5300 kernel drivers. Moreover, multi-threading is one of the the fundamental designs of the PicoScenes platform. In fact, PicoScenes platform assign at least five threads for each frontend (Wi-Fi COTS NICs or SDR) and its plugins.

Accessing the unlocked hardware features of the QCA9300 and IWL5300
---------------------------------------------------------------------



Adopting SDR (USRP) in your Wi-Fi sensing research
--------------------------------------------------

Obtaining complete RX PHY-layer information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fully control PHY-layer transmission
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Modern Wi-Fi protocols (802.11ac/ax w/ multi-user) support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Use Virtual SDR Parse Signals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. figure:: /images/virtualsdr.gif
    :figwidth: 1000px
    :target: /images/virtualsdr.gif
    :align: center


In-situ CSI parsing & processing
-----------------------------------


Prototype your own advanced CSI measurement protocol
------------------------------------------------------


Super easy installation on latest OS w/ auto-update 
-------------------------------------------------------


Support multiple CSI-available devices
------------------------------------------

PicoScenes platform currently supports the AX200, QCA9300 and IWL5300 Wi-Fi NIC models.


Technical support--- least technical, most critical
-----------------------------------------------------

