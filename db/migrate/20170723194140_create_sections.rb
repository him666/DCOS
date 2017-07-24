class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :name
      t.string :order
      t.string :unique_id
      t.references :chapter, foreign_key: true

      t.timestamps
    end
  end
end
