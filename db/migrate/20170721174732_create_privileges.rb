class CreatePrivileges < ActiveRecord::Migration[5.0]
  def change
    create_table :privileges do |t|
      t.string :name
      t.string :level
      t.string :code
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
