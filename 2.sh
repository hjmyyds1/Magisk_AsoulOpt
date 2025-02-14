data_UAM=/data/user/0/com.proximabeta.mf.uamo
sdcard_UAM=/storage/emulated/0/Android/data/com.proximabeta.mf.uamo
uedir_UAM=/storage/emulated/0/Android/data/com.proximabeta.mf.uamo/files/UE4Game/UAGame/UAGame/Saved


rm -Rf /sdcard/ramdump
rm -Rf /data/user_de/0/com.proximabeta.mf.uamo/code_cache/*


rm -rf /storage/emulated/0/Android/data/org.telegram.messenger.web/*

rm -rf $data_UAM/cache/*
rm -rf $data_UAM/app_crashSight/*
rm -rf $data_UAM/files/ano_tmp/*
rm -rf $sdcard_UAM/cache/*
rm -rf $sdcard_UAM/files/tbslog/*
rm -rf $sdcard_UAM/files/tencent/*
rm -rf $uedir_UAM/Logs/*

dmesg -c >/dev/null 2>&1
logcat -c -b main -b events -b radio -b system >/dev/null 2>&1
setenforce 1