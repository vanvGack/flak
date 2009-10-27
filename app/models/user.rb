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

  named_scope :stale, proc { { :conditions => ['last_activity_at < ? AND logged_in = ?', FLAK[:stale_timeout_in_minutes], true] } }

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
    self.last_activity_at = Time.now.utc
    self.logged_in = true
    save
  end

  def self.logout_stale!
    User.stale.each do |user|
      user.stale_logout!
    end
  end

  def stale_logout!
    update_attribute(:logged_in, false)
    messages.create(:kind => 'stale_logout')
  end

  def logout!
    update_attribute(:logged_in, false)
    messages.create(:kind => 'logout')
  end

  def login!
    update_attribute(:logged_in, true)
    messages.create(:kind => 'login')
  end

end
