PicoScenes Gallery
===================


CSI measurement over continuous and beyond-standard spectrum by QCA9300
---------------------------------------------------------------------------

For QCA9300 NIC frontend, PicoScenes enables the arbitrary tuning for carrier frequency over 2.4 and 5 GHz bands, more specifically, 2.2 to 2.9 GHz in 2.4 GHz band and 4.4 to 6.1 GHz in 5 GHz band. 
PicoScenes provides a unified command-line interface (``--freq`` argument) to control the carrier frequency for both the commercial Wi-Fi NIC and SDR frontends.
For more details, you may refer to :ref:`picoscenes_paper`.

.. figure:: /images/scan_cf_figure/cf_scan.jpg
   :figwidth: 1000px
   :target: /images/scan_cf_figure/cf_scan.jpg
   :align: center

   PicoScenes can provide continuous and overlapped CSI measurement over the beyond-standard spectrum.

.. hint:: Why do the CSI measurements misaligned with each other? you wanna stitch them together? You may refer to :ref:`picoscenes_paper`.

.. todo:: add spectrum scanning script


CSI measurement under variable and beyond-standard bandwidths
---------------------------------------------------------------------------

For QCA9300 NIC frontend, PicoScenes enables the arbitrary tuning for bandwidth from `5 to 80 MHz` with minimal 2.5 MHz step.
For SDR frontend, PicoScenes provides `up to 200` MHz bandwidth on USRP SDR. 
PicoScenes provides a unified command-line interface (``--rate`` argument) to control the bandwidth for both the commercial Wi-Fi NIC and SDR frontends.
For more details, you may refer to :ref:`picoscenes_paper`.

.. figure:: /images/wideband_csi.jpg
   :figwidth: 1000px
   :target: /images/wideband_csi.jpg
   :align: center

   PicoScenes provides out-of-box CSI measurement for the beyond-standard bandwidths.



Concurrent multi-NIC CSI measurement
---------------------------------------------------------------------------
