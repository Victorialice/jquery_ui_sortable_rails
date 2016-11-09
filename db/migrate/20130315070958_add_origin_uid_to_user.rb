class AddOriginUidToUser < ActiveRecord::Migration
  def change
    add_column :users, :origin, :string
    add_column :users, :uid, :string
  end
end
