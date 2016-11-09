class CreateLoginLogs < ActiveRecord::Migration
  def change
    create_table :login_logs do |t|
      t.string :ip
      t.integer :user_id

      t.timestamps
    end
  end
end
