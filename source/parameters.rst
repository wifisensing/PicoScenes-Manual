PicoScenes Program Options
==============================

Program Options Hierarchy
-----------------------------

Various PicoScenes options (program parameters) are organized in a hierarchical structure as listed below:
    - Per-Plugin level options (Top)
        Each PicoScenes plugin can have its own program options. For example, EchoProbe plugin has a large set of options controlling many aspects of packet injection and round-trip measurement

    - Frontend level options
        PicoScenes provides two independent sets of options for QCA9300/IWL5300 and SDR hardware frontend. User specify different options for different Wi-Fi NICs or USRPs.

    - Platform Options
        These are a few global options that are valid *after* the launch of the PicoScenes platform.

    - Platform Startup Options (Bottom)
        These are a few global options that are valid *before* the launch of the PicoScenes platform.

    In the following text, we present the detailed description for each PicoScenes (including EchoProbe plugin) options.

    .. tip:: You can also look up the **complete** program options by running the command ``PicoScenes --help``, if you have successfully installed the PicoScenes.


Platform Startup Options (Bottom)
-----------------------------------
.. csv-table:: Platform Startup Options
   :header: "Option Name and Format", "Description", "Default Value", "Value Range", "Notes", "Example"
   :widths: 5, 5, 30, 30, 20, 20

   --plugin-dir <new_plugin_dir>, specify to change the plugins search directory to your designated, /usr/local/PicoScenes/plugins, N/A, No, --plugin-dir /home/YOUR_NAME/PicoScenes-PDK
   -d <log_diplay_level>, specify the log message display level, ``info``, "[``vv``, ``verbose``, ``debug``, ``detail``, ``trace``, ``info``, ``warning``, ``error``, ``mute``]",  ``vv`` is the most verbose mode and ``mute`` silence all display,  -d trace
   --no-hp, "Disable process priority escalation. PicoScenes will by default try to escalate its process priority to improve the performance. You may specify  to skip the priority escalation."


Platform Options
-----------------------------------


Frontend level options
-----------------------------------



Per-Plugin level options (Top)
-----------------------------------

