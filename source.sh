#!/bin/sh
current_path=$(ls /sys/class/power_supply/*/constant_charge_current_max /sys/class/power_supply/charger/input_current_limit 2>/dev/null)
bypass_path=/sys/devices/platform/charger/bypass_charger
volt_path=/sys/class/power_supply/charger/input_voltage_limit
temp_path=$(ls /sys/class/power_supply/*/temp_warm 2>/dev/null)
for path in $current_path $bypass_path $volt_path $temp_path; do
	chmod +rw "$path"
done >/dev/null 2>&1
while true; do
	clear
	echo "By RiProG ID"
	echo "Welcome to ProgCharge."
	echo ""
	if [ -n "$current_path" ]; then
		for path in $current_path; do
			current_charge=$(cat "$path")
		done >/dev/null 2>&1
		if [ -f $volt_path ]; then
			volt_current=$(cat $volt_path 2>/dev/n)
			mA_value=$((charge_current / 1000))
			mV_value=$((volt_current / 1000))
			mW_value=$((mA_value * mV_value / 1000))
			W_value=$((mW_value / 1000))
			echo "MaxCharge current: ${W_value} W"
		else
			A_value=$((charge_current / 1000000))
			A_decimal=$((charge_current / 100000 % 10))
			if [ "$A_decimal" -ge 5 ]; then
				echo "MaxCharge current: ${A_value}.5 A"
			else
				echo "MaxCharge current: ${A_value}.0 A"
			fi
		fi
		current=true
	else
		echo "Charge current: -"
		current=false
	fi
	if [ -f $bypass_path ]; then
		if [ "$(cat $bypass_path 2>/dev/null)" -eq 1 ]; then
			echo "Bypass Charger: Enabled"
		else
			echo "Bypass Charger: Disabled"
		fi
		bypass=true
	else
		echo "Bypass Charger: -"
		bypass=false
	fi
	if [ -n "$temp_path" ]; then
		for path in $temp_path; do
			temp_current=$(cat "$path")
		done >/dev/null 2>&1
		temp_value=$((temp_current / 10))
		echo "Charge TempLimit: ${temp_value}°C"
		templimit=true
	else
		echo "Charge TempLimit: -"
		templimit=false
	fi
	echo ""
	echo "[1] Set FastCharging Current"
	echo "[2] Set Bypass Charging"
	echo "[3] Set Charging TempLimit"
	echo "[0] Exit"
	echo ""
	printf "Select an option: "
	read -r option
	if [ "$option" -eq 1 ]; then
		if [ $current = false ]; then
			echo "Not Supported"
			sleep 2
			continue
		fi
	elif [ "$option" -eq 2 ]; then
		if [ $bypass = false ]; then
			echo "Not Supported"
			sleep 2
			continue
		fi
	elif [ "$option" -eq 3 ]; then
		if [ "$templimit" = false ]; then
			echo "Not Supported"
			sleep 2
			continue
		fi
	fi
	case "$option" in
	"1")
		if [ -f $volt_path ]; then
			charge_current="3500000"
			volt_current="5000000"
			for i in $(seq 1 15); do
				mA_value=$((charge_current / 1000))
				mV_value=$((volt_current / 1000))
				mW_value=$((mA_value * mV_value / 1000))
				W_value=$((mW_value / 1000))
				printf "[%2d] %3dW  " "$i" "$W_value"
				charge_current=$((charge_current + 500000))
				volt_current=$((volt_current + 500000))
				if [ $((i % 3)) -eq 0 ]; then
					echo ""
				fi
			done
			if [ $((15 % 3)) -ne 0 ]; then
				echo ""
			fi
		else
			charge_current="3500000"
			for i in $(seq 1 15); do
				A_value=$((charge_current / 1000000))
				A_decimal=$((charge_current / 100000 % 10))
				if [ "$A_decimal" -ge 5 ]; then
					printf "[%2d] %d.5A  " "$i" "$A_value"
				else
					printf "[%2d] %d.0A  " "$i" "$A_value"
				fi
				charge_current=$((charge_current + 500000))
				if [ $((i % 3)) -eq 0 ]; then
					echo ""
				fi
			done
			if [ $((15 % 3)) -ne 0 ]; then
				echo ""
			fi
		fi
		echo ""
		charge_current="3500000"
		volt_current="5000000"
		while true; do
			printf "Enter an option (1-15): "
			read -r option
			if [ "$option" -lt 1 ] || [ "$option" -gt 15 ]; then
				echo "Invalid option."
				sleep 2
				continue
			fi
			for i in $(seq 1 $((option - 1))); do
				charge_current=$((charge_current + 500000))
				volt_current=$((volt_current + 500000))
			done
			break
		done
		if [ -f $volt_path ]; then
			mA_value=$((charge_current / 1000))
			mV_value=$((volt_current / 1000))
			mW_value=$((mA_value * mV_value / 1000))
			W_value=$((mW_value / 1000))
			printf "Set charge current to %3dW - " "$W_value"
			success=false
			for path in $current_path; do
				if echo "$charge_current" >"$path"; then
					success=true
				fi
			done >/dev/null 2>&1
			if echo "$volt_current" >$volt_path; then
				success=true
			fi >/dev/null 2>&1
			sleep 5
			if [ "$success" = true ]; then
				printf "Success\n"
			else
				printf "Failed\n"
			fi
			sleep 5
		else
			A_value=$((charge_current / 1000000))
			A_decimal=$((charge_current / 100000 % 10))
			if [ "$A_decimal" -ge 5 ]; then
				printf "Set charge current to %d.5A - " "$A_value"
			else
				printf "Set charge current to %d.0A - " "$A_value"
			fi
			success=false
			for path in $current_path; do
				if echo "$charge_current" >"$path"; then
					success=true
				fi
			done >/dev/null 2>&1
			sleep 5
			if [ "$success" = true ]; then
				printf "Success\n"
			else
				printf "Failed\n"
			fi
		fi
		sleep 5
		;;
	"2")
		echo ""
		success=false
		echo "Enable Bypass Charger?:"
		printf "(type 1 for yes, 0 for no): "
		read -r bypass_option
		if [ "$bypass_option" = "1" ]; then
			printf "Enabling Bypass Charger - "
			if echo "1" >$bypass_path; then
				success=true
			fi >/dev/null 2>&1
			sleep 5
			if [ "$success" = true ]; then
				printf "Success\n"
			else
				printf "Failed\n"
			fi
		elif [ "$bypass_option" = "0" ]; then
			printf "Disabling Bypass Charger - "
			if echo "0" >$bypass_path; then
				success=true
			fi >/dev/null 2>&1
			sleep 5
			if [ "$success" = true ]; then
				printf "Success\n"
			else
				printf "Failed\n"
			fi
		else
			echo "Invalid option."
			sleep 2
			continue
		fi
		sleep 5
		;;
	"3")
		echo ""
		temp_current=300
		for index in $(seq 1 6); do
			i=$((30 + (index - 1) * 5))
			printf "[%d] %d°C  " "$index" "$i"
			if [ $((index % 3)) -eq 0 ]; then
				echo ""
			fi
		done
		printf "Select temperature limit (1-6): "
		read -r option
		if [ "$option" -lt 1 ] || [ "$option" -gt 6 ]; then
			echo "Invalid option."
			sleep 2
			continue
		fi
		for i in $(seq 1 $((option - 1))); do
			temp_current=$((temp_current + 50))
		done
		temp_value=$((temp_current / 10))
		printf "Setting temp limit to %s°C - " "$temp_value"
		success=false
		for path in $temp_path; do
			if echo "temp_current" >"$path"; then
				success=true
			fi
		done >/dev/null 2>&1
		sleep 5
		if [ "$success" = true ]; then
			printf "Success\n"
		else
			printf "Failed\n"
		fi
		break
		sleep 5
		;;
	"0")
		echo "Exiting... Goodbye!"
		sleep 2
		exit 0
		;;
	*)
		echo "Invalid option. Try again."
		sleep 2
		;;
	esac
done
