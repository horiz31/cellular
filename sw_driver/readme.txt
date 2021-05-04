Sierra Wireless USB Driver
===========================
Supported Devices: EM9190 DV1/DV2/DV3/DV4

How to Build the driver
=======================
run "make" to generate the driver binary: qcserial.ko 

How to Install the driver
========================= 
1. run "make install"
2. reboot

How to verify driver installation
=================================
"lsusb -t" should generate an output as below: 

/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/8p, 5000M
    |__ Port 2: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
    |__ Port 7: Dev 2, If 5, Class=Vendor Specific Class, Driver=, 5000M
    |__ Port 7: Dev 2, If 3, Class=Vendor Specific Class, Driver=qcserial, 5000M
    |__ Port 7: Dev 2, If 1, Class=CDC Data, Driver=cdc_mbim, 5000M
    |__ Port 7: Dev 2, If 4, Class=Vendor Specific Class, Driver=qcserial, 5000M
    |__ Port 7: Dev 2, If 0, Class=Communications, Driver=cdc_mbim, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/16p, 480M
    |__ Port 9: Dev 2, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M
    |__ Port 9: Dev 2, If 1, Class=Human Interface Device, Driver=usbhid, 1.5M
    |__ Port 10: Dev 3, If 0, Class=Human Interface Device, Driver=usbhid, 1.5M

The driver exposes two device interfaces:
1. /dev/ttyUSB0, AT port
2. /dev/ttyUSB1, DM port

How to communicate with AT port 
==================================
run "sudo minicom -D /dev/ttyUSB0". 
To close it, press CTRL+A and then X

Enable zero length packet in usb_wwan
==================================
To support FW downloading on 9x50 based products, driver needs to support USB
zero length packet. However this feature is not enabled in usb_wwan for some kernel
versions. So we have usb_wwan.c attached to show how to enable it.

In usb_wwan_setup_urb function, the two lines of code should be found.

	if (intfdata->use_zlp && dir == USB_DIR_OUT)
		urb->transfer_flags |= URB_ZERO_PACKET;

That indicates the ZLP feature was enabled.




