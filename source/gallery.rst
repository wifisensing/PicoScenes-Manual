Gallery
===================

CSI measurement under variable and beyond-standard bandwidths
---------------------------------------------------------------------------

For QCA9300 NIC frontend, PicoScenes enables arbitrary tuning for BW from `5 to 80 MHz` with minimal 2.5 MHz step.
For SDR frontend, PicoScenes provides `up to 200` MHz bandwidth on USRP SDR.

PicoScenes provides a unified command-line interface (``--sf`` argument) to control the bandwidth for both the commercial Wi-Fi NIC and SDR frontends.

Moreover, PicoScenes decouples the physical `bandwidth` or `baseband sampling rate` (BW) with the Channel Bandwidth (CBW), so that you can freely choose to transmit the signals 

.. figure:: /images/wideband_csi.jpg
   :figwidth: 1000px
   :target: /images/wideband_csi.jpg
   :align: center

   PicoScenes provides out-of-box CSI measurement for the beyond-standard bandwidths.
