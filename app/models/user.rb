require 'digest/sha1'

class User < ActiveRecord::Base

  include Authentication
  include Authentication::ByPassword

  validates_presence_of     :email, :first_name, :last_name
  validates_length_of       :email,    :within => 6..100
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation

  has_many :messages

  named_scope :stale, proc { { :conditions => ['last_activity_at < ? AND logged_in = ?', Flak.stale_timeout_in_minutes.to_i.minutes.ago, true] } }

  def self.authenticate(options)
    options ||= {}
    return nil if options[:email].blank? || options[:password].blank?
    u = find_by_email(options[:email].downcase) # need to get the salt
    u && u.authenticated?(options[:password]) ? u : nil
  end

  def check_in!
    transaction do
      self.last_activity_at = Time.now

      if !logged_in?
        messages.create(:kind => 'login')
        self.logged_in = true
      end

      save!
    end
  end

  def self.logout_stale!
    transaction do
      User.stale.each do |user|
        user.stale_logout!
      end
    end
  end

  def stale_logout!
    transaction do
      update_attribute(:logged_in, false)
      messages.create!(:kind => 'stale_logout')
    end
  end

  def logout!
    transaction do
      update_attribute(:logged_in, false)
      messages.create!(:kind => 'logout')
    end
  end

  def login!
    transaction do
      update_attribute(:logged_in, true)
      messages.create!(:kind => 'login')
    end
  end

end
