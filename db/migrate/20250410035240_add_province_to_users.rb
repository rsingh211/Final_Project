class AddProvinceToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :province, foreign_key: true # remove null: false
  end
end
