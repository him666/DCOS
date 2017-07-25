class CreateInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :interactions do |t|
      t.text :msg
      t.integer :by_who
      t.string :author
      t.string :oftype
      t.references :content, foreign_key: true

      t.timestamps
    end
  end
end
