PicoScenes Gallery
===================


CSI measurements over a large and continuous spectrum by QCA9300
-------------------------------------------------------------------------------

PicoScenes unlocks the arbitrary tuning for carrier frequency for the QCA9300 NIC. More specifically, QCA9300 can operate at any carrier frequency between 2.2 to 2.9 GHz in the 2.4 GHz band and 4.4 to 6.1 GHz in the 5 GHz band. PicoScenes uses the ``--freq`` command option to specify the carrier frequency, e.g., ``--freq 4900e6``.
For more details, you may refer to :ref:`picoscenes_paper`.

.. figure:: /images/scan_cf_figure/cf_scan.jpg
   :figwidth: 1000px
   :target: /images/scan_cf_figure/cf_scan.jpg
   :align: center

   Continuous and overlapped CSI measurements over a large spectrum can be obtained via PicoScenes on QCA9300.

.. hint:: Why do the CSI measurements misalign with each other? Do you wanna stitch them together? You may refer to :ref:`picoscenes_paper`.

CSI measurements under tunable and wide baseband bandwidths
------------------------------------------------------------
For the QCA9300 NIC, PicoScenes unlocks the fine-grained tuning for baseband bandwidth from `5 to 80 MHz` with a minimum step of 2.5 MHz.
PicoScenes also provides `up to 200` MHz baseband bandwidth on the SDR devices. 
PicoScenes uses ``--rate`` command option to specify the baseband bandwidth for both the commercial Wi-Fi NIC and SDR frontends, e.g., `--rate 55e6`.
For more details, you may refer to :ref:`picoscenes_paper`.

.. figure:: /images/wideband_csi.jpg
   :figwidth: 1000px
   :target: /images/wideband_csi.jpg
   :align: center

   PicoScenes provides out-of-box CSI measurement for the tunable and wide bandwidths.



27-NIC Wi-Fi sensing array
---------------------------------------------------------------------------

To fully demonstrate the capacity of multi-NIC CSI measurement, we setup a 27-NIC Wi-Fi sensing array. The array contains 27 QCA9300 NICs and 10 1-to-3 PCI-E bridge adapters. For more details, you may refer to the evaluation part of :ref:`picoscenes_paper`.

.. figure:: /images/NICArrayLayout-horizontal.jpg
   :figwidth: 1000px
   :target: /images/NICArrayLayout-horizontal.jpg
   :align: center

   Picture of the 27-NIC Wi-Fi sensing array. The right figure shows its physical layout. The whole array is well-packaged in an IKEA box. 