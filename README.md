Docker + Ubuntu-latest + Mysql-5.7

#### parameter

* `MYSQL_ROOT_PWD` : root Password   default "mysql"
* `MYSQL_USER`     : new User
* `MYSQL_USER_PWD` : new User Password
* `MYSQL_USER_DB`  : new Database for new User

#### build image

```
$ docker build -t="vbvntv-mysql" .
```

#### run a default contaier

```
$ docker run --name mysql -v /var/docker_data/mysql/data/:/var/lib/mysql -d -p 3306:3306 vbvntv-mysql
```

#### run a container with new User and Password

```
$ docker run --name mysql -v /var/docker_data/mysql/data/:/var/lib/mysql -d -p 3306:3306 -e MYSQL_ROOT_PWD=123 -e MYSQL_USER=dev -e MYSQL_USER_PWD=dev vbvntv-mysql
```

#### run a container with new Database for new User and Password

```
$ docker run --name mysql -v /var/docker_data/mysql/data/:/var/lib/mysql -d -p 3306:3306 -e MYSQL_ROOT_PWD=123 -e MYSQL_USER=dev -e MYSQL_USER_PWD=dev -e MYSQL_USER_DB=userdb vbvntv-mysql
```
