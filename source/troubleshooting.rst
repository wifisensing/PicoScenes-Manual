Troubleshooting
=================================================

The following shows some of the most frequently seen errors and their solutions for quick reference. For other issues that happened during the installation, upgrading or later usage, you may seek :ref:`tech_support` by submitting a bug report to PicoScenes Issues Tracker.


**Q1**: I encounter an error during apt installation saying, "E: fail to fetch XXX, File has unexpected size (xxx != xxx). ..."

A: The possible reason is that the PicoScenes repository is updated, but your local apt cache is not synced. To fix this error, you should run ``sudo apt update`` to sync your local apt cache. If you still encounter this problem, you may seek :ref:`tech_support`.


**Q2**: I encounter an error during USRP B200 series installation, "Could not find the image 'usrp_b200_fw.hex' in the image directory /usr/share/uhd/images ...."

A: run ``sudo /usr/lib/uhd/utils/uhd_images_downloader.py`` to download **all** USRP images.