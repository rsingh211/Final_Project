class CreateBeats < ActiveRecord::Migration[8.0]
  def change
    create_table :beats do |t|
      t.string :title
      t.text :description
      t.string :genre
      t.decimal :price
      t.string :license_type

      t.timestamps
    end
  end
end
