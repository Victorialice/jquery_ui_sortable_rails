class CreateCampaignRecords < ActiveRecord::Migration
  def change
    create_table :campaign_records do |t|
      t.integer :user_id,     :null =>false
      t.integer :campaign_id, :null =>false

      t.timestamps
    end

    add_index :campaign_records, [:user_id, :campaign_id]
    add_index :campaign_records, [:campaign_id, :user_id]
  end
end
