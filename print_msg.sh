#! /bin/sh
#
# Ver: 1.0
# Author: yenchang.lin@gmail.com
#
#  esc="\033"   # If this doesn't work, enter an ESC directly.
#
#  # Foreground colors (as denoted by the 'f' at the end of the names)
#  blackf="${esc}[30m";   redf="${esc}[31m";    greenf="${esc}[32m"
#  yellowf="${esc}[33m"   bluef="${esc}[34m";   purplef="${esc}[35m"
#  cyanf="${esc}[36m";    whitef="${esc}[37m"
#
#  # Background colors
#  blackb="${esc}[40m";   redb="${esc}[41m";    greenb="${esc}[42m"
#  yellowb="${esc}[43m"   blueb="${esc}[44m";   purpleb="${esc}[45m"
#  cyanb="${esc}[46m";    whiteb="${esc}[47m"
#
#  # Bold, italic, underline, and inverse style toggles 
#  boldon="${esc}[1m";    boldoff="${esc}[22m"
#  italicson="${esc}[3m"; italicsoff="${esc}[23m"
#  ulon="${esc}[4m";      uloff="${esc}[24m"
#  invon="${esc}[7m";     invoff="${esc}[27m"
#
#  reset="${esc}[0m"
#

LOG_LV_ERRO=1
LOG_LV_WARN=2
LOG_LV_INFO=3
LOG_LV_DBUG=4

# Customize
en_color=1
log_lv_curr=5
is_debug_mode=0

_print_msg () {
	local mtype="$1"
	local msg="$2"

	local esc="\033"

	local greenf="${esc}[32m"
	local redf="${esc}[31m"
	local yellowf="${esc}[33m"
	local purplef="${esc}[35m"

	local reset="${esc}[0m"
	

	if [ "$en_color" = "1" ]; then
		case "$mtype" in
		"INFO")
			mtype="${greenf}${mtype}${reset}"
			;;
		"ERRO")
			mtype="${redf}${mtype}${reset}"
			;;
		"WARN")
			mtype="${yellowf}${mtype}${reset}"
			;;
		"DBUG")
			mtype="${purplef}${mtype}${reset}"
			;;
		*)
			;;
		esac
	fi

	echo -e "$mtype >> $msg"
}

print_error () {
	local msg="$*"
	if [ $log_lv_curr -ge $LOG_LV_ERRO ]; then
		_print_msg "ERRO" "$msg"
	fi

	if [ "$is_debug_mode" = "0" ]; then
		exit 1
	fi
}

print_warn () {
	local msg="$*"
	if [ $log_lv_curr -ge $LOG_LV_WARN ]; then
		_print_msg "WARN" "$msg"
	fi
}

print_info () {
	local msg="$*"
	if [ $log_lv_curr -ge $LOG_LV_INFO ]; then
		_print_msg "INFO" "$msg"
	fi
}

print_debug () {
	local msg="$*"
	if [ $log_lv_curr -ge $LOG_LV_DBUG ]; then
		_print_msg "DBUG" "$msg"
	fi
}

do_main () {
	print_debug	"This is debug message"
	print_info	"This is info message"
	print_warn	"This is warning message"
	print_error	"This is error message"
}

do_main

