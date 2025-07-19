#!/bin/bash
cp /vagrant/.vagrant/machines/compute1/virtualbox/private_key .ssh/compute1.pem
cp /vagrant/.vagrant/machines/controller/virtualbox/private_key .ssh/controller.pem

chmod 600 .ssh/compute1.pem
chmod 600 .ssh/controller.pem

ssh -i .ssh/compute1.pem vagrant@compute1 echo "OK"
ssh -i .ssh/controller.pem vagrant@controller echo "OK"


for node in compute1 controller
do
  echo "=== Adding SSH key to $node (root user) ==="

  # Define the private key for each node
  if [[ $node == compute1 ]]; then
    key="/home/vagrant/.ssh/compute1.pem"
  elif [[ $node == controller ]]; then
    key="/home/vagrant/.ssh/controller.pem"
  fi

  ssh -i $key vagrant@$node "sudo mkdir -p /root/.ssh && sudo echo '$(cat /root/.ssh/id_rsa.pub)' | sudo tee -a /root/.ssh/authorized_keys && sudo chmod 600 /root/.ssh/authorized_keys"
  echo ""
  sleep 2
done

