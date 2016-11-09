class AddPositionToTopimages < ActiveRecord::Migration
  def change
    add_column :topimages, :position, :integer, :default =>0
  end
end
