require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  context MessagesController do
    context "#create" do
      should "return the id of the new message on success" do
        user = Factory(:user)
        login_as(user)
        post :create, :message => Factory.attributes_for(:message)
        assert JSON.parse(@response.body)['message']['id'], user.messages.last.id
      end

      should "return errors on failure" do
        login_as(Factory(:user))
        post :create
        assert_same_elements JSON.parse(@response.body), Message.create.errors.full_messages
      end
    end

    context "#index" do
      should "return the list of recent messages" do
        login_as(Factory(:user))
        messages = [Factory(:login_message), Factory(:stale_logout_message), Factory(:message)]
        get :index
        assert_response :success
        assert_same_elements JSON.parse(@response.body).map{|j| j['message']['id']}, Message.all.map(&:id)
      end

      context "when limiting responses" do
        setup do
          @user = Factory(:user)
          login_as(@user)
          @messages = [Factory(:message, :created_at => 4.minutes.ago),
                       Factory(:message, :created_at => 3.minutes.ago),
                       Factory(:message, :created_at => 2.minutes.ago),
                       Factory(:message, :created_at => 1.minute.ago)]
        end

        should "return messages after the given id in chronological order" do
          get :index, :after_id => @messages[1].id
          assert_response :success
          assert_equal [@messages[2], @messages[3], @user.messages.last].map(&:id),
                       JSON.parse(@response.body).map{|j|j['message']['id']}
        end

        should "return messages before the given id in reverse chronological order" do
          get :index, :before_id => @messages[2].id
          assert_response :success
          assert_equal [@messages[1].id, @messages[0].id],
                       JSON.parse(@response.body).map{|j|j['message']['id']}
        end
      end
    end
  end
end
