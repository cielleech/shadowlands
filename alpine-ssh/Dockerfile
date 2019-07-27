# 设置继承镜像
FROM alpine:latest
# 提供一些作者的信息
MAINTAINER cielleech (cielleech@qq.com)
# 下面开始运行更新命令
RUN apk update
RUN apk add --no-cache openssh-server
RUN ssh-keygen -A
RUN sed -ri 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN echo 'root:vox123' | chpasswd
#开放端口
EXPOSE 22
#设置启动命令
CMD /usr/sbin/sshd -D &2>&1 && /bin/sh
