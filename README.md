##   filestorm矿软快速入门
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

- 3 右键右下角docker小图标,查看是否是 Switch to Windows containers 如果不是点击 Switch to Linux containers  

    ####或者
    win + r 输入 cmd,回车后输入以下命令(如自定义安装进入安装路劲)  
            cd \Program Files\Docker\Docker  
            回车后输入:
            dockercli -SwitchDaemon 
- 4 下载node.sh, 点击浏览器右上角 Clone or download,选择Download ZIP,下载解压后执行node.sh文件

- 5 无法执行.sh文件,先下载git,官网 https://www.git-scm.com/download/win,或360软件搜索git,安装git

- 6 如遇到无法打印日志问题: win+r ,回车后输入:
    > docker logs filestorm_storm

##   filestorm矿软快速入门--api
- 1 获取矿软信息
    > POST    http://xxx.xxx.xxx.xxx:80/mill/getNodeInfo  
             
      返回示例:   
        {
            "msg": "success",
            "code": 0,
            "data": {
                "privatekey": "xxx",
                "available_ram": "50G",
                "address": "xxxx",
                "nodeId": "0W0VATF9B9EMGD09AMN919UGB7BMV9RWHQR784XER9Q1DUKMFRFYGAWWIRHHGT9WOJXUAA8QQUORZJM2TLGZM1PPPDPU0CVQ5ZQRK7OLB2M875PZJCX97653MDIK1QHM757c942ddcb84706a74492fdb60696351587450409217",
                "status": "1"
            }
        }
- 2 上传文件
    > POST    http://xxx.xxx.xx.xxx:80/mill/addFile  
      参数字段:  privateKey  私钥  
          &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;  multipartFile  上传文件  
           
           返回示例:   
               {
                   "msg": "success",
                   "code": 0,
                   "data": "QmRav7jGxW8j5n1Yiy22qTosHdW2E9rTpirMBx5J5X56g6"
               }
               
 - 3 get
    > POST  http://xxx.xxx.xxx.xxx:80/mill/get  
         参数字段:  privateKey  私钥  
                &#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;  hash  文件hash  
                 
                 返回示例:   
                 {
                     "msg": "success",
                     "code": 0,
                     "data": "UW1SYXY3akd4VzhqNW4xWWl5MjJxVG9zSGRXMkU5clRwaXJNQng1SjVYNTZnNgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADAwMDA2NDQAMDAwMDAwMAAwMDAwMDAwADAwMDAwMDM1MTAxADEzNjUwMjAzNDAyADAxNjczMgAgMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB1c3RhcgAwMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAwMDAwMDAwADAwMDAwMDAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/2P/gABBKRklGAAEBAAABAAEAAP/bAEMAAwICAwICAwMDAwQDAwQFCAUFBAQFCgcHBggMCgwMCwoLCw0OEhANDhEOCwsQFhARExQVFRUMDxcYFhQYEhQVFP/bAEMBAwQEBQQFCQUFCRQNCw0UFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFP/AABEIASwA1wMBIgACEQEDEQH/xAAfAAABBQEBAQEBAQAAAAAAAAAAAQIDBAUGBwgJCgv/xAC1EAACAQMDAgQDBQUEBAAAAX0BAgMABBEFEiExQQYTUWEHInEUMoGRoQgjQrHBFVLR8CQzYnKCCQoWFxgZGiUmJygpKjQ1Njc4OTpDREVGR0hJSlNUVVZXWFlaY2RlZmdoaWpzdHV2d3h5eoOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4eLj5OXm5+jp6vHy8/T19vf4+fr/xAAfAQADAQEBAQEBAQEBAAAAAAAAAQIDBAUGBwgJCgv/"  
                     }
                     
                     
