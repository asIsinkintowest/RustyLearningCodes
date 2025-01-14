#!/bin/bash

# 获取脚本所在目录（模板和脚本在同一目录）
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# 检查是否提供了项目名称
if [ -z "$1" ]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

# 输入项目名称
PROJECT_NAME=$1

# 定义模板路径
TEMPLATE_DIR="$SCRIPT_DIR/template" 

# 检查模板目录是否存在
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "Error: Template directory $TEMPLATE_DIR does not exist."
    exit 1
fi

# 创建项目目录
PROJECT_DIR=$(pwd)/$PROJECT_NAME
if [ -d "$PROJECT_DIR" ]; then
    echo "Error: Project Directory $PROJECT_DIR Already Exists."
    exit 1
fi

echo "Creating New Project: $PROJECT_DIR"
mkdir "$PROJECT_DIR"

# 拷贝模板内容到新项目目录
echo "Copying template to $PROJECT_DIR"
cp -r "$TEMPLATE_DIR/"* "$PROJECT_DIR/"

# 切换到项目目录
cd "$PROJECT_DIR" || exit

# 确保 build.sh 存在并可执行
if [ ! -f "./build.sh" ]; then
    echo "Error: build.sh not found in $PROJECT_DIR."
    exit 1
fi

chmod +x ./build.sh

# 执行 build.sh
echo "Executing build.sh..."
if ./build.sh; then
    echo "Project $PROJECT_NAME created and built successfully!"
else
    echo "Failed to build project $PROJECT_NAME."
    exit 1
fi
