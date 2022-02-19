Development Status
========================

PicoScenes is still under active development. We are adding new features, new controls, and fix bugs. Checkout the changelogs for the latest progress.

`PicoScenes Platform Changelog <https://zpj.io/PicoScenes/platform-changelog>`_

`PicoScenes Plugin Development Kit (PDK) Changelog <https://zpj.io/PicoScenes/pdk-changelog>`_

`PicoScenes MATLAB Toolbox (PMT) Changelog <https://gitlab.com/wifisensing/PicoScenes-MATLAB-Toolbox-Core/-/blob/main/changelog.md>`_


Future Plans
----------------

.. |check| raw:: html

    <input checked=""  type="checkbox">

.. |check_| raw:: html

    <input checked=""  disabled="" type="checkbox">

.. |uncheck| raw:: html

    <input type="checkbox">

.. |uncheck_| raw:: html

    <input disabled="" type="checkbox">

- 802.11a/g/n/ac/ax packet injection on AX200/AX210 |check|
- More low-level controls for AX200/AX2100

  - Tx/Rx chainmask |check|
  - Regulation domain overriding |check|
  - Improve interoperability with SDR |check|
  - Filter support |check|
  
    - Format |check|
    - Source MAC address |check|
    - Firmware bug workaround |check|
  
- AX210 support

  - **Enable Wi-Fi sensing in the 6 GHz band!** |check|
  - Fix bug in CSI measurement |check|
  
- SDR baseband

  - 802.11ax SU-EXT format |check|
  - 802.11ax MU/Trigger-Based support
  - 802.11be support the SDR baseband implementation
  - Beamforming support |check|
  - Directional beamforming support |check|
  - Improve Rx baseband performance at least by 3x

- Next-Gen CSI live plot
- License Service

  - Online validation |check|
  - User Portal

- Usability \& Documentation 

  - Add AX200-based tutorial
  - Add video tutorial
