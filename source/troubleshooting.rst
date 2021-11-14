Troubleshooting
=================================================

The following shows some of the most frequently seen errors and their solutions for quick reference. For other issues that happened during the installation, upgrading or later usage, you may seek :ref:`tech_support` by submitting a bug report to PicoScenes Issues Tracker.


Errors during installation \& daily update
----------------------------------------------

*Q*: **Error during apt update, "  Certificate verification failed: The certificate is NOT trusted. The certificate chain uses expired certificate.  Could not handshake: Error in the certificate verification..."**

A: Re-install *ca-certificate* package by ``sudo apt-get install --reinstall ca-certificates``.

*Q*: **Error during apt installation saying, "E: fail to fetch XXX, File has unexpected size (xxx != xxx). ..."**

A: The possible reason is that the PicoScenes repository is updated, but your local apt cache is not synced. To fix this error, you should run ``sudo apt update`` to sync your local apt cache. If you still encounter this problem, you may seek :ref:`tech_support`.



Runtime errors
---------------------

*Q*: **[Warning] Incompatible kernel version, current version: XXX, expected version: YYY.**

A: This is because your system loads the Incompatible kernel. Solution: reboot your computer and choose the expected kernel version YYY in grub menu. 

If your computer doesn't show the grub boot selection menu, you may refer to https://askubuntu.com/questions/16042/how-to-get-to-the-grub-menu-at-boot-time/16049#16049 to restore the menu.


*Q*: **Error during USRP B200 series installation, "Could not find the image 'usrp_b200_fw.hex' in the image directory /usr/share/uhd/images ...."**

A: run ``sudo /usr/lib/uhd/utils/uhd_images_downloader.py`` to download **all** USRP images.