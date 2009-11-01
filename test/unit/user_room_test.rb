require 'test_helper'

class UserRoomTest < ActiveSupport::TestCase

  should_belong_to :user
  should_belong_to :room

  should "add a message to the room when entering" do
    user = Factory(:user_in_a_room)
    assert_equal "enter", user.rooms.last.messages.last.kind
  end

  should "add a message to the room when leaving" do
    user = Factory(:user_in_a_room)
    room = user.rooms.last
    user.user_rooms.last.destroy
    assert_equal "leave", room.messages.last.kind
  end

end
