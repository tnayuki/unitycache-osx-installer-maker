#!/bin/bash

VERSION=4.3.3

while getopts v: OPT
do
  case $OPT in
    "v" ) VERSION="$OPTARG" ;;
  esac
done

UNITYCACHE_URL=http://netstorage.unity3d.com/unity/CacheServer-$VERSION.zip

rm -rf build && mkdir build

curl -f --url ${UNITYCACHE_URL} -o build/CacheServer.zip

if [ "$?" -ne 0 ] ; then
   echo "Download failed."
   exit 1
fi

unzip build/CacheServer.zip -d build

mkdir -p build/root/Library/LaunchDaemons
mv build/CacheServer build/root/Library/UnityCacheServer
cp -p com.unity3d.cacheserver.plist build/root/Library/LaunchDaemons

pkgbuild --identifier com.unity3d.cacheserver --version $VERSION --root build/root build/CacheServer.pkg --install-location / --scripts scripts

productbuild --distribution Distribution.xml --package-path build build/UnityCacheServer-$VERSION.pkg
