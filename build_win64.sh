#!/bin/bash
# 64 Bit Version
mkdir -p window/x86_64
luacdir="lua54"
luapath=$luacdir
lualibname="liblua"
outpath="Plugins54"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd $DIR/$luapath
mingw32-make clean

mingw32-make mingw BUILDMODE=static CC="gcc -m64 -std=gnu99"

cp src/$lualibname.a ../window/x86_64/$lualibname.a
mingw32-make clean

cd ..

gcc -m64 -O2 -std=gnu99 -shared \
    tolua.c \
    int64.c \
    uint64.c \
    pb.c \
    lpeg/lpcap.c \
    lpeg/lpcode.c \
    lpeg/lpprint.c \
    lpeg/lptree.c \
    lpeg/lpvm.c \
    struct.c \
    cjson/strbuf.c \
    cjson/lua_cjson.c \
    cjson/fpconv.c \
    luasocket/auxiliar.c \
    luasocket/buffer.c \
    luasocket/except.c \
    luasocket/inet.c \
    luasocket/io.c \
    luasocket/luasocket.c \
    luasocket/mime.c \
    luasocket/options.c \
    luasocket/select.c \
    luasocket/tcp.c \
    luasocket/timeout.c \
    luasocket/udp.c \
    luasocket/wsocket.c \
    luasocket/compat.c \
    -o $outpath/x86_64/tolua.dll \
    -I./ \
    -I$luapath/src \
    -Icjson \
    -Iluasocket \
    -Ilpeg \
    -lws2_32 \
    -Wl,--whole-archive window/x86_64/$lualibname.a -Wl,--no-whole-archive -static-libgcc -static-libstdc++

echo "build tolua.dll success"