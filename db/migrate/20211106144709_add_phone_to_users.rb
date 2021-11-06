class AddPhoneToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :phone, :integer
    add_column :users, :whatsapp, :boolean, default: true
  end
end
