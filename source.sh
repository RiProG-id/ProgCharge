#!/bin/sh

if [ -z "$1" ]; then
	exit 1
fi

choice=$1

case $choice in
1)
	current_value=2000000
	voltage_value=5000000
	W=10
	mA=2000
	;;
2)
	current_value=2500000
	voltage_value=5500000
	W=14
	mA=2500
	;;
3)
	current_value=3000000
	voltage_value=6000000
	W=18
	mA=3000
	;;
4)
	current_value=3500000
	voltage_value=6500000
	W=23
	mA=3500
	;;
5)
	current_value=4000000
	voltage_value=7000000
	W=28
	mA=4000
	;;
6)
	current_value=4500000
	voltage_value=7500000
	W=34
	mA=4500
	;;
7)
	current_value=5000000
	voltage_value=8000000
	W=40
	mA=5000
	;;
8)
	current_value=5500000
	voltage_value=8500000
	W=47
	mA=5500
	;;
9)
	current_value=6000000
	voltage_value=9000000
	W=54
	mA=6000
	;;
10)
	current_value=6500000
	voltage_value=9500000
	W=62
	mA=6500
	;;
11)
	current_value=7000000
	voltage_value=10000000
	W=70
	mA=7000
	;;
12)
	current_value=7500000
	voltage_value=10500000
	W=79
	mA=7500
	;;
13)
	current_value=8000000
	voltage_value=11000000
	W=88
	mA=8000
	;;
14)
	current_value=8500000
	voltage_value=11500000
	W=98
	mA=8500
	;;
15)
	current_value=9000000
	voltage_value=12000000
	W=108
	mA=9000
	;;
*) exit 1 ;;
esac

for path in /sys/class/power_supply/*/constant_charge_current /sys/class/power_supply/*/constant_charge_current_max /sys/class/power_supply/*/ctm_current_max /sys/class/power_supply/*/hw_current_max /sys/class/power_supply/*/input_current_limit /sys/class/power_supply/*/input_current_max /sys/class/power_supply/*/pd_current_max; do
	if [ -e "$path" ]; then
		chmod +w "$path"
		echo "$current_value" >"$path"
		chmod -w "$path"
	fi
done >/dev/null 2>&1

voltage_supported=false

for path in /sys/class/power_supply/*/input_voltage_limit; do
	if [ -e "$path" ]; then
		chmod +w "$path"
		echo "$voltage_value" >"$path"
		chmod -w "$path"
		voltage_supported=true
	fi
done >/dev/null 2>&1

if [ "$voltage_supported" = true ]; then
	su -lp 2000 -c "cmd notification post -S bigtext -t 'Power Selection' 'ProgCharge' 'You selected $W W'" >/dev/null 2>&1
else
	su -lp 2000 -c "cmd notification post -S bigtext -t 'Current Selection' 'ProgCharge' 'You selected $mA mA'" >/dev/null 2>&1
fi
