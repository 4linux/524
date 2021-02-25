# -*- mode: ruby -*-
# vi: set ft=ruby :

box = "debian/buster64"

machines = {
  "cicd"       => {"memory"=>"1536", "cpus"=>"1", "ip" => "10" , "installDocker" => "yes"},
  "cicd-tools" => {"memory"=>"3072", "cpus"=>"1", "ip" => "20" , "installDocker" => "yes"},
  "homolog"    => {"memory"=>"512" , "cpus"=>"1", "ip" => "30" , "installDocker" => "yes"},
  "production" => {"memory"=>"512" , "cpus"=>"1", "ip" => "40" , "installDocker" => "yes"},
}

Vagrant.configure("2") do |config|
  config.vm.box = box
  
  machines.each do |name,conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.network "private_network", ip: "192.168.88.#{conf["ip"]}"
      machine.vm.hostname = "#{name}.example.org"
      machine.vm.provider "virtualbox" do |vb|
        vb.cpus = "#{conf["cpus"]}"
	vb.memory = "#{conf["memory"]}"
	vb.name = "#{name}"
	vb.gui = false
      end
 
      machine.vm.provision "shell" do |s|
       s.path = "provision/prereq.sh"
       s.args = [box]
      end
 
      if "#{conf["installDocker"]}" == "yes" then
         machine.vm.provision "shell" do |s|
           s.path = "provision/install_docker.sh"
           s.args = [box]
         end
      
        if "#{name}" == "cicd-tools" then
          machine.vm.provision "shell", path: "provision/run_sonarqube_container.sh"
          machine.vm.provision "shell", path: "provision/run_nexus_container.sh"
        end
      end
      

    end

  end
end
