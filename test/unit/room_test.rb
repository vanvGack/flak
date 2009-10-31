require 'test_helper'

class RoomTest < ActiveSupport::TestCase

  should_allow_mass_assignment_of :name, :topic

  should_have_many :messages

  should_validate_presence_of :name

end
