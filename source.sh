#!/bin/sh
while true; do
	clear
	echo "By RiProG ID"
	echo "Welcome to ProgCharge"
	echo ""
	if ls /sys/class/power_supply/*/constant_charge_current_max 1>/dev/null 2>&1 ||
		ls /sys/class/power_supply/charger/input_current_limit 1>/dev/null 2>&1; then
		echo "[1] Set Fast Charging"
	else
		echo "[1] Set Fast Charging - Not Supported"
	fi
	if [ -f /sys/devices/platform/charger/bypass_charger ]; then
		echo "[2] Set Bypass Charger"
	else
		echo "[2] Set Bypass Charger - Not Supported"
	fi
	echo "[0] Exit"
	echo ""
	echo -n "Select option: "
	read option
	case "$option" in
	"1")
		echo "Current input current:"
		cat /sys/class/power_supply/charger/input_current_limit
		echo ""
		sleep 2
		echo "Select desired current:"
		for i in $(seq 1 20); do
			echo "[$i] $((i * 500))mA"
		done
		echo ""
		sleep 2
		echo -n "Select desired current: "
		read current_option
		case "$current_option" in
		1)
			charge_value="500000"
			voltage_value="4000000"
			;;
		2)
			charge_value="1000000"
			voltage_value="4500000"
			;;
		3)
			charge_value="1500000"
			voltage_value="5000000"
			;;
		4)
			charge_value="2000000"
			voltage_value="5500000"
			;;
		5)
			charge_value="2500000"
			voltage_value="6000000"
			;;
		6)
			charge_value="3000000"
			voltage_value="6500000"
			;;
		7)
			charge_value="3500000"
			voltage_value="7000000"
			;;
		8)
			charge_value="4000000"
			voltage_value="7500000"
			;;
		9)
			charge_value="4500000"
			voltage_value="8000000"
			;;
		10)
			charge_value="5000000"
			voltage_value="8500000"
			;;
		11)
			charge_value="5500000"
			voltage_value="9000000"
			;;
		12)
			charge_value="6000000"
			voltage_value="9500000"
			;;
		13)
			charge_value="6500000"
			voltage_value="10000000"
			;;
		14)
			charge_value="7000000"
			voltage_value="10500000"
			;;
		15)
			charge_value="7500000"
			voltage_value="11000000"
			;;
		16)
			charge_value="8000000"
			voltage_value="11500000"
			;;
		17)
			charge_value="8500000"
			voltage_value="12000000"
			;;
		18)
			charge_value="9000000"
			voltage_value="12500000"
			;;
		19)
			charge_value="9500000"
			voltage_value="13000000"
			;;
		20)
			charge_value="10000000"
			voltage_value="13500000"
			;;
		*)
			echo "Invalid option."
			sleep 2
			continue
			;;
		esac
		echo "Setting charging current to ${charge_value} microamperes..."
		success=0
		for path in /sys/class/power_supply/*/constant_charge_current_max /sys/class/power_supply/charger/input_current_limit; do
			chmod +w "$path"
			echo "$charge_value" >"$path" 2>/dev/null
			if [ $? -eq 0 ]; then
				success=1
			fi
		done
		if [ "$success" -eq 1 ]; then
			echo "Charging current successfully set to $charge_value microamperes."
		else
			echo "Failed to set charging current."
		fi
		sleep 2
		if [ -f /sys/class/power_supply/charger/input_voltage_limit ]; then
			echo "Setting input voltage limit to ${voltage_value} microvolts..."
			chmod +w /sys/class/power_supply/charger/input_voltage_limit
			echo "$voltage_value" >/sys/class/power_supply/charger/input_voltage_limit 2>/dev/null
			if [ $? -eq 0 ]; then
				echo "Input voltage limit successfully changed to ${voltage_value} microvolts."
			else
				echo "Failed to set input voltage limit."
			fi
		fi
		sleep 2
		for path in /sys/class/power_supply/*/temp_warm; do
			chmod +w "$path"
			echo "500" >"$path" 2>/dev/null
			if [ $? -eq 0 ]; then
				echo "Temperature setting successfully changed to 50 Celsius."
			else
				echo "Failed to set temperature setting."
			fi
		done
		sleep 2
		;;
	"2")
		echo -n "Enable Bypass Charger? (type 1 for yes, 0 for no): "
		read bypass_option
		if [ "$bypass_option" = "1" ]; then
			echo "Enabling Bypass Charger..."
			chmod +w /sys/devices/platform/charger/bypass_charger
			echo "1" >/sys/devices/platform/charger/bypass_charger 2>/dev/null
		elif [ "$bypass_option" = "0" ]; then
			echo "Disabling Bypass Charger..."
			chmod +w /sys/devices/platform/charger/bypass_charger
			echo "0" >/sys/devices/platform/charger/bypass_charger 2>/dev/null
		else
			echo "Invalid option."
			sleep 2
			continue
		fi
		if [ $? -eq 0 ]; then
			echo "Bypass Charger status successfully changed."
		else
			echo "Failed to change Bypass Charger status."
		fi
		sleep 2
		;;

	"0")
		echo "Exiting... See you next time!"
		sleep 2
		exit 0
		;;

	*)
		echo "Invalid option. Please try again."
		sleep 2
		;;
	esac
done
