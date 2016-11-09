class AddResetPwdTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_pwd_token, :string
    add_column :users, :reset_pwd_state, :boolean, :default =>0
  end
end
