class AddPhoneToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :phone, :string
    add_column :users, :whatsapp, :boolean, default: false
  end
end
