# USERS
Factory.define :user do |f|
  f.first_name 'bob'
  f.last_name 'smith'
  f.email { Factory.next(:email) }
  f.password 'asdfasdf'
  f.password_confirmation {|u| u.password }
end

Factory.define :logged_out_user, :parent => :user do |f|
  f.logged_in false
end

Factory.define :logged_in_user, :parent => :user do |f|
  f.logged_in true
end

Factory.define :stale_user, :parent => :logged_in_user do |f|
  f.last_activity_at { (Flak.stale_timeout_in_minutes + 10).minutes.ago }
end

Factory.define :active_user, :parent => :logged_in_user do |f|
  f.last_activity_at { Time.now.utc }
end


# MESSAGES
Factory.define :message do |f|
  f.body 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  f.association :user
  f.kind 'message'
end

Factory.define :login_message, :parent => :message do |f|
  f.kind 'login'
end

Factory.define :logout_message, :parent => :message do |f|
  f.kind 'logout'
end

Factory.define :stale_logout_message, :parent => :message do |f|
  f.kind 'stale_logout'
end

# SEQUENCES
Factory.sequence :email do |n|
  "user#{n}@example.com"
end
