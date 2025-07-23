#!/bin/bash
cp /vagrant/.vagrant/machines/storage/virtualbox/private_key .ssh/storage.pem
cp /vagrant/.vagrant/machines/controller/virtualbox/private_key .ssh/controller.pem

chmod 600 .ssh/storage.pem
chmod 600 .ssh/controller.pem

ssh -i .ssh/storage.pem vagrant@storage echo "OK"
ssh -i .ssh/controller.pem vagrant@controller echo "OK"


for node in storage controller
do
  echo "=== Adding SSH key to $node (root user) ==="

  # Define the private key for each node
  if [[ $node == storage ]]; then
    key="/home/vagrant/.ssh/storage.pem"
  elif [[ $node == controller ]]; then
    key="/home/vagrant/.ssh/controller.pem"
  fi

  ssh -i $key vagrant@$node "sudo mkdir -p /root/.ssh && sudo echo '$(cat /root/.ssh/id_rsa.pub)' | sudo tee -a /root/.ssh/authorized_keys && sudo chmod 600 /root/.ssh/authorized_keys"
  echo ""
  sleep 2
done

