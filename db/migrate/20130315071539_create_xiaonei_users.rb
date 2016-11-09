class CreateXiaoneiUsers < ActiveRecord::Migration
  def change
    create_table :xiaonei_users do |t|
      t.string :uid
      t.string :screen_name
      t.string :image
      t.string :image_small
      t.string :token
      t.string :expires
      t.references :user

      t.timestamps
    end
  end
end
