class CreateProvinces < ActiveRecord::Migration[8.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :gst
      t.decimal :pst
      t.decimal :hst
      t.decimal :qst

      t.timestamps
    end
  end
end
