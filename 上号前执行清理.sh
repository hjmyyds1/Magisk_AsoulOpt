iptables -F
iptables -X 
iptables -Z
iptables -t nat -F 
echo "本地缓存数据处理成功"
#清楚iptables规则
iptables -F
echo "iptables规则清除成功"
ip6tables=/system/bin/ip6tables
iptables=/system/bin/iptables
#和平清除down
rm -rf /data/data/com.tencent.tmgp.pubgmhd/files/ano_tmp
rm -rf /data/user/0/com.tencent.tmgp.pubgmhd/files/ano_tmp
#暗区清除down
rm -rf /data/data/com.tencent.mf.uam/files/ano_tmp/
rm -rf /data/user/0/com.tencent.mf.uam/files/ano_tmp/
#使命清除down
rm -rf /data/data/com.tencent.tmgp.cod/files/ano_tmp
rm -rf /data/user/0/com.tencent.tmgp.cod/files/ano_tmp
#王者清除down
rm -rf /data/data/com.tencent.tmgp.sgame/files/ano_tmp
rm -rf /data/user/0/com.tencent.tmgp.sgame/files/ano_tmp
#CFM清除down
rm -rf /data/data/com.tencent.tmgp.cf/files/ano_tmp
rm -rf /data/user/0/com.tencent.tmgp.cf/files/ano_tmp
#三角洲清除down
rm -rf /data/data/com.tencent.tmgp.dfm/files/ano_tmp
rm -rf /data/user/0/com.tencent.tmgp.dfm/files/ano_tmp
#修复第三方环境异常
echo 16384 > /proc/sys/fs/inotify/max_queued_events
echo 128 > /proc/sys/fs/inotify/max_user_instances
echo 8192 > /proc/sys/fs/inotify/max_user_watches
#清除王者荣耀日志
echo "缓存数据清理完成"