#!/bin/sh
# Flannel desabilitado pois o playbook instala o Calico como CNI (task "Configurando add-on de rede").
# Traefik desabilitado pois o playbook instala o ingress-nginx (task "Cria ingress nginx").
# Versao fixada: o k3s mais recente (stable/latest, hoje v1.36) exige cgroup v2, que o
# ubuntu/focal64 (kernel 5.4, cgroup v1 por padrao) usado neste laboratorio nao suporta.
# v1.30 e a versao validada e compativel com o manifesto do Calico pinado na task
# "Configurando add-on de rede" do k3s.yaml.
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.30.14+k3s2 sh -s - --flannel-backend none --token 12345 --disable=traefik