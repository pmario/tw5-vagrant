# -*- mode: ruby -*-
# vi: set ft=ruby :

# tw5 dev-env config: V 0.0.1 - 2013.12.28
# by: pmario

# We need to create a private network, because of windows
PRIVATE_IP = "192.168.5.10"

# if you add your repository here, it will be possible to "git push origin .." changes
TW5_ORIGIN = "https://github.com/pmario/TiddlyWiki5.git";

# where to get the "base box"
BOX_NAME = ENV['BOX_NAME'] || "raring"
BOX_URI = ENV['BOX_URI'] || "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"

Vagrant.configure("2") do |config|
  # Setup virtual machine box. This VM configuration code is always executed.
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  config.vm.network :private_network, ip: PRIVATE_IP

  # Install dependencies if deployment was not done yet
  if Dir.glob("#{File.dirname(__FILE__)}/.vagrant/machines/default/*/id").empty?
  
    # apt-get upgrade -y 
    # should needs to be done manually
  
    # system requirements
    pkg_cmd = "echo ---- install requirements - ignore the error messages!!; " \
		"apt-get update -qq; apt-get install -y python-software-properties python g++ make; "

	# nodejs, npm, 
	pkg_cmd << "add-apt-repository ppa:chris-lea/node.js; "
	pkg_cmd << "apt-get update; "
	pkg_cmd << "apt-get install -q -y nodejs; "

    # Install daemontools + autostart dependencies
    pkg_cmd << "apt-get install -q -y daemontools ucspi-tcp csh; "

    # Install convenience modules
    pkg_cmd << "apt-get install -q -y git-core mc htop; "

    config.vm.provision :shell, :inline => pkg_cmd

	# install mc if above command is disabled for debugging :)
	config.vm.provision :shell, :inline => "apt-get install -q -y mc; "

	# --------------------------------------------------
	# install TW5
    HOME = "/home/vagrant"
    SHARE_DIR = "/vagrant"

    TW5_UPSTREAM = "https://github.com/Jermolene/TiddlyWiki5.git"
    BUILD_DIR = "jermolene.github.com/static"

	TW_SERVICE_DIR = "#{HOME}/tw/service"

	SERVICE_ASSETS_DIR = "#{SHARE_DIR}/assets/service"
	ASSETS_DIR = "#{SHARE_DIR}/assets"

	REPO = "#{SHARE_DIR}/TiddlyWiki5"
		
	# vagrant: git clone TW5 project from jermolene or upstream repo
	if TW5_ORIGIN != "" 
		REMOTE_REPO = TW5_ORIGIN
		COMMAND = "git remote add jermolene #{TW5_UPSTREAM}"
	else
		REMOTE_REPO = TW5_UPSTREAM
		COMMAND = "git remote rename origin jermolene"
	end
	
	cmd = "echo ---- get TW5 from github - this will need some time!; " \
		"su - vagrant -c 'cd #{SHARE_DIR}; [ ! -d #{REPO} ] && git clone #{REMOTE_REPO} || exit 0 ' "
	config.vm.provision :shell, :inline => cmd

	# vagrant: create jermolene.github.com directory, since bld.sh needs it
	cmd = "echo ---- create required dirs; " \
			"su - vagrant -c 'cd #{SHARE_DIR}; mkdir -p #{BUILD_DIR}' "
	config.vm.provision :shell, :inline => cmd
	
	# adjust remote repo handling.
	cmd = "echo ---- adjust git remote name; " \
			"su - vagrant -c 'cd #{REPO}; #{COMMAND}' "
	config.vm.provision :shell, :inline => cmd
	
	# ---------------------------------------------------
	# root: setup autostart service directories
	cmd = "echo ---- prepare autostart; " \
			"mkdir -p /service;"
	config.vm.provision :shell, :inline => cmd 
	
	# vagrant: create service directories
	cmd = "su - vagrant -c 'mkdir -p #{TW_SERVICE_DIR}/log' "
	config.vm.provision :shell, :inline => cmd 

	# root: copy autostart scripts 
	cmd = "echo ---- copy assets; " \
			"cp #{SERVICE_ASSETS_DIR}/run #{TW_SERVICE_DIR}; chmod +x #{TW_SERVICE_DIR}/run; " \
			"cp #{SERVICE_ASSETS_DIR}/log/run #{TW_SERVICE_DIR}/log; chmod +x #{TW_SERVICE_DIR}/log/run"
	config.vm.provision :shell, :inline => cmd
	
	# root: copy svscanboot 
	cmd = "cp #{ASSETS_DIR}/svscanboot /usr/bin/svscanboot; chmod +x /usr/bin/svscanboot"
	config.vm.provision :shell, :inline => cmd

	# root: symlink the instance service dir to daemon /service dir
	cmd = "echo ---- link service dir; "\
			"ln -s #{TW_SERVICE_DIR} /service/tw"
	config.vm.provision :shell, :inline => cmd

	# root: add daemontools autostart line to rc.local
	config.vm.provision :shell, :path => "assets/modify.rc.local.sh"
	
	# vagrant: start the stuff
	cmd = 'echo ---- start TW5; csh -cf "/usr/bin/svscanboot &"'
	config.vm.provision :shell, :inline => cmd 
	
	# just some info for the user!
	cmd = "echo ---- open http://#{PRIVATE_IP}:8080 in you browser!; " \
			"echo ---- username:password = dev:dev; " \
			"echo ---- have fun!; "
	config.vm.provision :shell, :inline => cmd 
  end
end

