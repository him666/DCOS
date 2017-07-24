class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :name
      t.text :index
      t.string :doc
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
