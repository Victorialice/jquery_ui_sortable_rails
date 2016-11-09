class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.date :date
      t.string :category
      t.string :title
      t.text :message
      t.string :link
      t.boolean :is_public, default: false

      t.timestamps
    end
  end
end
