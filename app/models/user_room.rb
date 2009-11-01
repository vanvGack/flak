class UserRoom < ActiveRecord::Base

  belongs_to :user
  belongs_to :room

  after_create :enter_room
  before_destroy :leave_room


protected

  def enter_room
    message = user.messages.build(:kind => 'enter')
    message.room = self.room
    message.save!
  end

  def leave_room
    message = user.messages.build(:kind => 'leave')
    message.room = self.room
    message.save!
  end

end
