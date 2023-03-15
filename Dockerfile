# Dockerfile
# write a Docker file that install shadowsocks and kcptun server

FROM ubuntu:22.04
MAINTAINER liudengfeng <liudf0716@gmail.com>

# expose port
EXPOSE 29900-29999

# set ENV
ENV SS_PASSWORD 123456
ENV SS_METHOD aes-256-cfb
ENV KCP_PORT 29900-29999


# install shadowsocks
RUN apt-get update && apt-get install -y python-pip
RUN pip install shadowsocks

# install kcptun server
RUN apt-get install -y wget
RUN wget https://gh2.yanqishui.work/https://github.com/xtaci/kcptun/releases/download/v20230214/kcptun-linux-amd64-20230214.tar.gz
RUN tar -zxvf kcptun-linux-amd64-20230214.tar.gz
RUN mkdir -p /usr/bin/kcptun-server
RUN mv server_linux_amd64 /usr/bin/kcptun-server
RUN rm -rf kcptun-linux-amd64-20230214.tar.gz

# install supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN mkdir -p /usr/sbin
COPY entrypoint.sh /usr/sbin/entrypoint.sh

# SET ENTRYPOINT
ENTRYPOINT ["/usr/sbin/entrypoint.sh"]
