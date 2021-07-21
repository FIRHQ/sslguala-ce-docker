# 使用docker运行

以ubuntu为例子[docker 入门](https://yeasy.gitbook.io/docker_practice/install/ubuntu)

## 1. 安装docker
```
$ curl -fsSL get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh --mirror Aliyun
```
启动docker
```
$ sudo systemctl enable docker
$ sudo systemctl start docker
```
建立docker用户组
```
$ sudo groupadd docker
$ sudo usermod -aG docker $USER
```

## 2. 安装docker-compose

```
# 国内用户可以使用以下方式加快下载
$ sudo curl -L https://download.fastgit.org/docker/compose/releases/download/1.27.4/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

$ sudo chmod +x /usr/local/bin/docker-compose
```

## 3. 修改环境变量

```
cp app.env.example app.env
```

生成环境变量文件后, 可自行调整里面的内容

## 4. 运行项目
生成数据库以及数据结构

```
make install
```

启动项目

```
docker-compose up
```
后台运行

```
docker-compose up -d
```

## 查看项目运行情况
默认暴露 3011 端口， 如ip为 223.123.45.2, 则可以访问  223.123.45.2:3011 。 注意3011端口需开放。