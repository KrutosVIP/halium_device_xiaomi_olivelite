Ubuntu Touch for Redmi Note 9 Pro / Redmi Note 9S / Redmi Note 9 Pro Max / Poco M2 Pro

Device Checklist
================

Working
-------

* Actors: Manual brightness
* Bluetooth: Driver loaded at startup
* Bluetooth: Enable/disable and flightmode works
* Bluetooth: Pairing with headset works, volume control ok
* Bluetooth: Persistent MAC address between reboots
* Camera: Ensure proper cameras are in use (On device with more than 2 logical cameras)
* Camera: Flashlight
* Camera: Photo
* Camera: Switch between back and front camera
* Camera: Video
* Cellular: Carrier info, signal strength
* Cellular: Data connection
* Cellular: Enable/disable mobile data and flightmode works
* Cellular: Incoming, outgoing calls
* Cellular: MMS in, out
* Cellular: PIN unlock
* Cellular: SMS in, out
* Cellular: Switch connection speed between 2G/3G/4G works for all SIMs
* Cellular: Switch preferred SIM for calling and SMS - only for devices that support it
* Cellular: Voice in calls
* Cellular: Change audio routings (Speakerphone, Earphone)
* Endurance: Battery lifetime (Not measured yet)
* Endurance: No reboot needed for 1 week
* GPU: Boot into SPinner animation and Lomiri UI
* GPU: Hardware video decoding
* Misc: Anbox patches applied to kernel
* Misc: AppArmor patches applied to kernel
* Misc: Battery percentage
* Misc: Date and time are correct after reboot (go to flight mode before)
* Misc: Online charging (Green charging symbol, percentage increase in stats etc)
* Misc: Reset to factory defaults
* Misc: Shutdown / Reboot
* Network: NFC - only for devices that support it
* Sensors: Automatic brightness
* Sensors: Fingerprint reader, register and use fingerprints (Halium >=9.0 only)
* Sensors: GPS
* Sensors: Proximity works during a phone call
* Sensors: Rotation works in Lomiri
* Sensors: Touchscreen registers input across whole surface
* Sound: Earphones detected, volume control ok
* Sound: Loudspeaker, volume control ok
* Sound: Microphone, recording works
* Sound: System sounds and effects plays correctly (Camera shutter, Screenshot taken, Notifications)
* WiFi: Driver loaded at startup
* WiFi: Enable/disable and flightmode works
* WiFi: Hotspot can be configured, switched on and off, can serve data to clients
* WiFi: Persistent MAC address between reboots

Working with additional steps
-----------------------------

* Actors: Torchlight (Needs the uTorch app from OpenStore)

Not working
-----------

* Actors: Notification LED
* Actors: Vibration
* Misc: logcat, dmesg & syslog do not spam errors and service restarts (Some errors are still shown in dmesg and syslog that needs to be checked if they are fatal)
* Misc: Offline charging (Power down, connect USB cable, device should not boot to UT) (Boots into fastboot)
* Misc: Recovery image builds and works
* Misc: SD card detection and access
* USB: ADB access
* USB: MTP access
