class AddAddress2ToCampaignRecords < ActiveRecord::Migration
  def change
    add_column :campaign_records, :postcode, :string
    add_column :campaign_records, :address2, :string
    add_column :campaign_records, :telphone, :string
    add_column :campaign_records, :name, :string
  end
end
