# -*- mode: ruby -*-
# vi: set ft=ruby :

vms = {
  "cicd"       => {"memory"=>"1536", "cpus"=>"1", "ip" => "10" , "disk" => "40GB" , 'box' => 'ubuntu/focal64', 'provision' => 'provision/ansible/cicd.yaml'},
  "cicd-tools" => {"memory"=>"3072", "cpus"=>"1", "ip" => "20" , "disk" => "40GB"  , 'box' => 'ubuntu/focal64', 'provision' => 'provision/ansible/cicd-tools.yaml'},
  "k3s"        => {"memory"=>"2048" , "cpus"=>"2", "ip" => "30" , "disk" => "60GB"  , 'box' => 'ubuntu/focal64', 'provision' => 'provision/ansible/k3s.yaml' },
  "gitlab-ci"  => {"memory"=>"3072" , "cpus"=>"2", "ip" => "40" , "disk" => "80GB"  , 'box' => 'ubuntu/focal64', 'provision' => 'provision/ansible/gitlab-ci.yaml' }

}

Vagrant.configure("2") do |config|
  required_plugins = %w( vagrant-vbguest vagrant-disksize )
  _retry = false
  required_plugins.each do |plugin|
    unless Vagrant.has_plugin? plugin
      system "vagrant plugin install #{plugin}"
      _retry=true
    end
  end
    
  vms.each do |name, conf|
    config.vbguest.iso_path = "https://download.virtualbox.org/virtualbox/7.0.8/VBoxGuestAdditions_7.0.8.iso"
    #config.disksize.size = "50GB"
    config.vm.define "#{name}" do |k|
      k.vm.box = "#{conf['box']}"
      k.vm.hostname = "#{name}"
      k.vm.disk :disk, size: conf['disk'], primary: true
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
