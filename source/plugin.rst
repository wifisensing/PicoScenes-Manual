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

The `initialization` method will define the plugin's commands. `parseAndExecuteCommands` will be used to parse these commands and their arguments.

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

