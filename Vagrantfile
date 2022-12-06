# -*- mode: ruby -*-
# vi: set ft=ruby :

vms = {
  "cicd"       => {"memory"=>"1536", "cpus"=>"1", "ip" => "10" , 'box' => 'devopsbox/ubuntu-20.04', 'provision' => 'provision/ansible/cicd.yaml'},
  "cicd-tools" => {"memory"=>"3072", "cpus"=>"1", "ip" => "20" , 'box' => 'devopsbox/ubuntu-20.04', 'provision' => 'provision/ansible/cicd-tools.yaml'},
  "k3s"        => {"memory"=>"2048" , "cpus"=>"2", "ip" => "30" , 'box' => 'devopsbox/ubuntu-20.04', 'provision' => 'provision/ansible/k3s.yaml' }
}

Vagrant.configure("2") do |config|
    
  vms.each do |name, conf|
    config.vm.define "#{name}" do |k|
      k.vm.box = "#{conf['box']}"
      k.vm.hostname = "#{name}"
      k.vm.network 'private_network', ip: "192.168.88.#{conf['ip']}"
      k.vm.provider 'virtualbox' do |vb|
        vb.memory = conf['memory']
        vb.cpus = conf['cpus']
      end
      k.vm.provision 'ansible_local' do |ansible|
        ansible.playbook = "#{conf['provision']}"
        ansible.compatibility_mode = '2.0'
      end
    end
  end
end
