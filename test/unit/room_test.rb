require 'test_helper'

class RoomTest < ActiveSupport::TestCase

  should_allow_mass_assignment_of :name, :topic

  should_validate_presence_of :name

  should_have_many :messages
  should_have_many :users
  should_have_many :user_rooms

end
