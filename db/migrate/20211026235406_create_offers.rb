class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.string :category
      t.string :description
      t.string :district
      t.references :user
      t.boolean :status
      t.integer :buyer_id

      t.timestamps
    end
  end
end
