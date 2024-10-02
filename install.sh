#!/bin/sh
SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false
REPLACE=""
current_path=$(ls /sys/class/power_supply/*/constant_charge_current_max /sys/class/power_supply/charger/input_current_limit 2>/dev/null)
bypass_path=/sys/devices/platform/charger/bypass_charger
temp_path=$(ls /sys/class/power_supply/*/temp_warm 2>/dev/null)
current=false
bypass=false
tempLimit=false
ui_print ""
ui_print "*****************************************"
ui_print "*      RiProG Open Source @RiOpSo       *"
ui_print "*****************************************"
ui_print "*                                       *"
ui_print "*                 Author                *"
ui_print "*             Muhammad Rizki            *"
ui_print "* Telegram: @RiProG | Github: RiProG-ID *"
ui_print "*                                       *"
ui_print "*****************************************"
ui_print ""
if [ -n "$current_path" ]; then
	uiprint "FastCharge Config: Supported"
	current=true
else
	uiprint "FastCharge Config: Not Supported"
fi
if [ -e "$bypass_path" ]; then
	uiprint "BypassCharge Config: Supported"
	bypass=true
else
	uiprint "BypassCharge Config: Not Supported"
fi
if [ -n "$temp_path" ]; then
	uiprint "TempLimit Config: Supported"
	tempLimit=true
else
	uiprint "TempLimit Config: Not Supported"
fi
if [ "$current" = false ] && [ "$bypass" = false ] && [ "$tempLimit" = false ]; then
	uiprint "All features not supported."
	exit 1
fi
sleep 2
ui_print "- Extracting module files"
mkdir -p "$MODPATH/system/bin"
unzip -p "$ZIPFILE" 'source.sh' >"$MODPATH/system/bin/PCH"
chmod +x "$MODPATH/system/bin/PCH"
ui_print ""
ui_print "su -c PCH | to configure"
ui_print ""
