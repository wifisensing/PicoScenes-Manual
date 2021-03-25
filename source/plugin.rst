Developing Your PicoScenes Plugins
=====================================

Before creating your own PicoScenes plugins from scratch, you have seven steps to gradually develop your understanding of the PicoScenes architecture and the coding skillset. During this processing, you will learn how to git clone PS-PDK code, compile it, modify it, debug it and imitate it. You also will have a general understanding of the `modern C++` development on the Linux platform.

Install PicoScenes software package
----------------------------------------------

PicoScenes Plugin Development Kit (PS-PDK), as a standard C++ library, includes the PicoScenes `C/C++ headers` and `libraries`. If you have installed PicoScenes software, PS-PDK is already in your system. The headers and the binary library files are installed at ``/usr/local/PicoScenes/include/PicoScenes`` and ``/usr/local/PicoScenes/lib``, respectively. You may refer to the document :doc:`/installation` to ensure your installation.

Install necessary development dependencies
----------------------------------------------

Run the following command to install the dependencies for PS-PDK development.
 
.. code-block:: bash

    sudo apt install -y git cmake build-essential libboost-all-dev libssl-dev libcpprest-dev libsodium-dev libfmt-dev libuhd-dev libopenblas-dev libfftw3-dev pkg-config

Clone, build and install PicoScenes PDK project 
-------------------------------------------------

Run the following command to `git clone` the PicoScenes-PDK project
 
.. code-block:: bash

    git clone https://gitlab.com/wifisensing/PicoScenes-PDK --recursive

If PicoScenes and all the development dependencies are successfully installed, you can run the following command to build and install the three plugins of PicoScenes-PDK project.

.. code-block:: bash

    cd PicoScenes-PDK # or cd to the cloned directory
    ./Fast_Build_Intall_PicoScenes.sh

`Fast_Build_Intall_PicoScenes.sh` is a bash script with the following content, which rebuilds the plugins and the .deb package and install the .deb package.

.. code-block:: bash

    #!/bin/bash

    scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}" )" && pwd )"

    sudo apt purge picoscenes-plugins-demo-echoprobe-forwarder -y

    cd $scriptDir && rm -rf $scriptDir/build && mkdir $scriptDir/build && cd $scriptDir/build
    cmake .. && make package -j`nproc`

    cd $scriptDir/build && sudo dpkg -i ./picoscenes*.deb

If everything goes fine, the above command rebuilds and reinstalls the latest PS-PDK repository.


Imitate and develope your own PicoScenes plugins
--------------------------------------------------

“`Imitation is not just the sincerest form of flattery - it's the sincerest form of learning.`” -- `George Bernard Shaw`

The entire PS-PDK projects is managed by `CMake`, and contains three working plugins, a Demo plugin, the EchoProbe and UDP-forwarder. We have added clear and sufficient comments to the existing code helping you understand the plugin structure, invocation sequence and many operation details.

We recommand JetBrains CLion as the IDE for PicoScenes plugin development. You can modify and debug the existing plugins and finally create your own.

Debug PicoScenes plugins
----------------------------------------------

Since the plugin .so file cannot run by itself, a tricky problem of plugin development emerges, `how to debug a plugin?` 

Xincheng Ren, one of our contributors, records a .gif video describing the plugin debug process. In this video, we use JetBrains CLion as our IDE. To debug the EchoProbe plugin, rather than specifying the .so plugin file as the `debug main program`, you must specify the PicoScenes main program at ``/usr/local/PicoScenes/bin/`` to be the `debug main program`. Second, you should also add ``--plugin-dir /path-to-plugin`` program option to tell PicoScenes main program to load your plugins.

    .. figure:: /images/Plugin-Debug.gif
        :figwidth: 1000px
        :target: /images/Plugin-Debug.gif
        :align: center

        Debug PicoScenes plugins by debug PicoScenes main program

You can download this .gif video from :download:`Debug Plugin <images/Plugin-Debug.gif>`.

