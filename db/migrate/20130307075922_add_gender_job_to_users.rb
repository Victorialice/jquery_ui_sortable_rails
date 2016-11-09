class AddGenderJobToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :boolean
    add_column :users, :job   , :string
    add_column :users, :postcode, :string
    add_column :users, :detail_address, :string
    add_column :users, :telphone, :string
  end
end
