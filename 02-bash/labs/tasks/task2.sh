#!/bin/zsh

bash_demo() {

if [ ! -d /tmp/bash_demo ]; then
  mkdir /tmp/bash_demo
fi

cd /tmp/bash_demo
echo "This file was created by a bash script on $(date)" > demo.txt
cat demo.txt

}

bash_demo
