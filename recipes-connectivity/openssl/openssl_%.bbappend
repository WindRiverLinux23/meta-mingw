FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:mingw32:class-nativesdk = " \
           file://0001-unix-Makefile.tmpl-don-t-add-prefix-for-libdir.patch \
"

do_configure:mingw32 () {
	os=${HOST_OS}
	target="$os-${HOST_ARCH}"
	case $target in
        mingw32-x86_64)
                target=mingw64
                ;;
        mingw32-i686)
                target=mingw
                ;;
        esac

        useprefix=${prefix}
        if [ "x$useprefix" = "x" ]; then
                useprefix=/
        fi
        # WARNING: do not set compiler/linker flags (-I/-D etc.) in EXTRA_OECONF, as they will fully replace the
        # environment variables set by bitbake. Adjust the environment variables instead.
        HASHBANGPERL="/usr/bin/env perl" PERL=perl PERL5LIB="${S}/external/perl/Text-Template-1.46/lib/" \
        perl ${S}/Configure ${EXTRA_OECONF} ${PACKAGECONFIG_CONFARGS} --prefix=$useprefix --openssldir=${libdir}/ssl-1.1 --libdir=${libdir} $target
        perl ${B}/configdata.pm --dump
}

FILES_${PN}-engines:mingw32:class-nativesdk = "${libdir}/engines-1_1"
RDEPENDS_${PN}-misc:remove:mingw32:class-nativesdk = "perl"
