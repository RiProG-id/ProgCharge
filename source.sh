#!/bin/sh
if [ -z "$1" ]; then
	exit 1
fi
choice=$1
case $choice in
1)
	current_value=2000000
	voltage_value=5000000
	watt=10
	;;
2)
	current_value=2500000
	voltage_value=5500000
	watt=14
	;;
3)
	current_value=3000000
	voltage_value=6000000
	watt=18
	;;
4)
	current_value=3500000
	voltage_value=6500000
	watt=23
	;;
5)
	current_value=4000000
	voltage_value=7000000
	watt=28
	;;
6)
	current_value=4500000
	voltage_value=7500000
	watt=34
	;;
7)
	current_value=5000000
	voltage_value=8000000
	watt=40
	;;
8)
	current_value=5500000
	voltage_value=8500000
	watt=47
	;;
9)
	current_value=6000000
	voltage_value=9000000
	watt=54
	;;
10)
	current_value=6500000
	voltage_value=9500000
	watt=62
	;;
11)
	current_value=7000000
	voltage_value=10000000
	watt=70
	;;
12)
	current_value=7500000
	voltage_value=10500000
	watt=79
	;;
13)
	current_value=8000000
	voltage_value=11000000
	watt=88
	;;
14)
	current_value=8500000
	voltage_value=11500000
	watt=98
	;;
15)
	current_value=9000000
	voltage_value=12000000
	watt=108
	;;
*)
	exit 1
	;;
esac
su -lp 2000 -c "cmd notification post -S bigtext -t 'Watt Choice' 'ProgCharge' 'You selected $watt W'" >/dev/null 2>&1
for path in $(ls /sys/class/power_supply/*/constant_charge_current_max /sys/class/power_supply/*/input_current_limit 2>/dev/null); do
	chmod +w "$path"
	echo "$current_value" >"$path"
	chmod -w "$path"
done >/dev/null 2>&1
for path in $(ls /sys/class/power_supply/*/input_voltage_limit 2>/dev/null); do
	chmod +w "$path"
	echo "$voltage_value" >"$path"
	chmod -w "$path"
done >/dev/null 2>&1
