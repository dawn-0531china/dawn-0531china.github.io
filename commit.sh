#!/bin/bash

echo '切换到上一级目录\n'
cd ..

# 解决使用git add命令时报错LF will be replaced by CRLF的问题
echo '执行命令：git config auto.crlf true\n'
git config auto.crlf true

# 保存所有的修改
echo '执行命令：git add -A\n'
git add -A

# 把修改的文件提交
echo "执行命令：git commit -m 'update gitbook'\n"
git commit -m 'update gitbook'

# 将本地仓库推送至远程仓库
echo '执行命令：git push origin master\n'
git push origin master

# 返回到上一次的工作目录
echo "回到刚才工作目录"
cd -
