#! /bin/bash
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker system prune -a -f --volumes
docker network create --driver bridge --subnet=172.18.12.0/16 --gateway=172.18.1.1 mynet
if [ $? -ne 0 ]; then 
    echo $?
else
    echo "==================================create network success"
fi
docker network inspect mynet

docker pull registry.cn-shenzhen.aliyuncs.com/stormchain/node:v1.0
if [ $? -ne 0 ]; then 
   echo "==================================pull filestorm_node faild"
else
    echo "==================================pull filestorm_node success"
fi
docker pull ipfs/go-ipfs:latest

if [ $? -ne 0 ]; then 
     echo "==================================pull filestorm_fstorm faild"
else
    echo "==================================pull filestorm_fstorm success"
fi

docker pull registry.cn-shenzhen.aliyuncs.com/stormchain/storm:v2.0

if [ $? -ne 0 ]; then 
echo "==================================pull filestorm_mill faild"
else
    echo "==================================pull filestorm_mill success"
fi
 docker run -d --name filestorm_fstorm --network mynet --ip 172.18.12.1 -p 5001:5001 -p 4001:4001 -p 8080:8080 ipfs/go-ipfs:latest
if [ $? -ne 0 ]; then 
 echo "==================================run filestorm_fstorm faild"
else
    echo "==================================run filestorm_fstorm success"
fi
docker run -d --name filestorm_node --network mynet --ip 172.18.12.2 -p 30715:30715 -p 8545:8545 registry.cn-shenzhen.aliyuncs.com/stormchain/node:v1.0
if [ $? -ne 0 ]; then 
    echo "==================================run filestorm_node faild"
else
    echo "==================================run filestorm_node success"
fi

 docker run -d --name filestorm_storm --network mynet --ip 172.18.12.3 -p 80:80 registry.cn-shenzhen.aliyuncs.com/stormchain/storm:v1.0

if [ $? -ne 0 ]; then 
    echo "==================================run filestorm_mill faild"
else
    echo "==================================run filestorm_mill success"
fi

docker logs filestorm_storm
wait
echo "All is ok"
exit 0
