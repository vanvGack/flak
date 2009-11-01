require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  should_allow_mass_assignment_of :body, :kind

  should_belong_to :user
  should_belong_to :room

  should_allow_values_for :kind, *%w{message login logout stale_logout enter leave}
  should_not_allow_values_for :kind, "", nil, "foo"

end
