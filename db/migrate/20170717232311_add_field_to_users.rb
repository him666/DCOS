class AddFieldToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :society, :string
    add_column :users, :telephone, :string
  end
end
