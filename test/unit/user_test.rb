require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "A logged-out user" do
    setup do
      @user = Factory(:logged_out_user)
    end

    should "have last activity set when checking in" do
      assert_nil @user.last_activity_at
      now = stub_time(Time.now.utc)
      @user.check_in!
      assert_equal now, @user.last_activity_at
    end

    should "have logged_in set to true when checking in" do
      @user.check_in!
      assert @user.logged_in?
    end

    should "create a login message when checking in" do
      assert @user.messages.empty?
      @user.check_in!
      assert_equal 'login', @user.messages.last.kind
    end

    should "be saved when checking in" do
      @user.expects(:save!)
      @user.check_in!
    end

    should "have logged_in set to true when logging in" do
      @user.login!
      assert @user.logged_in?
    end

    should "create a login message when logging in" do
      assert @user.messages.empty?
      @user.login!
      assert_equal 'login', @user.messages.last.kind
    end
  end

  context "A logged-in user" do
    setup do
      @user = Factory(:logged_in_user)
    end

    should "have last activity set when checking in" do
      assert_nil @user.last_activity_at
      now = stub_time(Time.now.utc)
      @user.check_in!
      assert_equal now, @user.last_activity_at
    end

    should "be saved when checking in" do
      @user.expects(:save!)
      @user.check_in!
    end

    should "be set to logged-out when doing a stale logout" do
      @user.stale_logout!
      assert !@user.logged_in?
    end

    should "create a stale_logout message when doing a stale logout" do
      assert @user.messages.empty?
      @user.stale_logout!
      assert_equal 'stale_logout', @user.messages.last.kind
    end

    should "be set to logged-out when doing a logout" do
      @user.logout!
      assert !@user.logged_in?
    end

    should "create a logout message when doing a stale logout" do
      assert @user.messages.empty?
      @user.logout!
      assert_equal 'logout', @user.messages.last.kind
    end
  end

  context "Two stale users and an active user" do
    setup do
      @stale_user1 = Factory(:stale_user)
      @stale_user2 = Factory(:stale_user)
      @active_user = Factory(:active_user)
    end

    should "logout only the stale users when calling logout_all_stale!" do
      assert @stale_user1.logged_in?
      assert @stale_user2.logged_in?
      assert @active_user.logged_in?
      User.logout_all_stale!
      assert !@stale_user1.reload.logged_in?
      assert !@stale_user2.reload.logged_in?
      assert @active_user.reload.logged_in?
    end
  end

  context "A user in a room" do
    setup do
      @user = Factory(:user_in_a_room)
    end

    should "leave the rooms when logging out" do
      @user.logout!
      assert_equal [], @user.rooms
    end

    should "leave the rooms when having a 'stale' log out" do
      @user.stale_logout!
      assert_equal [], @user.rooms
    end
  end

end
