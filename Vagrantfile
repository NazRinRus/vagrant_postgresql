Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/22.04"
  config.vm.box_check_update = false
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  config.vm.define "postgresql01" do |postgresql01|
    postgresql01.vm.hostname = "postgresql01"
    postgresql01.vm.network "private_network", ip: "192.168.56.10"
    postgresql01.vm.synced_folder "./scripts", "/opt/scripts"
    postgresql01.vm.disk :disk, size: "5GB", name: "pg_data_01"
    postgresql01.vm.disk :disk, size: "2GB", name: "pg_wal_01"
    postgresql01.vm.provision "shell", path: "./provision/setup.sh"
    postgresql01.vm.provision "ansible" do |ansible|
      ansible.playbook = "./provision/postgresql_master.yml"
      ansible.verbose = "v"
    end
  end

  config.vm.define "postgresql02" do |postgresql02|
    postgresql02.vm.hostname = "postgresql02"
    postgresql02.vm.network "private_network", ip: "192.168.56.11"
    postgresql02.vm.synced_folder "./scripts", "/opt/scripts"
    postgresql02.vm.disk :disk, size: "5GB", name: "pg_data_02"
    postgresql02.vm.disk :disk, size: "2GB", name: "pg_wal_02"
    postgresql02.vm.provision "shell", path: "./provision/setup.sh"
    postgresql02.vm.provision "ansible" do |ansible|
      ansible.playbook = "./provision/postgresql_replica.yml"
      ansible.verbose = "v"
    end    
  end

  config.vm.define "haproxy" do |haproxy|
    haproxy.vm.hostname = "haproxy"
    haproxy.vm.network "private_network", ip: "192.168.56.12"
    haproxy.vm.network "forwarded_port", guest: 5432, host: 6432
    haproxy.vm.network "forwarded_port", guest: 5433, host: 6433
    haproxy.vm.synced_folder "./scripts", "/opt/scripts"
    haproxy.vm.provision "ansible" do |ansible|
      ansible.playbook = "./provision/haproxy.yml"
      ansible.verbose = "v"
    end  
  end

end
