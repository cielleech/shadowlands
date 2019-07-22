# alpine-mysql

#### 项目介绍
alpine-mysql是基于alpine与mariadb生成的docker image.

#### 软件架构
docker

#### 安装教程
docker build -t cielleech/alpine-mysql .

#### 使用说明

docker run -it --name mysql -p 3306:3306 -e MYSQL_DATABASE=zto -e MYSQL_USER=zto -e MYSQL_PASSWORD=zto123 -e MYSQL_ROOT_PASSWORD=zto123 cielleech/alpine-mysql