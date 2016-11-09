class CreateCampaignAwardUsers < ActiveRecord::Migration
  def change
    create_table :campaign_award_users do |t|
      t.integer :campaign_id, :null=>false
      t.string  :username
      t.string  :telphone
      t.string  :mark_telphone

      t.timestamps
    end

    add_index :campaign_award_users, :campaign_id
  end
end
