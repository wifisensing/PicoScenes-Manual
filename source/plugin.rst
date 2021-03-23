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


Install necessary development dependencies
++++++++++++++++++++++++++++++++++++++++++++++++++++++

Run the following command to install the dependencies.
 
.. code-block:: bash

    sudo apt install -y git build-essential libboost-all-dev libssl-dev libcpprest-dev libsodium-dev libfmt-dev libuhd-dev libopenblas-dev libfftw3-dev pkg-config

Clone, build and install PicoScenes PDK project 
+++++++++++++++++++++++++++++++++++++++++++++++++++

Run the following command to clone the PicoScenes-PDK repository
 
.. code-block:: bash

    git clone https://gitlab.com/wifisensing/PicoScenes-PDK --recursive

If PicoScenes and all the development dependencies are successfully installed, you can run the following command to first time build and install the three plugins of PicoScenes-PDK project.

.. code-block:: bash

    cd PicoScenes-PDK # or cd to the cloned directory
    ./Fast_Build_Intall_PicoScenes.sh

`Fast_Build_Intall_PicoScenes.sh` is a bash script with the following content, which rebuild the plugins and the .deb package and install the .deb package.

.. code-block:: bash

    #!/bin/bash

    scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"

    sudo apt purge picoscenes-plugins-demo-echoprobe-forwarder -y

    cd $scriptDir && rm -rf $scriptDir/build && mkdir $scriptDir/build && cd $scriptDir/build
    cmake .. && make package -j`nproc`

    cd $scriptDir/build && sudo dpkg -i ./picoscenes*.deb

If everything goes fine, the above command rebuilds and reinstalls the latest PS-PDK repository.

Read the code of the sample plugins
+++++++++++++++++++++++++++++++++++++

Do some modification to the existing plugins
+++++++++++++++++++++++++++++++++++++++++++++

Debug your modification
++++++++++++++++++++++++++++++++++++++++

You can use IDE(such as CLion) to debug PicoScenes-Plugins.


    .. figure:: /images/Plugin-Debug.gif
        :figwidth: 1000px
        :target: /images/Plugin-Debug.gif
        :align: center

        Debug PicoScenes-Plugins

.. warning:: When you add paramters in debug configurations, you must add ``--plugin-dir /path-to-plugin``, otherwise you can't debug.


Or you can click this link to detailed view.
:download:`Debug-Plugin <images/Plugin-Debug.gif>`

Imitate and develope your own PicoScenes plugins
+++++++++++++++++++++++++++++++++++++++++++++++++

