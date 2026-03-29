# OpenWRT BPI-R4 with [danpawlik:add-eeprom patch](https://github.com/openwrt/openwrt/pull/22447/files)

> [!WARNING]
> Currently, 25.12.2 build is unstable. The config is not being recognized as expected and there are missing content in the distfeeds.list file for APK. Fixes will be released for 25.12.3 and up builds ONLY.

## Config
- Sinovoip Banana Pi BPI-R4
- All Kernel Modules (will be built as downloadable packages)
- Disabled dnsmasq (Bind9 is more powerful)
- Enabled Bind9
- Enabled full-featured odhcpd (to replace dnsmasq)
- Enabled full-featured wpad-openssl (for complete WiFi features)
- Enabled openssh-sftp-server (for quick SFTP access)
- Enabled luci-app-statistics
- Enabled nginx-full and luci-nginx (for a more flexible web hosting in the router)

## Introduction

This specific configuration closely mirrors the BPI-R4 I daily drive. I initially made this builder for my own convenience. If you are of the opinion against my choices above and would like a configuration matching the original OpenWRT BPI-R4 configuration, please do not hesitate to create an issue. I will definitely consider it.

This build has danpawlik:add-eeprom added on top of the last commit of a specific OpenWRT version release. For example, the 25.12.2 is built on a specific commit and this builder uses one where danpawlik:add-eeprom is added after that commit before its built. This essentially fixes the WiFi low power issue.

If you didn't know, some of the BE14 boards sold had faulty EEPROM calibration data. This meant that most owners of the BPI-R4 had a WiFi 7 router that only penetrates 1 floor of a concrete house! I'm writing from experience. danpawlik fixed this by creating a pull request that has not been considered by OpenWRT maintainers to be added into the main line yet. That basically means, it won't be fixed unless you install a build like this.

This builder has been designed to be manually triggered but automatically run to avoid any 'supply chain' attack threats from everyone's perspective. All aspects of this build are thus publicly available.

## Install using the latest release

Download the img or the sysupgrade file in the [latest release](https://github.com/ronhombre/openwrt-builder-bpi-r4/releases/latest) and flash it into your OpenWRT.

### You need to run this after install and reboot to initialize the patch
```
current_bootconf_extra="$(fw_printenv -n bootconf_extra)"
if [ -n "${current_bootconf_extra}" ]; then
    new_bootargs="$current_bootconf_extra#mt7988a-bananapi-bpi-r4-wifi-be14"
else
    new_bootargs="mt7988a-bananapi-bpi-r4-wifi-be14"
fi

fw_setenv bootconf_extra $new_bootargs
```
This command is created by danpawlik. For more info [see](https://github.com/openwrt/openwrt/pull/22447/).

### Acknowledgement
- danpawlik for the fix.
- OpenWRT contributors for OpenWRT.
- Inspired by woziwrt's builder.

### License
- Same as the license used by the OpenWRT being built in all forms and manner.
