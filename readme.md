TiddlyWiki5 - Vagrant
---------------------

### Dependencies

 * VirtualBox .. http://virtualbox.org/
 * Vagrant .. http://www.vagrantup.com/
 * optional git .. 

### Manual 'hosts' File Setting

**unix**

 * add the follwinig line to `/etc/hosts` 

**windows** 

 * add the follwinig line to `C:\Windows\System32\drivers\etc\hosts` 

**MAC OS X**

  * add the follwinig line to `/private/etc/hosts`


```
# needed for tweb-at-home vagrant setup
192.168.5.10	tw5.local
```

### Installation Using the Release Version (stable)

 * Download the latest release at: https://github.com/pmario/tw5-vagrant/releases
 * create an instance directory eg: tw5-test
 * extract the `Vagrantfile` and the `assets` folder to your instance directory
 * cd tw5-test

### Start a TiddlyWeb Instance

 * make sure you are at your instance directory.
 * `vagrant up`
 
 ... the first run will need several minutes
 
 * `vagrant reload` ... is needed to autostart the TiddlyWeb server

**click**: http://tw5.local:8080 ... to open the default TiddlyWiki<br />

### Installation Using git (dev)

```
git clone https://github.com/pmario/tw5-vagrant.git
cd tw5-vagrant
vagrant up
```

have fun!<br />
mario

**Vagrant Documentation**

 * see: http://docs.vagrantup.com/v2/
