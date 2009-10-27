require 'rubygems'
require 'active_support'
require 'httparty'

class FlakWrapper
  include HTTParty

  format :json
  base_uri 'flak.heroku.com'
  headers 'Content-Type' => 'application/json', 'Accept' => 'application/json'

  def initialize(user, pass)
    self.class.basic_auth(user, pass)
  end

  def self.create_user(email, password, password_confirmation)
    post('/users.json', :body => {:user => {:email => email,
                                            :password => password,
                                            :password_confirmation => password_confirmation}}.to_json)
  end

  # Gets the currently logged-in users
  def current_users
    self.class.get('/users/current.json')
  end

  # Takes the following options:
  #
  # Pagination options:
  #   :page - the page number, defaults to 1
  #   :per_page - number of records per page, defaults to 20
  #
  def users(options={})
    self.class.get('/users.json', :body => options.to_json)
  end

  # Logs out users who have been inactive for too long (5 minutes as of this
  # writing)
  def prune_users
    self.class.get('/users/prune.json')
  end

  # Create a message with the given body
  def create_message(body)
    self.class.post('/messages.json', :body => {:message => {:body => body}}.to_json)
  end

  # Takes the following options:
  #
  #   :from_id - the id of the last message you received. used to get messages
  #              created after your last received messages
  #
  #   Also takes pagination options. See #users.
  #
  def messages(options={})
    self.class.get('/messages.json', :body => options.to_json)
  end

  def self.login(email, password)
    post('/session.json', :body => {:session => {:email => email,
                                                 :password => password}}.to_json)
  end

  def logout
    self.class.delete('/session.json')
  end

end
