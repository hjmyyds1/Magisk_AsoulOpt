#领域展开 tg:anbainb66



rm -rf /data/user/0/com.proximabeta.mf.uamo/*


rm -Rf /data/miuilog/stability/scout/app/*

rm -Rf /storage/emulated/0/Android/data/com.tsng.hidemyapplist
rm -Rf /storage/emulated/0/Android/obb/com.tsng.hidemyapplist

data_UAM=/data/user/0/com.proximabeta.mf.uamo
sdcard_UAM=/storage/emulated/0/Android/data/com.proximabeta.mf.uamo
uedir_UAM=/storage/emulated/0/Android/data/com.proximabeta.mf.uamo/files/UE4Game/UAGame/UAGame/Saved

rm -rf /storage/emulated/0/Android/data/com.proximabeta.mf.uamo/cache

rm -Rf /data/user_de/0/com.proximabeta.mf.uamo/code_cache/*
rm -Rf $data_UAM/*

rm -rf /storage/emulated/0/Android/data/com.proximabeta.mf.uamo/files/UE4Game/UAGame/NotAllowedUnattendedBugReports

rm -rf /storage/emulated/0/Android/data/com.proximabeta.mf.uamo/files/UE4Game/UAGame/Manifest_UFSFiles_Android.txt

echo -e "\033[32m正在遍历内部存储\033[0m"

# 
log_keywords=("Logs" "centauri" "TGPA" "cache" "log" "debug" "errorlog" "gamelog")

# 用于存储被认为是日志文件的文件路径
log_files=()
# 用于存储被认为是日志文件夹的文件夹路径
log_folders=()

function process_directory() {
    local dir="$1"
    # 判断文件夹
    folder_name=$(basename "$dir")
    is_folder_log=false
    for keyword in "${log_keywords[@]}"; do
        if [[ $folder_name == *"$keyword"* ]]; then
            is_folder_log=true
            break
        fi
    done

    # 
    if $is_folder_log; then
        echo -e "\033[32m该文件夹可能是存储日志的文件夹，继续遍历：$dir\033[0m"
        log_folders+=("$dir")
    fi

    local total_files=$(find "$dir" -maxdepth 1 -type f | wc -l)
    local processed_files=0
    for file in "$dir"/*; do
        if [[ -f $file ]]; then
            filename=$(basename "$file")
            is_log=false
            for keyword in "${log_keywords[@]}"; do
                if [[ $filename == *"$keyword"* ]]; then
                    is_log=true
                    break
                fi
            done
            if $is_log; then
                echo -e "\033[35m$file 被判断为可能是残留日志文件\033[0m"
                log_files+=("$file")
            else
                echo -e "\033[31m$file 不太可能是残留日志文件\033[0m"
            fi
            ((processed_files++))
            progress=$((processed_files * 100 / total_files))
            echo -ne "Progress: [${progress}%]\r"
        elif [[ -d $file ]]; then
            echo -e "\033[32m正在遍历子文件夹：$file\033[0m"
            process_directory "$file"
        fi
    done
    echo -e "\nProgress: [100%]"
}

process_directory "/storage/emulated/0/Android/data/com.proximabeta.mf.uamo"

# 
echo -e "\n\033[33m以下是过滤后的文件，可能是残留日志文件:\033[0m"
for file in "${log_files[@]}"; do
    echo "$file"
done

# 
echo -e "\n\033[33m以下是过滤后的文件夹，可能是存储日志的文件夹:\033[0m"
for folder in "${log_folders[@]}"; do
    echo "$folder"
done

# 
echo "是否确认删除这些可能是残留日志的文件和文件夹? (y/n)"
read confirm

if [[ $confirm == [yY] ]]; then
    echo -e "\n\033[33m开始删除标记为残留日志的文件和文件夹...\033[0m"
    for file in "${log_files[@]}"; do
        if rm -f "$file"; then
            echo "已删除: $file"
        else
            echo "删除失败: $file"
        fi
    done
    for folder in "${log_folders[@]}"; do
        if rm -rf "$folder"; then
            echo "已删除: $folder"
        else
            echo "删除失败: $folder"
        fi
    done
    echo -e "\n所有标记为残留日志的文件和文件夹已被删除。"
else
    echo -e "\n未执行删除操作。"
fi
