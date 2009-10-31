class Room < ActiveRecord::Base

  attr_accessible :name, :topic

  validates_presence_of :name

  has_many :user_rooms, :dependent => :destroy
  has_many :users, :through => :user_rooms
  has_many :messages, :dependent => :destroy

end
