class CreateTopimages < ActiveRecord::Migration
  def change
    create_table :topimages do |t|
      t.string :image
      t.string :linkurl
      t.timestamps
    end
  end
end
