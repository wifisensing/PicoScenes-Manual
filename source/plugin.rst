Developing Your PicoScenes Plugins
=====================================

Before creating your own PicoScenes plugins from scratch, you have seven steps to gradually develop your understanding of the PicoScenes architecture and the coding skillset. During this processing, you will learn how to git clone PS-PDK code, compile it, modify it, debug it and imitate it. You also will have a general understanding of the `modern C++` development on the Linux platform.

Prerequisites
----------------------------------------------

PicoScenes Plugin Development Kit (PS-PDK), as a standard C++ library, includes the PicoScenes `C/C++ headers` and `libraries`. If you have installed PicoScenes software, PS-PDK is already in your system. The headers and the binary library files are installed at ``/usr/local/PicoScenes/include/PicoScenes`` and ``/usr/local/PicoScenes/lib``, respectively. You may refer to the document :doc:`/installation` to ensure your installation.

Install necessary development dependencies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Run the following command to install the dependencies for PS-PDK development.
 
.. code-block:: bash

    sudo apt install -y git cmake build-essential libboost-all-dev libssl-dev libcpprest-dev libsodium-dev libfmt-dev libuhd-dev libopenblas-dev libfftw3-dev pkg-config

Clone, build and install PicoScenes PDK project 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

Optional Feature Prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

We recommand JetBrains **CLion** as the IDE for PicoScenes plugin development.



Developing PicoScenes Plugins
--------------------------------------------------

“`Imitation is not just the sincerest form of flattery - it's the sincerest form of learning.`” -- `George Bernard Shaw`

The entire PS-PDK project is managed by `CMake` and contains three working plugins, a Demo plugin, the EchoProbe and UDP-forwarder.

In the following content, we will start from scratch to teach you how to develop two plugin modules.

- The first module will teach you how to print custom strings in a plugin and print "Hello PicoScenes" in the terminal.
- The second module will instruct you on how to implement network card receive and send functions in a plugin.

Hello PicoScenes Plugin
~~~~~~~~~~~~~~~~~~~~~~~
In `PicoScenes-PDK/CMakeLists.txt`, Write the following content.

.. code-block:: cmake

    # ...
    # make plug-ins
    add_subdirectory(plugin-demo) # add this line
    add_subdirectory(plugin-echoprobe)
    add_subdirectory(plugin-forwarder)
    # ...

In `PicoScenes-PDK`, add a new folder named **plugin-demo** and create a **CMakeLists.txt** file under **plugin-demo** with the following content.

.. code-block:: cmake

    # PicoScenes-PDK/plugin-demo/CMakeLists.txt

    # The PicoScenes Plugins MUST be named in "PDK-xxx" pattern.
    ADD_LIBRARY(PDK-demo SHARED DemoPlugin.cxx)
    TARGET_LINK_LIBRARIES(PDK-demo  ${Boost_LIBRARIES} fmt::fmt SystemTools)
    install(TARGETS PDK-demo  DESTINATION .)

Create DemoPlugin.hxx and DemoPlugin.cxx files and write the following content.

DemoPlugin.hxx

.. code-block:: cpp

    // DemoPlugin.hxx

    #include <PicoScenes/AbstractPicoScenesPlugin.hxx>

    class DemoPlugin : public AbstractPicoScenesPlugin {
    public:
        std::string getPluginName() override;

        std::string getPluginDescription() override;

        std::string pluginStatus() override;

        std::vector<PicoScenesDeviceType> getSupportedDeviceTypes() override;

        void initialization() override;

        std::shared_ptr<boost::program_options::options_description> pluginOptionsDescription() override;

        void parseAndExecuteCommands(const std::string &commandString) override;

        static boost::shared_ptr<DemoPlugin> create() {
            return boost::make_shared<DemoPlugin>();
        }

    private:
        std::shared_ptr<po::options_description> options;
    };

    BOOST_DLL_ALIAS(DemoPlugin::create, initPicoScenesPlugin)

DemoPlugin.cxx

.. code-block:: cpp

    // DemoPlugin.cxx
    #include "DemoPlugin.hxx"

    std::string DemoPlugin::getPluginName() {
        return "PicoScenes Demo Plugin";
    }

    std::string DemoPlugin::getPluginDescription() {
        return "Demonstrate the PicoScenes Plugin functionality";
    }

    std::string DemoPlugin::pluginStatus() {
        return "this method returns the status of the plugin.";
    }

    std::vector<PicoScenesDeviceType> DemoPlugin::getSupportedDeviceTypes() {
        static auto supportedDevices = std::vector<PicoScenesDeviceType>{PicoScenesDeviceType::IWL5300, PicoScenesDeviceType::QCA9300, PicoScenesDeviceType::IWLMVM_AX200, PicoScenesDeviceType::IWLMVM_AX210, PicoScenesDeviceType::VirtualSDR, PicoScenesDeviceType::USRP, PicoScenesDeviceType::SoapySDR};
        return supportedDevices;
    }

    void DemoPlugin::initialization() {
        options = std::make_shared<po::options_description>("Demo Options", 120);
        options->add_options()
                ("demo", po::value<std::string>(), "--demo <param>");
    }

    std::shared_ptr<boost::program_optplugin.ions::options_description> DemoPlugin::pluginOptionsDescription() {
        return options;
    }


    void DemoPlugin::parseAndExecuteCommands(const std::string &commandString) {
        po::variables_map vm;
        auto parsedOptions = po::command_line_parser(po::split_unix(commandString)).options(*pluginOptionsDescription()).allow_unregistered().style(po::command_line_style::unix_style & ~po::command_line_style::allow_guessing).run();
        po::store(parsedOptions, vm);
        po::notify(vm);
        if (vm.count("demo")) {
            auto optionValue = vm["demo"].as<std::string>();
            LoggingService_Plugin_info_print("Plugin has been installed, its param is {}",std::string(optionValue));
        }

    }


compile and run plugin

After completing the plugin development, you can compile the plugin using the following command in the 'PicoScenes-PDK'

.. code-block:: bash

    ./Fast_Build_Install_Plugin.sh

Open a **terminal** , command --plugin-dir to search the plugin directory

.. code-block:: bash

    PicoScenes "-d debug
                --plugin-dir <your-plugin-dir>/PicoScenes-PDK;
                -i virtualsdr
                --demo HelloPicoScenes"

If successfully executed, you will see the following content in the console.

.. code-block:: bash

    [17:31:51.183948] [Plugin  ] [Info ] Plugin has been installed, its param is HelloPicoScenes

What happend on Plugin ?
~~~~~~~~~~~~~~~~~~~~~~~~

The command options, *“-d debug  --plugin-dir <your-plugin-dir>/PicoScenes-PDK; -i virtualsdr  --demo HelloPicoScenes”*, have the following interpretations:

- ``-d debug``: Modifies the display level of the logging service to debug
- ``--plugin``: Search plugin's directory  <your-plugin-dir>/PicoScenes-PDK is your plugin's location
- ``-i virtualsdr`` : Switches the device to virtualsdr
- ``--demo HelloPicoScenes``: enable demo command, "HelloPicoScenes" is the parameter


PicoScenes uses polymorphism to manage plugins. Developer should inherit from `AbstractPicoScenesPlugin` to develop their plugins. The following diagram shows the inheritance.

.. figure:: /images/Plugin-Structure.png
    :figwidth: 1000px
    :target: /images/Plugin-Structure.png
    :align: center

The **initialization** method will define the plugin's commands. **parseAndExecuteCommands** will be used to parse these commands and their arguments.

.. code-block:: cpp

    void DemoPlugin::initialization() {
    options = std::make_shared<po::options_description>("Demo Options", 120);
    options->add_options()
            ("demo", po::value<std::string>(), "--demo <param>");
    }

- ``options->add_options()``: Define command demo and set the parameter's type

.. code-block:: cpp

    void DemoPlugin::parseAndExecuteCommands(const std::string &commandString) {
        ...
        if (vm.count("demo")) {
            auto optionValue = vm["demo"].as<std::string>();
            LoggingService_Plugin_info_print("Plugin has been installed, its param is {}",std::string(optionValue));
        }
    }

- ``vm["demo"].as<std::string>()``: Get the following parameters, in our example, it is HelloPicoScenes


Receiving plugin
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You have now learned how to define a command and parse it. In the upcoming example, you will learn how to make a receive/send plugin.

Before writing a plugin for `receiving` signals, you need to first understand the process of writing a receive plugin.

.. figure:: /images/Receiving.jpg
    :figwidth: 1000px
    :target: /images/Receiving.jpg
    :align: center

- ``parseAndExecuteCommands()``: Parse plugin command and parameters
- ``nic->startRxService()``:  Start receiving signals from different devices
- ``rxHandle()`` : Handle receiving signals


Add plugin commands and activate the receive mode

DemoPlugin.cxx

.. code-block:: cpp

    void DemoPlugin::parseAndExecuteCommands(const std::string &commandString) {
        po::variables_map vm;

        auto style = pos::allow_long | pos::allow_dash_for_short |
                     pos::long_allow_adjacent | pos::long_allow_next |
                     pos::short_allow_adjacent | pos::short_allow_next;

        po::store(po::command_line_parser(po::split_unix(commandString)).options(*options).style(style).allow_unregistered().run(), vm);
        po::notify(vm);

        if (vm.count("demo"))
        {
            auto modeString = vm["demo"].as<std::string>();
            if (modeString.find("logger") != std::string::npos) {
                nic->startRxService();
            }
        }
    }


DemoPlugin.hxx

.. code-block:: cpp

    class DemoPlugin : public AbstractPicoScenesPlugin {
    public:
        ...
        ...
        void rxHandle(const ModularPicoScenesRxFrame &rxframe) override;

    private:
        std::shared_ptr<po::options_description> options;
    };

Also, you should implement `rxHandle` in `DemoPlugin.cxx`

.. code-block:: cpp

    void DemoPlugin::rxHandle(const ModularPicoScenesRxFrame &rxframe) {
        LoggingService_debug_print("This is my rxframe: {}",rxframe.toString());
    }

Build the plugin and run in terminal

.. code-block:: bash

    ./Fast_Build_Install_Plugin.sh

.. code-block:: bash

    PicoScenes "-d debug
                --bp
                --plugin-dir <your-plugin-dir>/PicoScenes-PDK;
                -i virtualsdr
                --rx-from-file sample5
                --demo logger"

- ``--rx-from-file``: Read signals from file sample.bbsignal

If successfully running, the terminal will show

.. code-block:: bash

    [17:34:09.811501] [Platform] [Debug] This is my rxframe: RxFrame:{RxSBasic:[device=USRP(SDR), center=2412, control=2412, CBW=20, format=HT, Pkt_CBW=20, MCS=0, numSTS=1, GI=0.8us, UsrIdx/NUsr=(0/1), timestamp=1288, system_ns=1704015249809485863, NF=-78, RSS=-7], RxExtraInfo:[len=24, ver=0x2, sf=20.000000 MHz, cfo=0.000000 kHz, sfo=0 Hz], SDRExtra:[scrambler=39, packetStartInternal=25761, rxIndex=25760, rxTime=0.001288, decodingDelay=0.0620708466, lastTxTime=0, sigEVM=2.4], (HT)CSI:[device=USRP(SDR), format=HT, CBW=20, cf=2412.000000 MHz, sf=20.000000 MHz, subcarrierBW=312.500000 kHz, dim(nTones,nSTS,nESS,nRx,nCSI)=(56,1,0,1,1), raw=0B], LegacyCSI:[device=USRP(SDR), format=NonHT, CBW=20, cf=2412.000000 MHz, sf=20.000000 MHz, subcarrierBW=312.500000 kHz, dim(nTones,nSTS,nESS,nRx,nCSI)=(52,1,0,1,2), raw=0B], BasebandSignal:[(float) 3045x1], MACHeader:[type=[MF]Reserved_14, dest=00:16:ea:12:34:56, src=00:16:ea:12:34:56, seq=8, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=1, type=10, taskId=55742, txId=0], TxExtraInfo:[len=8, ver=0x2], MPDU:[num=1, total=75B]}


Transmitting plugin
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The process of frame transmitting is likely to frame receiving. Let's see diagram.

.. figure:: /images/Transmitting.png
    :figwidth: 1000px
    :target: /images/Transmitting.png
    :align: center

- ``nic->startTxService()``:  Start transmitting signals process
- ``buildBasicFrame`` : Initialize and build Packet frame
- ``nic->transmitPicoScenesFrameSync(*txframe);``: deliver frame to phy layer

Add buildBasicFrame() in ``Demoplugin.hxx``

.. code-block:: cpp

    class DemoPlugin : public AbstractPicoScenesPlugin {
    public:
        ...

        void rxHandle(const ModularPicoScenesRxFrame &rxframe) override;

        [[nodiscard]] std::shared_ptr<ModularPicoScenesTxFrame> buildBasicFrame(uint16_t taskId = 0) const ;

    private:
        std::shared_ptr<po::options_description> options;
    };

Implement buildBasicFrame in ``Demoplugin.cxx``

.. code-block::

    std::shared_ptr<ModularPicoScenesTxFrame> DemoPlugin::buildBasicFrame(uint16_t taskId) const
    {
        auto frame = nic->initializeTxFrame();

        /**
         * @brief PicoScenes Platform CLI parser has *absorbed* the common Tx parameters.
         * The platform parser will parse the Tx parameters options and store the results in AbstractNIC.
         * Plugin developers now can access the parameters via a new method nic->getUserSpecifiedTxParameters().
         */

        frame->setTxParameters(nic->getUserSpecifiedTxParameters());
        frame->setTaskId(taskId);
        auto sourceAddr = MagicIntel123456;
        frame->setSourceAddress(sourceAddr.data());
        frame->set3rdAddress(nic->getFrontEnd()->getMacAddressPhy().data());

        return frame;

    }

Add transmit command in ``parseAndExecuteCommands``, in this case, we use command ``injector``

.. code-block::

    void DemoPlugin::parseAndExecuteCommands(const std::string &commandString) {
        po::variables_map vm;

        auto style = pos::allow_long | pos::allow_dash_for_short |
                     pos::long_allow_adjacent | pos::long_allow_next |
                     pos::short_allow_adjacent | pos::short_allow_next;

        po::store(po::command_line_parser(po::split_unix(commandString)).options(*options).style(style).allow_unregistered().run(), vm);
        po::notify(vm);

        if (vm.count("demo"))
        {
            auto modeString = vm["demo"].as<std::string>();
            if (modeString.find("logger") != std::string::npos) {
                nic->startRxService();
            }
            else if (modeString.find("injector") != std::string::npos)
            {
                nic->startTxService();
                auto taskId = SystemTools::Math::uniformRandomNumberWithinRange<uint16_t>(9999, UINT16_MAX);
                auto txframe = buildBasicFrame(taskId);
                nic->transmitPicoScenesFrameSync(*txframe);

            }
        }
    }


Build the plugin and run it in terminal

.. code-block:: bash

    ./Fast_Build_Install_Plugin.sh

.. code-block:: bash

    PicoScenes "-d debug
                --bp --plugin-dir <your-plugin-dir>/PicoScenes-PDK;
                -i virtualsdr
                --demo injector"


In this case, we send one frame to sdr, you can find log in the terminal like this

.. code-block:: bash

    [18:15:35.993309] [SDR     ] [Debug] virtualsdr(Virtual(SDR))-->TxFrame:{MACHeader:[type=[MF]Reserved_14, dest=00:16:ea:12:34:56, src=00:16:ea:12:34:56, seq=0, frag=0, mfrags=0], PSFHeader:[ver=0x20201110, device=QCA9300, numSegs=0, type=0, taskId=33196, txId=0], tx_param[preset=DEFAULT, type=HT, CBW=20, MCS=0, numSTS=1, Coding=BCC, GI=0.8us, numESS= , sounding(11n)=1]} | PPDU: 2480




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

