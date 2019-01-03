class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.references :orders, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :unit_price
      t.integer :sum_price
      t.integer :quantity
      t.timestamps
    end
  end
end
