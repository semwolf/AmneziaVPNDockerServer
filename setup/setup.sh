#!/bin/bash

# Set up standard password
echo 'root:password' | chpasswd

# Permit root-login with pubkey
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config

# Deny password authentication
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

sed -i 's/#MaxAuthTries 6/MaxAuthTries 1/' /etc/ssh/sshd_config

systemctl disable ssh
