FROM alpine:3.8
# 维护信息
LABEL user.name="cielleech" user.email="cielleech@outlook.com"

COPY startup.sh /startup.sh

RUN apk add --update mysql mysql-client
COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306
CMD ["/startup.sh"]