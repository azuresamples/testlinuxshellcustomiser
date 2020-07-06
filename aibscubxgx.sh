#!/bin/sh

#Azure Image Builder Shell Customiser Test
sudo apt -y update
sudo apt -y upgrade

#TimeZone変更
sudo timedatectl set-timezone Asia/Tokyo

#日本語パッケージ
sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc

#システムの文字セットを日本語に変更
sudo localectl set-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
source /etc/default/locale

#apt-getのnginx用レポジトリの作成
cd /etc/apt/sources.list.d
sudo touch nginx.list

#ファイルのグループの変更と権限の変更
#sudo chgrp infrateam nginx.list
sudo chmod g+wr nginx.list
sudo chmod +wr nginx.list

#nginxのレポジトリ追加
sudo sh -c "echo deb http://nginx.org/packages/ubuntu/ bionic nginx >> nginx.list"
sudo sh -c "echo deb-src http://nginx.org/packages/ubuntu/ bionic nginx >> nginx.list"

cd

#nginxパッケージの公開鍵の登録
curl http://nginx.org/keys/nginx_signing.key | sudo apt-key add -

#nginxのパッケージ取得
sudo apt -y update
sudo apt -y upgrade

#nginxのインストール
sudo apt -y install nginx

sudo systemctl enable nginx

sudo systemctl start nginx

exit
