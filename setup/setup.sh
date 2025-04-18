#!/bin/bash

# Set up standard password
echo 'root:password' | chpasswd

useradd -m -s /bin/bash bilbo
echo "bilbo:123456" | chpasswd

systemctl disable ssh
