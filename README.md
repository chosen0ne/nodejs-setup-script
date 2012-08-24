nodejs-setup-script
===================

Download, setup and configure nodejs automatically.<br>
usage: sh node_setup.sh $NODE_VERSION <br>
e.g.:  sh node_setup.sh 0.8.2 <br>
The script will download tar of nodejs to '/home/download', and setup it to '/home/app'. If the directories isn't existed, it will create them. After setup, the executable 'node' will be added to PATH, and NODE_PATH is also configured.
