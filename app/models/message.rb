class Message < ActiveRecord::Base
  attr_accessible :message, :kind
  belongs_to :user
end
