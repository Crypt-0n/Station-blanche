# This file provides some common code that is intented to be called
# by the various boot-<arch> scripts.

# Make sure that sbin directories are on the PATH too - filesystem
# creation tools are often hidden there
PATH=/sbin:/usr/sbin:$PATH
export PATH

# Expand %ARCH% variable in envvars for location of D-I images
DI_WWW_HOME="$(echo "$DI_WWW_HOME" | sed -e "s|%ARCH%|$ARCH|g")"
DI_DIR="$(echo "$DI_DIR" | sed -e "s|%ARCH%|$ARCH|g")"

# Make sure that DI_DIST is set to something sane
if [ ! "$DI_DIST" ]; then
    DI_DIST="$DI_CODENAME"
fi

# Find out what the default desktop is in tasksel if we've not set it
# (i.e. using "all" for netinst, DVD etc.) - print the name of the
# first desktop task recommended by task-desktop
UNSPEC_DESKTOP_DEFAULT="$($BASEDIR/tools/apt-selection cache depends task-desktop | \
    awk '
    /Recommends:.*desktop/ {
        gsub("task-","")
        gsub("-desktop","")
        print $2
        exit
    }')"

# Only i386 and amd64 use DESKTOP to set the default desktop;
# make sure other arches get a working config
if [ "$ARCH" != i386 ] && [ "$ARCH" != amd64 ]; then
    if [ "$DESKTOP" = all ] || [ "$DESKTOP" = "$UNSPEC_DESKTOP_DEFAULT" ] ; then
        DESKTOP=
        KERNEL_PARAMS="$(echo "$KERNEL_PARAMS" | \
                sed -r "s/desktop=[^ ]* ?//")"
    elif [ "$DESKTOP" = light ] ; then
        DESKTOP=xfce
        KERNEL_PARAMS="$(echo "$KERNEL_PARAMS" | \
                sed -r "s/(desktop=)light/\1xfce/")"
    fi
fi


# install_languages decompacts the language packs, you should give the path
# to the CD temporary tree.
# This function should be called for all bootable images.
install_languages() {
    # Param $1 is the CD directory
    if [ -f "$MIRROR/dists/$DI_CODENAME/main/disks-$ARCH/current/xlp.tgz" ]
    then
	mkdir $1/.xlp
	(cd $1/.xlp; \
	tar zxf $MIRROR/dists/$DI_CODENAME/main/disks-$ARCH/current/xlp.tgz )
    fi
}

# Add an option to the mkisofs options for this CD _only_ if it's not
# already set. $1 is the opts file location, "$2" is the new
# option. Call this with _logical groupings_ of options
add_mkisofs_opt() {
   OPTS_FILE=$1
   NEW_OPT="$2"

   if ! ( grep -q -- "$NEW_OPT" $OPTS_FILE 2>/dev/null) ; then
       echo -n "$NEW_OPT " >> $OPTS_FILE
   fi
}

variant_enabled() {
    VARIANT=$1

    echo "$VARIANTS" | grep -qw "$VARIANT"
    return $?
}

# Wrapper around which_deb which looks in all relevant distributions
find_pkg_file() {
    local pkgfile
    for dist in $DI_CODENAME $CODENAME; do
        pkgfile=$($BASEDIR/tools/which_deb $MIRROR $dist "$@")
        [ -n "$pkgfile" ] && break
    done
    if [ -z "$pkgfile" ]; then
        echo "WARNING: unable to find the $@ package in $DI_CODENAME or $CODENAME distribution of the mirror" >&2
    fi
    echo $pkgfile
}

# Work out the right boot load size for a specified file
calc_boot_size() {
    FILE=$1

    size=$[($(stat -c%s "$FILE")+2047)/2048]
    echo $size
}

# If we're looking for an image location to download, see if it's in a
# local cache first.
try_di_image_cache() {
    DI_TMP_DIR=${DI_WWW_HOME#*http://}
    if [ -n "$DI_DIR" ] && [ -e "${DI_DIR}/${DI_TMP_DIR}" ] ; then
        DI_DIR="$DI_DIR/${DI_TMP_DIR}"
        DI_WWW_HOME=""
        echo "Using images from local cache: $DI_DIR"
    else
	# If not, we'll end up downloading. Complain if the download
	# link looks insecure (i.e. not https). May cause builds to
	# fail here in future...
        case "$DI_WWW_HOME"x in
	    "http://"*x|"ftp://"*x)
		echo "WARNING WARNING WARNING WARNING WARNING WARNING"
		echo "$0: insecure download for d-i build: $DI_WWW_HOME"
		echo "WARNING WARNING WARNING WARNING WARNING WARNING"
		;;
	esac
    fi
}

# Grab the xorriso version and turn it into a number we can use
xorriso_version() {
    $MKISOFS --version 2>&1 | awk '
	/^xorriso version/ {
	    split($4, ver, ".")
	    print ver[1]*10000+ver[2]*100+ver[3]
	}'
}
