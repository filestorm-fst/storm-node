##   filestorm矿软使用教程
- 1  下载安装docker服务
     1. `卸载旧版本(如果安装的有docker)`
        > sudo yum remove docker  docker-common docker-selinux dockesr-engine  
     2. `安装docker`  
        > sudo yum install docker-ce  
     3. `启动docker并加入开机启动`
         > sudo systemctl start docker  
           sudo systemctl enable docker  
     4. `验证是否安装成功(有client和service两部分表示docker安装启动都成功了)`
        > docker version  
       
- 2  下载node.sh 脚本文件 
     1. 进入下载路劲,为node.sh 赋予权限  
        > chmod 0755 node.sh
     2. 执行node.sh  
        >./node.sh
     3. 脚本无法执行,编码格式问题
        > yum install dos2unix  
         dos2unix node.sh
     4. 执行成功,启动成功. (如未打印日志,可执行以下命令查看日志)  
        > docker logs filestorm_storm
- 3  node.sh运行说明
     1. 停止docker中所有运行容器(可选择弃用)   
        > docker stop $(docker ps -aq) 
     2. 删除docker中所有容器(可选择弃用)
        > docker rm $(docker ps -aq)  
     3. 删除docker中所有未运行的容器镜像                              
        > docker system prune -a -f --volumes
     4. 拉取filestorm_node 镜像
        > docker pull registry.cn-shenzhen.aliyuncs.com/stormchain/node:v1.0                                                           
     5. 拉取filestorm_fstorm 镜像
        >  docker pull ipfs/go-ipfs:latest
     6. 拉取filestorm_storm 镜像
        >  docker pull registry.cn-shenzhen.aliyuncs.com/stormchain/storm:v1.0  
     7. 后台运行拉取镜像镜像
- 4  停止容器运行  
     1. 停止filestorm_node  (同步节点)  
        > docker stop filestorm_node
     2. 停止 filestorm_storm(矿软)
        > docker stop filestorm_storm
- 5  启动已有容器  
     1. 启动filestorm_node  (同步节点)  
        > docker start filestorm_node                               
     2. 启动filestorm_storm(矿软)
        > docker start filestorm_storm
- 6  查看容器日志
    > docker logs filestorm_node
- 7  进入容器
    > docker exec -it filestorm_node /bin/sh
## windows 下载安装docker
- 1 官网下载docker
    > https://hub.docker.com/editions/community/docker-ce-desktop-windows?tab=resources  
    1. 点击 `get docker`
- 2 点击Docker Desktop Installer.exe 安装

- 3 安装完成后 ctrl + r 输入 cmd,输入以下命令  
    > cd \Program Files\Docker\Docker
    1. 进入 \Program Files\Docker\Docker 路劲后输入:
     > dockercli -SwitchDaemon  
- 4 下载node.sh 点击右上角 Clone or download,选择Download ZIP,下载解压后执行node.sh文件
