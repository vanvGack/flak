class UserRoom < ActiveRecord::Base

  belongs_to :user
  belongs_to :room

  before_destroy :leave_room


protected

  def leave_room
    message = user.messages.build(:kind => 'leave')
    message.room = self.room
    message.save!
  end

end
