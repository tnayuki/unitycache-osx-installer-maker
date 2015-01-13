#!/bin/sh

echo "Stopping Unity Cache Server..."
launchctl unload /Library/LaunchDaemons/com.unity3d.cacheserver.plist

echo "Uninstalling Unity Cache Server..."
rm -f /Library/LaunchDaemons/com.unity3d.cacheserver.plist
rm -rf /Library/UnityCacheServer /Library/Caches/com.unity3d.cacheserver5 /Library/Caches/com.unity3d.cacheserver /var/log/unitycache

echo "Deleting user for Unity Cache Server..."
dscl . -delete /Users/unitycache

echo "Deleting group for Unity Cache Server..."
dscl . -delete /Groups/unitycache
