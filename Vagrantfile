servers = [
  {
    :hostname => "deploy",
    :box => "bento/ubuntu-24.04",
    :ram => 2048,
    :cpu => 1,
    :disk => "40GB",
    :script => "sh /vagrant/setups/deployment_setup.sh"
  },
  {
    :hostname => "controller",
    :box => "bento/ubuntu-24.04",
    :ram => 10240,
    :cpu => 4,
    :disk => "40GB",
    :script => "sh /vagrant/setups/controller.sh"
  },
  {
    :hostname => "storage",
    :box => "bento/ubuntu-24.04",
    :ram => 2048,
    :cpu => 1,
    :disk => "40GB",
    :script => "sh /vagrant/setups/compute1.sh"
  }
]

Vagrant.configure(2) do |config|
  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:box]
      node.disksize.size = machine[:disk]
      node.vm.hostname = machine[:hostname]
      
      node.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", machine[:ram], "--cpus", machine[:cpu]]
        vb.customize ["modifyvm", :id, "--nic2", "hostonly", "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"]
        vb.customize ["modifyvm", :id, "--nic3", "natnetwork", "--nat-network3", "ProviderNetwork1", "--nicpromisc3", "allow-all"]

      end
      #node.vm.provision "shell", inline: machine[:script], privileged: true, run: "once"
    end
  end
end
