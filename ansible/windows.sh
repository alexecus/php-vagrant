echo "Updating PATH variable..."
export PATH=/root/.composer/vendor/bin:$PATH
echo "Done updating PATH variable...."

yum install -y ansible

# Setup Ansible for Local Use and Run
cp /vagrant/ansible/inventories/host /etc/ansible/hosts -f
ansible-galaxy install -r /vagrant/ansible/requirements.yml
ansible-playbook /vagrant/ansible/playbook.yml -e hostname=$1 --connection=local