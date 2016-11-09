class CreateWeiboUsers < ActiveRecord::Migration
  def change
    create_table :weibo_users do |t|
      t.string :uid
      t.string :screen_name
      t.string :image
      t.string :image_small
      t.string :token
      t.string :expires
      t.references :user

      t.timestamps
    end
    add_index :weibo_users, :user_id
  end
end
