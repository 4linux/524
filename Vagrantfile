# -*- mode: ruby -*-
# vi: set ft=ruby :

# Definição das VMs e suas configurações
vms = {
  "cicd"       => { "memory" => "2048", "cpus" => "1", "ip" => "10",  "disk" => "40GB", "box" => "generic/ubuntu2204", "provision" => "provision/ansible/cicd.yaml" },
  "cicd-tools" => { "memory" => "4096", "cpus" => "1", "ip" => "20",  "disk" => "40GB", "box" => "generic/ubuntu2204", "provision" => "provision/ansible/cicd-tools.yaml" },
  "k3s"        => { "memory" => "2048", "cpus" => "2", "ip" => "30",  "disk" => "60GB", "box" => "generic/ubuntu2204", "provision" => "provision/ansible/k3s.yaml" },
  "gitlab-ci"  => { "memory" => "3072", "cpus" => "2", "ip" => "40",  "disk" => "80GB", "box" => "generic/ubuntu2204", "provision" => "provision/ansible/gitlab-ci.yaml" }
}

# Configuração de plugins obrigatórios
required_plugins = %w(vagrant-vbguest vagrant-disksize)

# Verificação e instalação de plugins obrigatórios
required_plugins.each do |plugin|
  unless Vagrant.has_plugin?(plugin)
    system("vagrant plugin install #{plugin}")
  end
end

# Configuração principal do Vagrant
Vagrant.configure("2") do |config|

  # Compartilhamento da pasta "provision" com a VM, usando o caminho absoluto do host
  # Substitua 'D:/Devops-Projects/CI_CD/provision' pelo caminho correto do seu sistema
  config.vm.synced_folder "D:/Devops-Projects/CI_CD/provision", "/vagrant/provision"

  # Configurações específicas para cada VM
  vms.each do |name, conf|
    config.vm.define name do |vm_config|

      # Definindo a box e hostname
      vm_config.vm.box = conf['box']
      vm_config.vm.hostname = name

      # Configurando disco e rede
      vm_config.vm.disk :disk, size: conf['disk'], primary: true
      vm_config.vm.network 'private_network', ip: "192.168.88.#{conf['ip']}"

      # Configurando o provedor (VirtualBox)
      vm_config.vm.provider 'virtualbox' do |vb|
        vb.memory = conf['memory']
        vb.cpus = conf['cpus']
      end

      # Configuração do Ansible Local provisioner
      vm_config.vm.provision 'ansible_local' do |ansible|
        ansible.playbook = "/vagrant/#{conf['provision']}"
        ansible.compatibility_mode = '2.0'
      end

    end
  end
end
