#
#   goahead-windows-static.sh -- Build It Shell Script to build Embedthis GoAhead
#

export PATH="$(SDK)/Bin:$(VS)/VC/Bin:$(VS)/Common7/IDE:$(VS)/Common7/Tools:$(VS)/SDK/v3.5/bin:$(VS)/VC/VCPackages;$(PATH)"
export INCLUDE="$(INCLUDE);$(SDK)/Include:$(VS)/VC/INCLUDE"
export LIB="$(LIB);$(SDK)/Lib:$(VS)/VC/lib"

PRODUCT="goahead"
VERSION="3.1.0"
BUILD_NUMBER="1"
PROFILE="static"
ARCH="x86"
ARCH="`uname -m | sed 's/i.86/x86/;s/x86_64/x64/;s/arm.*/arm/;s/mips.*/mips/'`"
OS="windows"
CONFIG="${OS}-${ARCH}-${PROFILE}"
CC="cl.exe"
LD="link.exe"
CFLAGS="-nologo -GR- -W3 -O2 -MD -w"
DFLAGS="-D_REENTRANT -D_MT"
IFLAGS="-I${CONFIG}/inc"
LDFLAGS="-nologo -nodefaultlib -incremental:no -machine:x86"
LIBPATHS="-libpath:${CONFIG}/bin"
LIBS="ws2_32.lib advapi32.lib user32.lib kernel32.lib oldnames.lib msvcrt.lib shell32.lib"

[ ! -x ${CONFIG}/inc ] && mkdir -p ${CONFIG}/inc ${CONFIG}/obj ${CONFIG}/lib ${CONFIG}/bin

[ ! -f ${CONFIG}/inc/bit.h ] && cp projects/goahead-${OS}-${PROFILE}-bit.h ${CONFIG}/inc/bit.h
[ ! -f ${CONFIG}/inc/bitos.h ] && cp ${SRC}/src/bitos.h ${CONFIG}/inc/bitos.h
if ! diff ${CONFIG}/inc/bit.h projects/goahead-${OS}-${PROFILE}-bit.h >/dev/null ; then
	cp projects/goahead-${OS}-${PROFILE}-bit.h ${CONFIG}/inc/bit.h
fi

rm -rf ${CONFIG}/inc/bitos.h
cp -r src/bitos.h ${CONFIG}/inc/bitos.h

rm -rf ${CONFIG}/inc/est.h
cp -r src/deps/est/est.h ${CONFIG}/inc/est.h

"${CC}" -c -Fo${CONFIG}/obj/estLib.obj -Fd${CONFIG}/obj/estLib.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/deps/est/estLib.c

"lib.exe" -nologo -out:${CONFIG}/bin/libest.lib ${CONFIG}/obj/estLib.obj

rm -rf ${CONFIG}/bin/ca.crt
cp -r src/deps/est/ca.crt ${CONFIG}/bin/ca.crt

rm -rf ${CONFIG}/inc/goahead.h
cp -r src/goahead.h ${CONFIG}/inc/goahead.h

rm -rf ${CONFIG}/inc/js.h
cp -r src/js.h ${CONFIG}/inc/js.h

"${CC}" -c -Fo${CONFIG}/obj/action.obj -Fd${CONFIG}/obj/action.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/action.c

"${CC}" -c -Fo${CONFIG}/obj/alloc.obj -Fd${CONFIG}/obj/alloc.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/alloc.c

"${CC}" -c -Fo${CONFIG}/obj/auth.obj -Fd${CONFIG}/obj/auth.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/auth.c

"${CC}" -c -Fo${CONFIG}/obj/cgi.obj -Fd${CONFIG}/obj/cgi.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/cgi.c

"${CC}" -c -Fo${CONFIG}/obj/crypt.obj -Fd${CONFIG}/obj/crypt.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/crypt.c

"${CC}" -c -Fo${CONFIG}/obj/file.obj -Fd${CONFIG}/obj/file.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/file.c

"${CC}" -c -Fo${CONFIG}/obj/fs.obj -Fd${CONFIG}/obj/fs.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/fs.c

"${CC}" -c -Fo${CONFIG}/obj/http.obj -Fd${CONFIG}/obj/http.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/http.c

"${CC}" -c -Fo${CONFIG}/obj/js.obj -Fd${CONFIG}/obj/js.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/js.c

"${CC}" -c -Fo${CONFIG}/obj/jst.obj -Fd${CONFIG}/obj/jst.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/jst.c

"${CC}" -c -Fo${CONFIG}/obj/options.obj -Fd${CONFIG}/obj/options.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/options.c

"${CC}" -c -Fo${CONFIG}/obj/osdep.obj -Fd${CONFIG}/obj/osdep.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/osdep.c

"${CC}" -c -Fo${CONFIG}/obj/rom-documents.obj -Fd${CONFIG}/obj/rom-documents.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/rom-documents.c

"${CC}" -c -Fo${CONFIG}/obj/route.obj -Fd${CONFIG}/obj/route.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/route.c

"${CC}" -c -Fo${CONFIG}/obj/runtime.obj -Fd${CONFIG}/obj/runtime.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/runtime.c

"${CC}" -c -Fo${CONFIG}/obj/socket.obj -Fd${CONFIG}/obj/socket.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/socket.c

"${CC}" -c -Fo${CONFIG}/obj/upload.obj -Fd${CONFIG}/obj/upload.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/upload.c

"${CC}" -c -Fo${CONFIG}/obj/est.obj -Fd${CONFIG}/obj/est.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/ssl/est.c

"${CC}" -c -Fo${CONFIG}/obj/matrixssl.obj -Fd${CONFIG}/obj/matrixssl.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/ssl/matrixssl.c

"${CC}" -c -Fo${CONFIG}/obj/openssl.obj -Fd${CONFIG}/obj/openssl.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc -Isrc/deps/est src/ssl/openssl.c

"lib.exe" -nologo -out:${CONFIG}/bin/libgo.lib ${CONFIG}/obj/action.obj ${CONFIG}/obj/alloc.obj ${CONFIG}/obj/auth.obj ${CONFIG}/obj/cgi.obj ${CONFIG}/obj/crypt.obj ${CONFIG}/obj/file.obj ${CONFIG}/obj/fs.obj ${CONFIG}/obj/http.obj ${CONFIG}/obj/js.obj ${CONFIG}/obj/jst.obj ${CONFIG}/obj/options.obj ${CONFIG}/obj/osdep.obj ${CONFIG}/obj/rom-documents.obj ${CONFIG}/obj/route.obj ${CONFIG}/obj/runtime.obj ${CONFIG}/obj/socket.obj ${CONFIG}/obj/upload.obj ${CONFIG}/obj/est.obj ${CONFIG}/obj/matrixssl.obj ${CONFIG}/obj/openssl.obj

"${CC}" -c -Fo${CONFIG}/obj/goahead.obj -Fd${CONFIG}/obj/goahead.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc src/goahead.c

"${LD}" -out:${CONFIG}/bin/goahead.exe -entry:mainCRTStartup -subsystem:console ${LDFLAGS} ${LIBPATHS} ${CONFIG}/obj/goahead.obj libgo.lib ${LIBS} libest.lib

"${CC}" -c -Fo${CONFIG}/obj/test.obj -Fd${CONFIG}/obj/test.pdb ${CFLAGS} ${DFLAGS} -I${CONFIG}/inc test/test.c

"${LD}" -out:${CONFIG}/bin/goahead-test.exe -entry:mainCRTStartup -subsystem:console ${LDFLAGS} ${LIBPATHS} ${CONFIG}/obj/test.obj libgo.lib ${LIBS} libest.lib

#  Omit build script undefined