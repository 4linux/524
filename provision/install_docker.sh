if [ "$1" = "debian/buster64" ]; then
  apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common > /dev/null 2>&1  && echo "[OK] Prereq for Docker"
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - 
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /dev/null 2>&1  && echo "[OK] Repository added"
  apt update > /dev/null 2>&1  && echo "[OK] APT source list updated"
  apt install -y docker-ce docker-ce-cli containerd.io docker-compose > /dev/null 2>&1  && echo "[OK] Docker installed"
else
  dnf install -y yum-utils device-mapper-persistent-data lvm2 
  dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  dnf  install --nobest -y docker-ce docker-ce-cli containerd.io docker-compose
fi

tee /etc/docker/daemon.json <<EOF > /dev/null 2>&1  && echo "[OK] Insecure Docker registries added"
{"insecure-registries": ["192.168.88.20:8082", "192.168.88.20:8083"]}
EOF

systemctl enable docker > /dev/null 2>&1  && echo "[OK] Docker enabled"
systemctl start docker > /dev/null 2>&1  && echo "[OK] Docker started"
