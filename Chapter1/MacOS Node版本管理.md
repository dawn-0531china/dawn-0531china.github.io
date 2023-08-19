# 第一节：MacOS Node版本管理

##### 1、brew的安装

```shell
# 安装brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# 查看brew版本(用于检查brew是否安装成功)
brew --version
```

##### 2、通过brew安装nvm(node version manager)

```shell
#安装nvm
brew install nvm

# 查看nvm版本
nvm --version
```

##### 3、配置.bash_profil文件

```shell
# 打开bash_profile
open ~/.bash_profile

# 将下面配置拷贝到bash_profile文件
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

#保存后执行指令
source ~/.bash_profile
```

##### 4、通过nvm安装指定node版本

```shell
# 查看可使用的node版本
nvm ls-remote

# 安装node指定版本
nvm install 10.21.0

# 使用指定版本
nvm use 10.21.0

# 设置每次启动终端使用版本
nvm alias default 20.1.0
```



