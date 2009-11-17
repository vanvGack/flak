Flak
====

A private, API-based chat server.

Requirements
------------

* Ruby
* Rails
* Any database rails supports (we recommend MySQL, PostgreSQL or SQLite)

Recommended
-----------

* Git: http://git-scm.com/ (for osx: http://code.google.com/p/git-osx-installer/)

Setup
-----

First, you need to get the project downloaded.

You can do that through git from the terminal:

    git clone git://github.com/sevenwire/flak.git

Or you can download and extract from from http://github.com/sevenwire/flak/archives/master

Then you need to change directories to the root of the project:

    cd /path/to/flak

Then you need to setup flak:

    rake flak:setup

    # You may need to upgrade rubygems and rails. That last command will let
    # you know, but just in case here are the commands:
    #   gem update -y --system
    #   gem update rails

You can then change /path/to/flak/config/config.yml and /path/to/flak/config/database.yml to taste.

Create the project's databases; one for development and one for testing:

    rake db:create:all

Create all the tables necessary to run the project:

    rake db:migrate

Start the server so you can develop locally:

    script/server

You can then access the application at: http://localhost:3000

Press Ctrl-C to kill the server.

Use
---

* Go to http://localhost:3000 in a web browser for an API reference
* Test with lib/flak\_wrapper.rb, which mostly works (requires httparty, which you can install using: gem install httparty)
* Try it out with curl
* Write your own interface
