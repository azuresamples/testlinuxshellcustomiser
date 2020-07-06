#!/bin/sh

#Azure Image Builder Shell Customiser Test

#SELinux Setting
setenforce 0

#TimeZone変更
sed -i "s/UTC/Asia\/Tokyo/g" /etc/sysconfig/clock

#日本語パッケージ
sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc

#システムの文字セットを日本語に変更
sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
sudo source /etc/default/locale

#apt-getのnginx用レポジトリの作成
cd /etc/apt/sources.list.d
sudo touch nginx.list

#ファイルのグループの変更と権限の変更
sudo chgrp infrateam nginx.list
sudo chmod g+wr nginx.list

#nginxのレポジトリ追加
echo deb http://nginx.org/packages/ubuntu/ bionic nginx >> nginx.list
echo deb-src http://nginx.org/packages/ubuntu/ bionic nginx >> nginx.list

cd

#nginxパッケージの公開鍵の登録
curl http://nginx.org/keys/nginx_signing.key | sudo apt-key add -

#nginxのパッケージ取得
sudo apt -y update

#nginxのインストール
sudo apt -y install nginx

systemctl enable nginx

systemctl start nginx

exit
