Developing Your PicoScenes Plugins
=====================================

Architecture of PicoScenes
-----------------------------

.. figure:: /images/picoscenes_architecture.jpg
    :figwidth: 1000px
    :target: /images/picoscenes_architecture.jpg
    :align: center

    Architecture of PicoScenes software


The above figure, excerpted from :ref:`picoscenes_paper`,   shows the architecture of PicoScenes software. The following text, also excerpted from the paper, briefly introduces the architecture of PicoScenes.

    PicoScenes consists of 3 layers from bottom to top, as shown on the left of the figure, namely, the PicoScenes drivers, the PicoScenes platform and the PicoScenes plugin subsystem.

    **PicoScenes Drivers** We created our own versions of kernel drivers for both the QCA9300 and the IWL5300. These drivers extract the CSI and expose various hardware controls directly to the user space.
    We have improved upon the original drivers in three main respects...
                        
    **PicoScenes Platform** is essentially the middleware for Wi-Fi sensing. In addition to basic CSI data collection, it integrates packet-injection-based Tx control. It also abstracts the details of all types of frontend devices and exposes unified, powerful and user-friendly APIs to the measurement-specific plugin layer....

    **PicoScenes Plugin Subsystem** performs application- and measurement-specific tasks.
    The plugins invoke the hardware-independent APIs exposed by the platform to implement various Wi-Fi sensing or communication tasks in a task-centric manner...

PicoScenes plugin development: Get Started 
----------------------------------------------

Before you creating your own PicoScenes plugins from scratch, you have `seven` steps to gradually develop your understanding of the PicoScenes architecture and the coding skill set. During this processing, you will learn how to git clone PS-PDK code, compile it, modify it, debug it and imitate it. You also will have a general understanding of the `modern C++` development on the Linux platform.

Install PicoScenes software package
+++++++++++++++++++++++++++++++++++++++

PS-PDK, as a standard C++ library including `C/C++ headers` and `libraries`, is already in your system if you have successfully installed PicoScenes software. The C++ headers and the binary libraries of PS-PDK are installed at ``/usr/local/PicoScenes/include/PicoScenes`` and ``/usr/local/PicoScenes/lib``, respectively. You should refer to the :doc:`/installation` document to ensure your installation.


Git clone PicoScenes PDK project
++++++++++++++++++++++++++++++++++



Install necessary development dependencies and tools
++++++++++++++++++++++++++++++++++++++++++++++++++++++
    Install dependencies;
    
Read in-source documents and understand 
++++++++++++++++++++++++++++++++++++++++

Do some modification to the existing plugins
+++++++++++++++++++++++++++++++++++++++++++++

Debug your modification
+++++++++++++++++++++++++

Imitate and develope your own PicoScenes plugins
+++++++++++++++++++++++++++++++++++++++++++++++++

Introducing PS-PDK via sample plugins
--------------------------------------

Demo Plugin
++++++++++++++++


Forwarder Plugin
++++++++++++++++++++

EchoProbe Plugin
+++++++++++++++++++