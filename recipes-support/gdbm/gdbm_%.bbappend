FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:mingw32:class-nativesdk = " \
           file://gdbm-1.23-win32.patch \                                                                                                                                                                                                   
"
LDFLAGS:append:mingw32:class-nativesdk = " -lws2_32"

