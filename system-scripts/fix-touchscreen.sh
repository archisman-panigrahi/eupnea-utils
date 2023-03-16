#!/bin/bash

# Reload the elants_i2c driver
# This is mainline specific, as it works fine on chromeos kernels
# Check if module is loaded
# Reload module before biding touchscreen, as otherwise the binding will be lost on module reload
if lsmod | grep -qw elants_i2c; then
  # Reload the module
  echo "Reloading elants_i2c driver"
  modprobe -r elants_i2c
  modprobe elants_i2c
fi

# link the i2c_hid_acpi driver to the SYTS7817 touchscreen device
# SOURCE: https://github.com/GalliumOS/galliumos-distro/issues/606#issuecomment-1009236456
if [ -d /sys/bus/i2c/devices/i2c-SYTS7817:00 ]; then
  echo "Linking i2c_hid_acpi to SYTS7817 touchscreen device"
  echo "i2c-SYTS7817:00" >/sys/bus/i2c/drivers/i2c_hid_acpi/bind
fi
# Set correct module for goodix touchscreens
if [ -d /sys/bus/i2c/devices/i2c-GDIX0000:00 ]; then
  echo "Linking i2c_hid_acpi to GDIX0000 touchscreen device"
  echo "i2c-GDIX0000:00" >/sys/bus/i2c/drivers/i2c_hid_acpi/bind
fi