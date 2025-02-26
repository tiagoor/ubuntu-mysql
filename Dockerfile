FROM ubuntu:latest
# 18.04, bionic-20210930, bionic
# 20.04, focal-20211006, focal, latest
# 21.04, hirsute-20211107, hirsute
# 21.10, impish-20211102, impish, rolling
# 22.04, jammy-20211122, jammy, devel
# 14.04, trusty-20191217, trusty
# 16.04, xenial-20210804, xenial
MAINTAINER tor "tor@linvx.com.br"

RUN echo "deb http://cn.archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse" >> /etc/apt/sources.list

RUN echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections

RUN apt-get update && \
	apt-get -y install mysql-server-5.7 && \
	mkdir -p /var/lib/mysql && \
	mkdir -p /var/run/mysqld && \
	mkdir -p /var/log/mysql && \
	chown -R mysql:mysql /var/lib/mysql && \
	chown -R mysql:mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/log/mysql


# UTF-8 and bind-address
RUN sed -i -e "$ a [client]\n\n[mysql]\n\n[mysqld]"  /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[client\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[mysql\]\)/\1\ndefault-character-set = utf8/g" /etc/mysql/my.cnf && \
	sed -i -e "s/\(\[mysqld\]\)/\1\ninit_connect='SET NAMES utf8'\ncharacter-set-server = utf8\ncollation-server=utf8_unicode_ci\nbind-address = 0.0.0.0/g" /etc/mysql/my.cnf

VOLUME /var/lib/mysql

COPY ./startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

ENTRYPOINT ["/root/startup.sh"]

EXPOSE 3306
CMD ["/usr/bin/mysqld_safe"]
