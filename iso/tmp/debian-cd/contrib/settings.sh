export TRACE=/srv/cdbuilder.debian.org/src/ftp/debian/project/trace/pettersson.debian.org
export ARCH_DI_DIR=/srv/cdbuilder.debian.org/src/deb-cd/d-i
export HOSTNAME=`hostname -f`

export PUBDIR=/srv/cdbuilder.debian.org/dst/deb-cd

export MIRROR=/srv/cdbuilder.debian.org/src/ftp/debian
export BASEDIR=~/build.stretch/debian-cd
export MKISOFS=~/build.stretch/mkisofs/usr/bin/mkisofs
if [ "$DATE"x = ""x ] ; then
    export DATE=`date -u +%Y%m%d`
fi

export EXTRACTED_SOURCES=/mnt/nfs-cdimage/cd-sources

if [ "$ARCHES"x = ""x ] ; then
    ARCHES="i386 amd64 armhf multi-arch armel source arm64 ppc64el mips mipsel mips64el s390x"
fi

if [ "$ARCHES_FIRMWARE"x = ""x ] ; then
    ARCHES_FIRMWARE="amd64 i386 multi-arch"
#    ARCHES_FIRMWARE="amd64"
fi

