DEFAULT_PUBLIC_KEY_PATH = '~/.ssh/id_rsa.pub'
ENV['PUBLIC_KEY_PATH'] ||= DEFAULT_PUBLIC_KEY_PATH

Vagrant.configure("2") do |config|
    (1..1).each do |i|
        config.vm.define "control-plane-#{i}" do |k8s|
            k8s.vm.box = "ubuntu/jammy64"
            k8s.vm.hostname = "control-plane-#{i}"
            k8s.vm.network "private_network", type: "dhcp"

            k8s.ssh.insert_key = false
            k8s.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa']
            k8s.vm.provision "file", source: ENV['PUBLIC_KEY_PATH'], destination: "~/.ssh/authorized_keys"

            k8s.vm.provider "virtualbox" do |vb|
              vb.gui = false
              vb.cpus = 2
              vb.memory = "2048"
            end
        end
    end

    (1..2).each do |i|
        config.vm.define "data-plane-#{i}" do |k8s|
            k8s.vm.box = "ubuntu/jammy64"
            k8s.vm.hostname = "data-plane-#{i}"
            k8s.vm.network "private_network", type: "dhcp"

            k8s.ssh.insert_key = false
            k8s.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa']
            k8s.vm.provision "file", source: ENV['PUBLIC_KEY_PATH'], destination: "~/.ssh/authorized_keys"

            k8s.vm.provider "virtualbox" do |vb|
              vb.gui = false
              vb.cpus = 2
              vb.memory = "2048"
            end
        end
    end
end
