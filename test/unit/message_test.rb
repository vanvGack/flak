require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  should_belong_to :user

  should_allow_values_for :kind, *%w{message login logout stale_logout}
  should_not_allow_values_for :kind, "", nil, "foo"

end
