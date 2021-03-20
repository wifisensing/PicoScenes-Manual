#!/bin/sh

set -e

array_prepare_for_picoscenes "3 4" "2412 HT20"


PicoScenes "-d debug;
            -i 4 --mode logger; // this command line format support comments. Comments start with //
            -i 3 --mode injector --repeat 1000 --delay 5000; // NIC <3> in injector mode, injects 1000 packets with 5000us interval
            -q // -q is a shortcut for --quit"