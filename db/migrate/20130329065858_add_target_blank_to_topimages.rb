class AddTargetBlankToTopimages < ActiveRecord::Migration
  def up
    add_column :topimages, :target_blank, :boolean
  end

  def down
    remove_column :topimages, :target_blank
  end
end
