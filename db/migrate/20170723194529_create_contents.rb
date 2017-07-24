class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :code
      t.string :unique_id
      t.string :extra
      t.string :title
      t.string :oftype
      t.references :subsection, foreign_key: true

      t.timestamps
    end
  end
end
