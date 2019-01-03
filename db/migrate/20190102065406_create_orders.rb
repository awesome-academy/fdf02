class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :customer_name
      t.string :customer_address
      t.string :customer_phone
      t.decimal :total, default: 0
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
