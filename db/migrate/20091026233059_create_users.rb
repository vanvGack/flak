class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :last_activity_at,          :datetime
      t.column :logged_in,                 :boolean, :default => false
    end

    add_index :users, :email, :unique => true
  end

  def self.down
    drop_table "users"
  end
end
