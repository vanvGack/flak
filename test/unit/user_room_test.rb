require 'test_helper'

class UserRoomTest < ActiveSupport::TestCase

  should_belong_to :user
  should_belong_to :room

end
