class CreateQqUsers < ActiveRecord::Migration
  def change
    create_table :qq_users do |t|
      t.string :uid
      t.string :name
      t.string :nickname
      t.string :figureurl
      t.string :image
      t.string :token
      t.string :expires
      t.references :user 

      t.timestamps
    end
  end
end
