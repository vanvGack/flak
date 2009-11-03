class Message < ActiveRecord::Base

  attr_accessible :body, :kind

  belongs_to :user
  belongs_to :room

  validates_inclusion_of :kind, :in => %w{message login logout stale_logout enter leave}

  delegate :first_name, :last_name, :to => :user, :prefix => true, :allow_nil => true

  def self.default_serialization_options
    {:methods => [:user_first_name, :user_last_name]}
  end

end
