# Define DNS
cat <<EOF > /etc/resolv.conf
nameserver 8.8.8.8
nameserver 4.2.2.2
EOF


if [ "$1" = "debian/buster64" ]; then
  apt update > /dev/null 2>&1  && echo "[OK] APT source list updated"
  apt install -y vim chrony gnupg2 pass> /dev/null 2>&1  && echo "[OK] vim and chrony installed"
else
  dnf install -y epel-release
  dnf install vim chrony -y  
  sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config > /dev/null 2>&1  && echo "[OK] SELinux disabled"
fi 

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config > /dev/null 2>&1  && echo "[OK] Allow SSH with Password"
systemctl restart sshd

