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
  f.last_activity_at { (FLAK['stale_timeout_in_minutes'] + 10).minutes.ago }
end

Factory.define :active_user, :parent => :logged_in_user do |f|
  f.last_activity_at { Time.now.utc }
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end
