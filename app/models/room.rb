class Room < ActiveRecord::Base

  attr_accessible :name, :topic

  validates_presence_of :name

  has_many :messages

end
