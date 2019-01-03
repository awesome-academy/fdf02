class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :unit_price
      t.decimal :total_price, default: 0
      t.integer :quantity
      t.timestamps
    end
  end
end
