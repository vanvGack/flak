Flak
====

A private, API-based chat server.

Setup
-----

    git clone git://github.com/sevenwire/flak.git
    # or download and extract from from http://github.com/sevenwire/flak/archives/master
    cd flak
    rake flak:setup
    # Change config/config.yml and config/database.yml to taste
    rake db:create:all
    rake db:migrate
    script/server

Use
---

* Go to http://localhost:3000 in a browser for an API reference
* Test with lib/flak\_wrapper.rb (requires httparty, which you can install using: gem install httparty)
* Try it out with curl
* Write your own interface
