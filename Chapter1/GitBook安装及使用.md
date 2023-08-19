# 第二节：Gitbook安装及使用

##### 1、Gitbook本地安装

###### 1.1、安装node

由于Gitbook是基于node.js的，并且支持的node版本比较老，所以要安装指定版本的node。

[MacOS Node版本管理](MacOS Node版本管理.md)

```shell
# 安装指定版本node
nvm install ***
```

###### 1.2、安装gitbook-cli工具

```shell
# 切换能够支持gitbook的node版本
nvm use 10.21.0

# 通过nmp安装gitboo-cli
npm install -g gitbook-cli

# 查看gitbook的版本，验证是否安装成功
gitbook --version
```

###### 1.3、安装Typora

安装Typora用于编辑markdown

Typora下载地址：[https://www.typora.io/](https://www.typora.io/)

##### 2、Gitbook本地使用

###### 2.1、初始化gitbook

新建一个文件夹，cd到这个文件夹下，通过gitbook init命令进行初始化。

```shell
cd ***

gitbook init
```

执行玩命令后，可在文件夹下看到两个文件：

```text
README.md —— 书籍的介绍写在这个文件里
SUMMARY.md —— 书籍的目录结构在这里配置
```

###### 2.2、编辑SUMMARY.md

通过Typora编辑SUMMARY.md文件，结构如下：

```text
# 目录

- [前言](README.md)
- [第一章](Chapter1/***.md)
  - [第1节：***](Chapter1/***.md)
  - [第2节：***](Chapter1/***.md)
  - [第3节：***](Chapter1/***.md)
  - [第4节：***](Chapter1/***.md)
- [第二章](Chapter2/***.md)
- [第三章](Chapter3/***.md)
```

###### 2.3、本地部署

回到命令终端，重新执行`gitbook init`命令，GitBook 会查找 SUMMARY.md 文件中描述的目录和文件，如果没有则会将其创建。

执行 `gitbook serve` 命令，将其部署在本地，打开浏览器 访问：http://localhost:4000/，即可看到本地部署的 Gitbook（注：serve 命令可以指定端口 `gitbook serve --port 2333`） 

执行 `gitbook build` 命令构建书籍，默认将生成的静态网站输出到 _book 目录。这一步也包含在 `gitbook serve` 里面（注：build 命令可以指定路径 `gitbook build [书籍路径] [输出路径]`，如果你想查看输出目录详细的记录，可使用 `gitbook build ./ --log=debug --debug` 来查看)

##### 3、托管到Github Page

###### 3.1、本地项目提交到Github

在GitHub上创建一个仓库，将本地文件夹通过`git init`命令初始化为git仓库，配置本地git仓库远端仓库为GitHub上创建的仓库。编辑`.gitignore`文件，忽略_book文件夹。

```text
* 忽略_book文件夹
_book
```

然后将本地仓库推送到远端仓库。可以创建提交脚本，方便后续使用：

```shell
#!/bin/bash

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
```

###### 3.2、将构建的书籍上传到GitHub的gh-pages分支

将构建出来的_book推送到gh-pages分支

```shell
#!/bin/bash

# 构建Gitbook
echo '执行命令：gitbook build .'
gitbook build .

# 进入生成的文件夹
echo "执行命令：cd ./_book\n"
cd ./_book

# 初始化一个仓库，仅仅是做了一个初始化的操作，项目里的文件还没有被跟踪
echo "执行命令：git init\n"
git init

# 解决使用git add命令时报错LF will be replaced by CRLF的问题
echo '执行命令：git config auto.crlf true\n'
git config auto.crlf true

# 保存所有的修改
echo "执行命令：git add -A"
git add -A

# 把修改的文件提交
echo "执行命令：commit -m 'deploy gitbook'"
git commit -m 'deploy gitbook'

# 发布到 https://<USERNAME>.github.io/<REPO>, 注意替换仓库地址
echo "执行命令：git push -f 仓库地址.git main:gh-pages"
git push -f 仓库地址.git main:gh-pages

# 返回到上一次的工作目录
echo "回到刚才工作目录"
cd -
```

执行成功后，打开 github 仓库，选择 `branch` 分支，会发现多了一个 `gh-pages` 分支，打开这个分之后，里面会有一个 `index.html` 文件，说明部署的代码上传成功了。

打开github仓库的setting，在Pages，在Build and deployment中选择部署分支为gh-pages，打开自己的GitHub Pages链接，就可以看到自己构建的书籍。
