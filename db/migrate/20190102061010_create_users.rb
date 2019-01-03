class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, unique: true
      t.string :email, unique: true
      t.string :address
      t.string :phone
      t.integer :role, nil: false, default: 0
      t.timestamps
    end
  end
end
