#!/bin/sh

launchctl unload /Library/LaunchDaemons/com.unity3d.cacheserver.plist

rm -f /Library/LaunchDaemons/com.unity3d.cacheserver.plist
rm -rf /Library/UnityCacheServer /Library/Caches/com.unity3d.cacheserver /var/log/unitycache

dscl . -delete /Users/unitycache
dscl . -delete /Groups/unitycache
