#!/bin/bash
# 简单的预览脚本

# 获取剪切板内容列表
selection=$(cliphist list | wofi --dmenu -p "Clipboard" -i)

# 如果选中了内容
if [ -n "$selection" ]; then
    # 如果是图片类型（通过cliphist检查内容类型）
    if [[ $selection == *"image/png"* ]] || [[ $selection == *"image/jpeg"* ]]; then
        echo "$selection" | cliphist decode | imv -
    else
        # 文本类型
        echo "$selection" | cliphist decode | wofi --dmenu -p "Text"
    fi
fi
