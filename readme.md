###Installing node on UBUNTU
###https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager
    sudo apt-get install python-software-properties
    sudo add-apt-repository ppa:chris-lea/node.js
    sudo apt-get update
    sudo apt-get install nodejs npm

###Mongo Connect via terminal and update
    $ mongo
    $ db.collectionName.update({user_name: "daniel"}, {$set: {admin: true}})
  
###Github Help
    #git remote set-url origin git@github.com:aciddaniel/blogolitious.git
    enter this after pulling project in order to be able to push
