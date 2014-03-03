#!/bin/bash

if [ $# -ne 1 ]; then
  echo "ERROR: URL not specified."
  exit 1
fi

rm -rf build && mkdir build

echo 'Downloading Unity Cache Server...'
curl -s -f --url $1 -o build/CacheServer.zip

if [ "$?" -ne 0 ] ; then
   echo "ERROR: Download failed."
   exit 1
fi

echo 'Making Unity Cache Server installer...'

unzip -q build/CacheServer.zip -d build

mkdir -p build/root/Library/LaunchDaemons
mv build/CacheServer build/root/Library/UnityCacheServer
cp -p Uninstall.sh build/root/Library/UnityCacheServer
cp -p com.unity3d.cacheserver.plist build/root/Library/LaunchDaemons

pkgbuild --identifier com.unity3d.cacheserver --root build/root build/CacheServer.pkg --install-location / --scripts scripts

productbuild --distribution Distribution.xml --package-path build build/UnityCacheServer.pkg
