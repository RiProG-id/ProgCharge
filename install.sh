#!/bin/sh
SKIPMOUNT=false
PROPFILE=false
POSTFSDATA=false
LATESTARTSERVICE=false
REPLACE=""
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
sleep 2
ui_print "- Extracting module files"
mkdir -p "$MODPATH/system/bin"
unzip -p "$ZIPFILE" 'source.sh' >"$MODPATH/system/bin/PCH"
chmod +x "$MODPATH/system/bin/PCH"
ui_print ""
ui_print "su -c PCH | to configure"
ui_print ""
