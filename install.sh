#!/bin/sh

SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false
REPLACE=""
support_path=""

ui_print ""
ui_print "Author:"
ui_print "  Telegram: @RiProG | Channel: @RiOpSo | Group: @RiOpSoDisc"
ui_print ""

for path in /sys/class/power_supply/*/constant_charge_current /sys/class/power_supply/*/constant_charge_current_max /sys/class/power_supply/*/ctm_current_max /sys/class/power_supply/*/hw_current_max /sys/class/power_supply/*/input_current_limit /sys/class/power_supply/*/input_current_max /sys/class/power_supply/*/input_voltage_limit /sys/class/power_supply/*/pd_current_max; do
	if [ -e "$path" ]; then
		support_path="$path"
		break
	fi
done

if [ -n "$support_path" ]; then
	ui_print "Module: Supported"
else
	ui_print "Module: Not Supported"
	exit 1
fi

unzip -o "$ZIPFILE" 'action.sh' -d "$MODPATH" >&2
unzip -p "$ZIPFILE" 'source.sh' >"$MODPATH/PCH"
unzip "$ZIPFILE" webroot/* -d "$MODPATH/" >/dev/null 2>&1
