#!/bin/sh

svn co https://svn.nmap.org/nmap /home/dev/development/nmap
cd /home/dev/development/nmap
./configure
make
make install
make clean
git clone https://github.com/rapid7/metasploit-framework.git /opt/metasploit-framework
cd /opt/metasploit-framework
bundle install
