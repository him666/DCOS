class CreateResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :responses do |t|
      t.text :msg
      t.integer :by_who
      t.string :author
      t.string :oftype
      t.references :interaction, foreign_key: true

      t.timestamps
    end
  end
end
