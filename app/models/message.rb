class Message < ActiveRecord::Base

  attr_accessible :body, :kind

  belongs_to :user

end
