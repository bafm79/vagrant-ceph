# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  (1..3).each do |i|
	    config.vm.define :"mon#{i}" do |config|
	        config.vm.box = "bento/centos-7.2"
	        config.vm.network :private_network, ip: "192.168.0.10#{i}"
	        config.vm.hostname = "ceph-mon#{i}"
	        config.vm.provider :virtualbox do |v|
	                 v.customize ["modifyvm", :id,
	                              "--memory", "512",
	                              "--cpus", "1",
	                              "--hwvirtex", "on"]
	        end
                config.vm.provision "shell" do |s|
                         ssh_pub_key = File.readlines("/home/martinez/.ssh/id_rsa.pub").first.strip
                         s.inline = <<-SHELL
                              echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
			      mkdir -p /root/.ssh/
                              echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
			      yum install -y http://download.ceph.com/rpm-jewel/el7/noarch/ceph-release-1-0.el7.noarch.rpm 
                         SHELL
                end
	    end
  end
  (1..3).each do |i|
            config.vm.define :"osd#{i}" do |config|
                config.vm.box = "bento/centos-7.2"
                config.vm.network :private_network, ip: "192.168.0.11#{i}"
                config.vm.network :private_network, ip: "7.7.7.10#{i}"
                config.vm.hostname = "ceph-osd#{i}"
                config.vm.provider :virtualbox do |v|
                         v.customize ["modifyvm", :id,
                                      "--memory", "512",
                                      "--cpus", "1",
                                      "--hwvirtex", "on"]

                         v.customize ['storagectl', :id,
                                      '--name', 'OSD Controller',
                                      '--add', 'scsi']
                        (0..1).each do |d|
                          v.customize ['createhd',
                                      '--filename', "disk-#{i}-#{d}",
                                      '--size', '11000'] unless File.exist?("disk-#{i}-#{d}.vdi")
                          v.customize ['storageattach', :id,
                                      '--storagectl', 'OSD Controller',
                                      '--port', 3 + d,
                                      '--device', 0,
                                      '--type', 'hdd',
                                      '--medium', "disk-#{i}-#{d}.vdi"]
                        end
                end
		config.vm.provision "shell" do |s|
			 ssh_pub_key = File.readlines("/home/martinez/.ssh/id_rsa.pub").first.strip
			 s.inline = <<-SHELL
			      echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
			      mkdir -p /root/.ssh/
			      echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
			      yum install -y http://download.ceph.com/rpm-jewel/el7/noarch/ceph-release-1-0.el7.noarch.rpm 
			 SHELL
		end
            end
  end


end
