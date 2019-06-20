# Functions to convert isolinux config to allow selection of desktop
# environment for certain images.

di_syslinux_version() {
	local version
	version=$(sed -nr "s/^# D-I config version ([0-9.])/\1/p" \
		boot$N/isolinux/isolinux.cfg)

	[ -n "Sversion" ] || return 1
	echo "$version"
}

# Workaround for #505243
# Syslinux does not correctly handle a default64 option in combination
# with vesamenu. Instead, add special default label to automatically
# select i386/amd64 if user hits enter from help screens.
multiarch_workaround() {
	if [ -f $CDDIR/../syslinux/usr/lib/syslinux/modules/bios/ifcpu64.c32 ] ; then
		cp -f $CDDIR/../syslinux/usr/lib/syslinux/modules/bios/ifcpu64.c32 boot$N/isolinux/
	else
		cp -f $CDDIR/../syslinux/usr/lib/syslinux/ifcpu64.c32 boot$N/isolinux/
	fi
	sed -i "/^default install/ s/^/#/" \
		boot$N/isolinux/txt.cfg || true
	sed -i "/^default64 amd64-install/ s/^/#/" \
		boot$N/isolinux/amdtxt.cfg || true
	sed -i "/^include menu.cfg/ a\include instsel.cfg" \
		boot$N/isolinux/prompt.cfg
	cat >boot$N/isolinux/instsel.cfg <<EOF
default install-select
label install-select
    kernel ifcpu64.c32
    append amd64-install -- install
EOF
}

set_default_desktop() {
	# Set default desktop, or remove if not applicable
	if [ "$DESKTOP" ]; then
		sed -i "s:%desktop%:$DESKTOP:g" boot$N/isolinux/*.cfg
	else
		sed -i "s/desktop=%desktop% //" boot$N/isolinux/*.cfg
	fi
}
