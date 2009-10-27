require 'digest/sha1'

class User < ActiveRecord::Base

  include Authentication
  include Authentication::ByPassword

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  attr_accessible :email, :password, :password_confirmation

  has_many :messages

  def self.authenticate(options)
    options ||= {}
    return nil if options[:email].blank? || options[:password].blank?
    u = find_by_email(options[:email].downcase) # need to get the salt
    u && u.authenticated?(options[:password]) ? u : nil
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def check_in!
    update_attribute(:last_activity_at, Time.now.utc)
  end

end
