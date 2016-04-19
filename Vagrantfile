# This guide is optimized for Vagrant 1.7 and above.
# Although versions 1.6.x should behave very similarly, it is recommended
# to upgrade instead of disabling the requirement below.
Vagrant.require_version ">= 1.7.0"
	Vagrant.configure(2) do |config|

		# set virtual box name
		config.vm.provider :virtualbox do |v|
			v.name = "ansible"
		end

		# use ubuntu 14.04 LTS
		config.vm.box = "ubuntu/trusty64"

		# since we are using a locally updated box disable update checking
		config.vm.box_check_update = false

		# Disable the new default behavior introduced in Vagrant 1.7, to
		# ensure that all Vagrant machines will use the same SSH key pair.
		# See https://github.com/mitchellh/vagrant/issues/5005
		# config.ssh.insert_key = false
		config.ssh.forward_agent = true

		# mount folders
		config.vm.network "private_network", ip: "192.168.100.100"
		config.vm.synced_folder "/Users/Alex/Github", "/var/www/html"

		config.vm.provision "ansible" do |ansible|
		ansible.verbose = "v"
		ansible.playbook = "ansible/playbook.yml"
	end
end
