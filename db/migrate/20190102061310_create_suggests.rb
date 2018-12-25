class CreateSuggests < ActiveRecord::Migration[5.1]
  def change
    create_table :suggests do |t|
      t.string :content
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
