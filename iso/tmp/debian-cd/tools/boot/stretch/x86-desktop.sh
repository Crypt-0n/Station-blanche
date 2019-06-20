# Functions to convert isolinux config to allow selection of desktop
# environment for certain images.

di_syslinux_version() {
	local version
	version=$(sed -nr "s/^# D-I config version ([0-9.])/\1/p" \
		boot$N/isolinux/isolinux.cfg)

	[ -n "Sversion" ] || return 1
	echo "$version"
}

set_default_desktop() {
	# Set default desktop, or remove if not applicable
	if [ "$DESKTOP" ]; then
		sed -i "s:%desktop%:$DESKTOP:g" boot$N/isolinux/*.cfg
	else
		sed -i "s/desktop=%desktop% //" boot$N/isolinux/*.cfg
	fi
}
