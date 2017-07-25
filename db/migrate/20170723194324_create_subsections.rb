class CreateSubsections < ActiveRecord::Migration[5.0]
  def change
    create_table :subsections do |t|
      t.string :name
      t.string :order
      t.string :unique_id
      t.references :section, foreign_key: true

      t.timestamps
    end
  end
end
