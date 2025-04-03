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
	A="2.0"
	;;
2)
	current_value=2500000
	voltage_value=5500000
	W=14
	A="2.5"
	;;
3)
	current_value=3000000
	voltage_value=6000000
	W=18
	A="3.0"
	;;
4)
	current_value=3500000
	voltage_value=6500000
	W=23
	A="3.5"
	;;
5)
	current_value=4000000
	voltage_value=7000000
	W=28
	A="4.0"
	;;
6)
	current_value=4500000
	voltage_value=7500000
	W=34
	A="4.5"
	;;
7)
	current_value=5000000
	voltage_value=8000000
	W=40
	A="5.0"
	;;
8)
	current_value=5500000
	voltage_value=8500000
	W=47
	A="5.5"
	;;
9)
	current_value=6000000
	voltage_value=9000000
	W=54
	A="6.0"
	;;
10)
	current_value=6500000
	voltage_value=9500000
	W=62
	A="6.5"
	;;
11)
	current_value=7000000
	voltage_value=10000000
	W=70
	A="7.0"
	;;
12)
	current_value=7500000
	voltage_value=10500000
	W=79
	A="7.5"
	;;
13)
	current_value=8000000
	voltage_value=11000000
	W=88
	A="8.0"
	;;
14)
	current_value=8500000
	voltage_value=11500000
	W=98
	A="8.5"
	;;
15)
	current_value=9000000
	voltage_value=12000000
	W=108
	A="9.0"
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
	su -lp 2000 -c "cmd notification post -S bigtext -t 'Current Selection' 'ProgCharge' 'You selected $A A'" >/dev/null 2>&1
fi
