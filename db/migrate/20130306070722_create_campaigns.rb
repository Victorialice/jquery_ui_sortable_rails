class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text   :content
      t.string :image
      t.date   :begin_date
      t.date   :over_date

      t.timestamps
    end
  end
end
