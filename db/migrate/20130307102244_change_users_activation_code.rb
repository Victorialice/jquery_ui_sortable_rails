class ChangeUsersActivationCode < ActiveRecord::Migration
  def change
    change_column :users, :activation_code, :string
  end
end
