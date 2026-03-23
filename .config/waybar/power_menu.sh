#!/bin/bash
# 弹出菜单让用户选择
choice=$(echo -e "🛑 关机\n🔄 重启\n💤 睡眠\n🔒 锁屏" | wofi --dmenu --prompt "电源操作")

case $choice in
    *"关机") shutdown now ;;
    *"重启") reboot ;;
    *"睡眠") systemctl suspend ;;
    *"锁屏") hyprlock ;; # 或者 loginctl lock-session
esac
