class CreateChapters < ActiveRecord::Migration[5.0]
  def change
    create_table :chapters do |t|
      t.string :name
      t.string :number
      t.string :unique_id
      t.references :document, foreign_key: true

      t.timestamps
    end
  end
end
