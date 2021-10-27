class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.string :category
      t.references :id_buyer
      t.references :id_seller
      t.boolean :status

      t.timestamps
    end
  end
end
