class AddLoginKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_key, :string
    add_column :users, :key_expire_at, :datetime
    User.all.each{|u|u.generate_login_key}
  end
end
