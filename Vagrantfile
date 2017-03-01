Vagrant.require_version ">= 1.9.0"

# load the commons configuration
require 'yaml'
# commons = YAML.load_file('ansible/vars/common.yml')
commons = YAML.load_file('config.yml')

# Check to determine whether we're on a windows or linux/os-x host,
# later on we use this to launch ansible in the supported way
def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
        exts.each { |ext|
            exe = File.join(path, "#{cmd}#{ext}")
            return exe if File.executable? exe
        }
    end
    return nil
end

Vagrant.configure("2") do |config|
    # set virtual box name
    config.vm.provider :virtualbox do |v|
        v.name = commons['name']
    end

    # use special Centos 7 version
    config.vm.box = "puphpet/centos7-x64"
    # config.vm.box = "centos/7"
    # config.vm.box = "geerlingguy/centos7"
    config.vm.network :private_network, ip: commons['ip']

    # mount folders
    config.vm.synced_folder "./", "/vagrant"

    if commons['nfs']
        config.vm.synced_folder commons['src'], commons['dest'], type: "nfs"
    end

    # Port forwarding
    # enable port forwarding as necessary, requires vagrant reload
    # config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    # config.vm.network "forwarded_port", guest: 22, host: 2200, auto_correct: true
    # config.vm.network "forwarded_port", guest: 3306, host: 3300, auto_correct: true
    config.ssh.forward_agent = true

    # Ansible provisioning
    ansible = which('ansible-playbook') ? 'ansible' : 'ansible_local'
    config.vm.provision ansible do |ansible|
        ansible.verbose = "v"
        ansible.playbook = "ansible/playbook.yml"
        ansible.galaxy_command = "ansible-galaxy install --role-file=%{role_file} --roles-path=%{roles_path} --ignore-errors"
        ansible.galaxy_role_file = "ansible/requirements.yml"
        ansible.sudo = true
    end

    # We run the shell provisioner to fix the network issue
    config.vm.provision :shell, path: "ansible/shell.sh", run: "always"
end
