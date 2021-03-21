Useful Resources
==================

.. _picoscenes_paper:

The academic paper on PicoScenes
------------------------------------

Zhiping Jiang, Tom H. Luan, Xincheng Ren, Dongtao Lv, Han Hao, Jing Wang, Kun Zhao, Wei Xi, Yueshen Xu, Rui Li, Eliminating the Barriers: Demystifying Wi-Fi Baseband Design and Introducing the PicoScenes Wi-Fi Sensing Platform, `preprint on arxiv <https://arxiv.org/abs/2010.10233>`_.

This paper introduces PicoScenes and also report very extensive performance evaluations of PicoScenes. Some of the results are just remarkable.

.. important:: If PicoScenes software (including the main and utility programs, bash scripts, PicoScenes MATLAB Toolbox and any PicoScenes plugins regardless of the ownership) are used by any form in your academic research, **you should cite the above work**. This citation requirement is also included in the PicoScenes Software EULA.

Project repositories
----------------------------

- PicoScenes projects group: https://gitlab.com/wifisensing. The following are some of the open source projects.
    - `RXS Parsing Core <https://gitlab.com/wifisensing/rxs_parsing_core>`_: the core CSI data parsing routine and the related utility code. This project is shared between the PicoScenes main program and PicoScenes MATLAB Toolbox via git submodule.
    - `PicoScenes Plugin Development Kit (PS-PDK) <https://gitlab.com/wifisensing/PicoScenes-PDK>`_: the source repositories of three PicoScenes plugins, namely the Demo Plugin, UDP Forwarder and EchoProbe. We name it PS-PDK, because most PicoScenes plugins are developed based on this repo. 
    - `PicoScenes Manual <https://gitlab.com/wifisensing/PicoScenes-Manual>`_: the reStructuredText source of this documentation.


Alternatives to PicoScenes
--------------------------------

PicoScenes project is inspired and partially based on the existing CSI data extraction tools. The following is a short list of the existing academic friendly CSI tools:

    - `Intel 5300 CSI Tool <http://dhalperi.github.io/linux-80211n-csitool/>`_, based on IWL5300 NIC, release in 2011.
    - `Atheros CSI Tool <https://wands.sg/research/wifi/AtherosCSI/>`_, based on QCA9300 NIC, released in 2015.
    - `Nexmon CSI Tool <https://github.com/seemoo-lab/nexmon_csi>`_, based on Broadcom 43xx series (BCM43xx) NIC, release in 2019.
    - `ESP32 CSI Tool <https://stevenmhernandez.github.io/ESP32-CSI-Tool/>`_, based on ESP32 IoT module, release in 2020.


Technical support
-----------------------------
We provide technical support via PicoScenes `project issues tracker project <https://gitlab.com/wifisensing/picoscenes-issue-tracker/issues>`_. You may raise the software bugs, encountered problems and suggestions via the  issue tracker.

You can also 