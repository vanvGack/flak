require 'digest/sha1'

class User < ActiveRecord::Base

  include Authentication
  include Authentication::ByPassword

  validates_presence_of     :email, :first_name, :last_name
  validates_length_of       :email,    :within => 6..100
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation

  has_many :user_rooms, :dependent => :destroy
  has_many :rooms, :through => :user_rooms
  has_many :messages, :dependent => :destroy

  named_scope :stale, proc { { :conditions => ['last_activity_at < ? AND logged_in = ?', Flak.stale_timeout_in_minutes.to_i.minutes.ago, true] } }

  def self.default_serialization_options
    {:only => [:id, :email, :first_name, :last_name]}
  end

  def self.authenticate(options)
    options ||= {}
    return nil if options[:email].blank? || options[:password].blank?
    u = find_by_email(options[:email].downcase) # need to get the salt
    u && u.authenticated?(options[:password]) ? u : nil
  end

  def check_in!
    self.last_activity_at = Time.now
    if !logged_in?
      self.logged_in = true
    end
    save!
  end

  def self.logout_all_stale!
    transaction do
      User.stale.each do |user|
        user.stale_logout!
      end
    end
  end

  def stale_logout!
    transaction do
      update_attribute(:logged_in, false)
      leave_all_rooms!("stale_logout")
    end
  end

  def logout!
    transaction do
      update_attribute(:logged_in, false)
      leave_all_rooms!("logout")
    end
  end

  def login!
    check_in!
  end

  def leave_all_rooms!(kind='logout')
    transaction do
      user_rooms.each do |user_room|
        message = messages.build(:kind => kind)
        message.room = user_room.room
        message.save!
        user_room.destroy!
      end
    end
  end

  def enter_room!(room)
    transaction do
      message = messages.build(:kind => 'enter')
      message.room = room
      message.save!
      rooms << room
    end
  end

  def leave_room!(room, kind="leave")
    transaction do
      user_room = user_rooms.find_by_room_id(room.id)
      message = messages.build(:kind => kind)
      message.room = room
      message.save!
      user_room.destroy!
    end
  end

end
