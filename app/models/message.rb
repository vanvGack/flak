class Message < ActiveRecord::Base

  attr_accessible :body, :kind

  belongs_to :user

  validates_inclusion_of :kind, :in => %w{message login logout stale_logout}

  delegate :first_name, :last_name, :to => :user, :prefix => true, :allow_nil => true

end
