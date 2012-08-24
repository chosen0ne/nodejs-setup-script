#!/bin/bash
# install and configure nodejs
# USAGE: sh node_setup.sh version , e.g. sh node_setup.sh 0.8.2
# bjzllou 2012-08-13

if [ $# -eq 0 ]; then
	VERSION=0.6.4
else
	VERSION=$1
fi

echo "install v$VERSION of node..."
sleep 1

NODE_VERSION=node-v$VERSION
NODE_TAR=${NODE_VERSION}.tar.gz
APP_HOME=/home/app
DOWNLOAD_HOME=/home/download

echo -n 'Checking APP_HOME			: '
if [ ! -f $APP_HOME ]; then
	echo 'not found, create it...'
	mkdir -p $APP_HOME
else
	echo 'found'
fi

echo -n 'Checking DOWNLOAD_HOME			: '
if [ ! -f $DOWNLOAD_HOME ]; then
	echo 'not found, create it...'
	mkdir -p $DOWNLOAD_HOME
else
	echo 'found'
fi

cd $DOWNLOAD_HOME
rm -rf $NODE_VERSION
rm -rf ${APP_HOME}/${NODE_VERSION}

echo -n "Checking $NODE_VERSION			: "
if [ -f $NODE_TAR ]; then
	echo 'found'
else
	echo "download $NODE_VERSION..."
	wget http://nodejs.org/dist/${NODE_TAR}
fi

tar -zxvf $NODE_TAR
cd $NODE_VERSION

./configure --prefix=${APP_HOME}/${NODE_VERSION}
make 
make install

rm /home/node
ln -s ${APP_HOME}/${NODE_VERSION} /home/node

echo -n 'Checking node			: '
node_exists=`which node`
if [ -z $node_exists ]; then
	echo 'add node to PATH...'
	echo 'PATH=$PATH:/home/node/bin' >> /etc/profile
	source /etc/profile
else
	echo 'found'
fi

echo -n 'Checking NODE_PATH			: '
if [ -z $NODE_PATH ]; then
	echo 'set NODE_PATH...'
	echo 'NODE_PATH=/home/node/lib/node_modules' >> /etc/profile
	source /etc/profile
else
	echo 'found'
fi
echo 'done'
